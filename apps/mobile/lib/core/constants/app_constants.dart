/// Core application and product constants for NIVA.
///
/// Follows established architectural decisions from `docs/architecture/DECISIONS.md`:
/// - NIVA-ARCH-001: NIVA = Neural Intelligent Virtual Assistant
/// - NIVA-ARCH-002: RAAZ is integrated ML companion, not a separate wallet
/// - NIVA-ARCH-003: Guest Mode device-only authority
/// - NIVA-ARCH-004: Registered backend ledger authority
/// - NIVA-ARCH-008: RAAZ trained from scratch, no pretrained weights or external AI
/// - NIVA-ARCH-012: Manual transaction recording, not real bank/UPI transfer
/// - NIVA-ARCH-013: Minor access disabled (18+ initial eligibility)
abstract final class AppConstants {
  static const String appName = 'NIVA';
  static const String appFullName = 'Neural Intelligent Virtual Assistant';
  static const String appTagline =
      'Your Money. Your Intelligence. Your Future.';

  /// Minimum age for initial release eligibility.
  /// Users aged 15-17 require future separate legal and guardian consent approval.
  static const int minimumEligibilityAge = 18;

  /// Default currency code for initial launch.
  static const String defaultCurrencyCode = 'INR';
  static const String defaultCurrencySymbol = '₹';

  /// Scale factor for converting major units to minor integer units (1 INR = 100 paise).
  /// Invariant: Ledger balances MUST always use integer minor units, never floating-point.
  static const int minorUnitsPerMajor = 100;

  /// Explicit UI label for manual transfers as mandated by product rules.
  /// Transfers between user's own accounts never execute real bank money movement.
  static const String recordTransferLabel = 'Record Transfer';

  /// Disclaimer for conversational assistant.
  static const String raazDisclaimer =
      'RAAZ prepares structured suggestions and explanations based on deterministic financial services. '
      'It does not independently authorize or commit financial transactions.';

  /// Disclaimer for payment execution boundaries.
  static const String paymentBoundaryDisclaimer =
      'NIVA records observed financial activity reported by the user. '
      'It does not execute real bank or UPI payments.';
}
