/// Core failure and error abstractions for NIVA.
///
/// Designed to represent deterministic operational outcomes cleanly.
abstract class AppFailure implements Exception {
  const AppFailure(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => '$runtimeType: $message (code: $code)';
}

/// Thrown or returned when user eligibility requirements are not satisfied.
/// Initial release enforces 18+ requirement until minor protection approvals.
class EligibilityFailure extends AppFailure {
  const EligibilityFailure([
    super.message =
        'NIVA initial release is restricted to users aged 18 and older.',
    String code = 'ELIGIBILITY_AGE_RESTRICTED',
  ]) : super(code: code);
}

/// Thrown when input validation fails.
class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message, {super.code = 'VALIDATION_FAILED'});
}

/// Thrown when local encrypted database operations fail.
class StorageFailure extends AppFailure {
  const StorageFailure(super.message, {super.code = 'STORAGE_ERROR'});
}

/// Thrown when an offline operation requires active synchronization.
class OfflineSyncFailure extends AppFailure {
  const OfflineSyncFailure(
    super.message, {
    String code = 'OFFLINE_SYNC_PENDING',
  }) : super(code: code);
}

/// Thrown when an unauthorized action is attempted in Registered Mode.
class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure([
    super.message = 'You do not have permission to access this resource.',
    String code = 'UNAUTHORIZED',
  ]) : super(code: code);
}
