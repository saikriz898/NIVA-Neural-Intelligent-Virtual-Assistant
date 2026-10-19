import 'package:flutter/foundation.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utilities/money_formatter.dart';

/// Immutable domain value object representing an exact currency amount in minor units.
///
/// Follows financial invariant:
/// - Never use floating-point types for ledger arithmetic.
/// - Minor units (e.g. 100 paise = 1 INR) preserve exact decimal precision.
@immutable
class FinancialAmount implements Comparable<FinancialAmount> {
  const FinancialAmount(
    this.minorUnits, {
    this.currencyCode = AppConstants.defaultCurrencyCode,
  });

  /// Factory from major units without float rounding issues.
  factory FinancialAmount.fromMajor(
    int majorUnits, {
    int minorUnits = 0,
    String currencyCode = AppConstants.defaultCurrencyCode,
  }) {
    final totalMinor =
        (majorUnits * AppConstants.minorUnitsPerMajor) + minorUnits;
    return FinancialAmount(totalMinor, currencyCode: currencyCode);
  }

  /// Zero amount helper.
  static const FinancialAmount zero = FinancialAmount(0);

  final int minorUnits;
  final String currencyCode;

  bool get isNegative => minorUnits < 0;
  bool get isPositive => minorUnits > 0;
  bool get isZero => minorUnits == 0;

  FinancialAmount abs() =>
      FinancialAmount(minorUnits.abs(), currencyCode: currencyCode);

  FinancialAmount operator +(FinancialAmount other) {
    _assertMatchingCurrency(other);
    return FinancialAmount(
      minorUnits + other.minorUnits,
      currencyCode: currencyCode,
    );
  }

  FinancialAmount operator -(FinancialAmount other) {
    _assertMatchingCurrency(other);
    return FinancialAmount(
      minorUnits - other.minorUnits,
      currencyCode: currencyCode,
    );
  }

  FinancialAmount operator -() =>
      FinancialAmount(-minorUnits, currencyCode: currencyCode);

  FinancialAmount operator *(int multiplier) =>
      FinancialAmount(minorUnits * multiplier, currencyCode: currencyCode);

  void _assertMatchingCurrency(FinancialAmount other) {
    assert(
      currencyCode == other.currencyCode,
      'Cannot combine amounts with different currencies: $currencyCode vs ${other.currencyCode}',
    );
  }

  @override
  int compareTo(FinancialAmount other) {
    _assertMatchingCurrency(other);
    return minorUnits.compareTo(other.minorUnits);
  }

  bool operator <(FinancialAmount other) => compareTo(other) < 0;
  bool operator <=(FinancialAmount other) => compareTo(other) <= 0;
  bool operator >(FinancialAmount other) => compareTo(other) > 0;
  bool operator >=(FinancialAmount other) => compareTo(other) >= 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinancialAmount &&
          runtimeType == other.runtimeType &&
          minorUnits == other.minorUnits &&
          currencyCode == other.currencyCode;

  @override
  int get hashCode => minorUnits.hashCode ^ currencyCode.hashCode;

  /// Formatted presentation string (e.g. "₹1,200.00").
  String format({bool showSign = false}) {
    return MoneyFormatter.format(
      minorUnits,
      currencySymbol: currencyCode == 'INR'
          ? AppConstants.defaultCurrencySymbol
          : '$currencyCode ',
      showSign: showSign,
    );
  }

  @override
  String toString() => format();
}
