/// NIVA Operating Mode representing the boundary between local and cloud authority.
///
/// Follows architectural decisions NIVA-ARCH-003 and NIVA-ARCH-004:
/// - Guest: Device-local encrypted authority. Zero silent background network upload.
/// - Registered: Backend ledger authoritative sync. Multi-device and shared workspaces.
enum OperatingMode {
  guest(
    displayName: 'Guest Mode',
    shortDescription: 'Device-local authoritative records',
    isLocalOnly: true,
  ),
  registered(
    displayName: 'Registered Mode',
    shortDescription: 'Backend-authoritative synchronized records',
    isLocalOnly: false,
  );

  const OperatingMode({
    required this.displayName,
    required this.shortDescription,
    required this.isLocalOnly,
  });

  final String displayName;
  final String shortDescription;
  final bool isLocalOnly;
}
