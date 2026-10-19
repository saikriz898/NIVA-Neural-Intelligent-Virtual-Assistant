import 'package:flutter/material.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';

/// App Security & Local Privacy Settings Screen.
class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _requireBiometrics = true;
  bool _maskBalancesInAppSwitcher = true;
  bool _requireAuthForTransfers = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NivaAppBar(
        title: 'Security & App Lock',
        subtitle: 'Local Device Protection',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          NivaCard(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Biometric / PIN App Lock'),
                  subtitle: const Text(
                    'Require fingerprint, face, or device PIN to open NIVA',
                  ),
                  value: _requireBiometrics,
                  activeThumbColor: NivaColors.electricCyan,
                  onChanged: (val) => setState(() => _requireBiometrics = val),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Mask Balances in App Switcher'),
                  subtitle: const Text(
                    'Hide financial numbers when switching apps',
                  ),
                  value: _maskBalancesInAppSwitcher,
                  activeThumbColor: NivaColors.electricCyan,
                  onChanged: (val) =>
                      setState(() => _maskBalancesInAppSwitcher = val),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Confirm Before Saving Transfers'),
                  subtitle: const Text(
                    'Prompt biometric authorization before recording manual transfers',
                  ),
                  value: _requireAuthForTransfers,
                  activeThumbColor: NivaColors.electricCyan,
                  onChanged: (val) =>
                      setState(() => _requireAuthForTransfers = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Security Baseline: NIVA encrypts local financial databases at rest using platform keystore-backed keys. '
              'NIVA never requests or stores UPI PINs, bank passwords, or debit card CVVs.',
              style: NivaTypography.bodySmall.copyWith(
                color: NivaColors.platinum,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
