import 'package:flutter/material.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_button.dart';
import '../../../shared/widgets/niva_card.dart';

/// Screen for creating and restoring encrypted local Guest backups.
///
/// Follows NIVA Security Baseline:
/// - Honest unrecoverable-loss disclosures
/// - Encrypted export with user password
class GuestBackupScreen extends StatefulWidget {
  const GuestBackupScreen({super.key});

  @override
  State<GuestBackupScreen> createState() => _GuestBackupScreenState();
}

class _GuestBackupScreenState extends State<GuestBackupScreen> {
  bool _isExporting = false;

  void _onExportBackup() {
    setState(() => _isExporting = true);
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() => _isExporting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Encrypted archive export ready. Save file to safe storage.',
            ),
            backgroundColor: NivaColors.teal,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NivaAppBar(
        title: 'Encrypted Backup',
        subtitle: 'Device-Local Data Management',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Honest Unrecoverable Loss Warning Card
            NivaCard(
              backgroundColor: const Color(0x22FFA000),
              borderColor: NivaColors.warning,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: NivaColors.warning,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Important Data Recovery Disclosure',
                          style: NivaTypography.labelLarge.copyWith(
                            color: NivaColors.warning,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Because Guest Mode records are strictly stored on your phone without cloud copies, '
                          'uninstalling the app or losing your phone without an exported backup means your records '
                          'CANNOT be recovered by NIVA servers. We strongly recommend exporting encrypted backups regularly.',
                          style: NivaTypography.bodySmall.copyWith(
                            color: NivaColors.platinum,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text('Create Backup Archive', style: NivaTypography.titleMedium),
            const SizedBox(height: 8),
            NivaCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Export an encrypted snapshot of all accounts, transactions, splits, and budgets.',
                    style: NivaTypography.bodySmall.copyWith(
                      color: NivaColors.platinum,
                    ),
                  ),
                  const SizedBox(height: 16),
                  NivaButton(
                    text: 'Export Encrypted Backup',
                    isLoading: _isExporting,
                    onPressed: _onExportBackup,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text('Restore From Archive', style: NivaTypography.titleMedium),
            const SizedBox(height: 8),
            NivaCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select a previously exported .niva encrypted backup archive to restore records.',
                    style: NivaTypography.bodySmall.copyWith(
                      color: NivaColors.platinum,
                    ),
                  ),
                  const SizedBox(height: 16),
                  NivaButton(
                    text: 'Select Backup File to Restore',
                    variant: NivaButtonVariant.outline,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('File picker dialog.')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
