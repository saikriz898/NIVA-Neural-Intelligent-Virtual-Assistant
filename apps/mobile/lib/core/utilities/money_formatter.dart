import '../constants/app_constants.dart';

/// Financial money formatter that strictly uses integer minor units (e.g. paise / cents).
///
/// Invariant: Floating-point types (`double`) MUST NEVER be used for financial arithmetic
/// or ledger balances in NIVA to prevent precision loss.
abstract final class MoneyFormatter {
  /// Format integer minor units (e.g. 120000 paise -> "₹1,200.00").
  static String format(
    int minorUnits, {
    String currencySymbol = AppConstants.defaultCurrencySymbol,
    bool showSign = false,
  }) {
    final isNegative = minorUnits < 0;
    final absMinor = minorUnits.abs();

    final major = absMinor ~/ AppConstants.minorUnitsPerMajor;
    final minor = absMinor % AppConstants.minorUnitsPerMajor;

    final formattedMajor = _formatIndianGrouping(major);
    final formattedMinor = minor.toString().padLeft(2, '0');

    final sign = isNegative ? '-' : (showSign && minorUnits > 0 ? '+' : '');

    return '$sign$currencySymbol$formattedMajor.$formattedMinor';
  }

  /// Format major integer numbers using standard Indian numbering system (e.g. 12,34,567).
  static String _formatIndianGrouping(int number) {
    final str = number.toString();
    if (str.length <= 3) return str;

    // Last 3 digits
    final lastThree = str.substring(str.length - 3);
    final remaining = str.substring(0, str.length - 3);

    // Group remaining in pairs of 2
    final buffer = StringBuffer();
    for (var i = 0; i < remaining.length; i++) {
      if (i > 0 && (remaining.length - i) % 2 == 0) {
        buffer.write(',');
      }
      buffer.write(remaining[i]);
    }
    buffer.write(',');
    buffer.write(lastThree);

    return buffer.toString();
  }

  /// Parse major and optional minor string to integer minor units safely without `double.parse()`.
  /// Returns null if format is invalid.
  static int? tryParseToMinorUnits(String input) {
    final trimmed = input.trim().replaceAll(',', '').replaceAll('₹', '');
    if (trimmed.isEmpty) return null;

    final parts = trimmed.split('.');
    if (parts.length > 2) return null;

    final majorPart = int.tryParse(parts[0]);
    if (majorPart == null) return null;

    var minorPart = 0;
    if (parts.length == 2) {
      final minorStr = parts[1];
      if (minorStr.length == 1) {
        final parsed = int.tryParse(minorStr);
        if (parsed == null) return null;
        minorPart = parsed * 10;
      } else if (minorStr.length == 2) {
        final parsed = int.tryParse(minorStr);
        if (parsed == null) return null;
        minorPart = parsed;
      } else {
        // More than 2 decimal digits not supported in minor unit currencies like INR
        return null;
      }
    }

    final isNegative = trimmed.startsWith('-');
    final total =
        (majorPart.abs() * AppConstants.minorUnitsPerMajor) + minorPart;
    return isNegative ? -total : total;
  }
}
