import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/niva_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/operating_mode.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';
import '../../../shared/widgets/niva_status_badge.dart';
import '../../../shared/widgets/niva_symbol.dart';

/// You (Profile / Hub) Screen (Destination 5)
class YouScreen extends ConsumerWidget {
  const YouScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(operatingModeProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const NivaAppBar(
        title: 'You',
        subtitle: 'Profile, Workspaces & Settings',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Card
            NivaCard(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: NivaColors.deepNavy,
                    child: const NivaSymbol(size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mode == OperatingMode.guest
                              ? 'Guest User'
                              : 'Authorized User',
                          style: NivaTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (mode == OperatingMode.guest)
                          NivaStatusBadge.guest()
                        else
                          NivaStatusBadge.registered(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Navigation Sections
            _buildSectionHeader('FINANCIAL MANAGEMENT'),
            _buildSettingsTile(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Money Accounts',
              subtitle: 'Bank accounts, cash, UPI stored value',
              onTap: () => context.push(RouteNames.accounts),
            ),
            _buildSettingsTile(
              icon: Icons.call_split_outlined,
              title: 'Split Bills & Participants',
              subtitle: 'Who paid, shares, and repayment states',
              onTap: () => context.push(RouteNames.splits),
            ),
            _buildSettingsTile(
              icon: Icons.history_edu_outlined,
              title: 'Settlements',
              subtitle: 'Track repayments without duplicating income',
              onTap: () => context.push(RouteNames.settlements),
            ),
            _buildSettingsTile(
              icon: Icons.apartment_outlined,
              title: 'Workspaces',
              subtitle: 'Personal, Household, Business boundaries',
              onTap: () => context.push(RouteNames.workspaces),
            ),
            const SizedBox(height: 16),

            _buildSectionHeader('SECURITY & DATA PRIVACY'),
            _buildSettingsTile(
              icon: Icons.lock_outline,
              title: 'App Lock & Biometrics',
              subtitle: 'Protect local access on this device',
              onTap: () => context.push(RouteNames.securitySettings),
            ),
            _buildSettingsTile(
              icon: Icons.backup_outlined,
              title: 'Encrypted Backup & Restore',
              subtitle: 'Export device-local encrypted archive',
              onTap: () => context.push(RouteNames.guestBackup),
            ),
            _buildSettingsTile(
              icon: Icons.settings_outlined,
              title: 'Application Preferences',
              subtitle: 'Theme, language, and RAAZ assistance level',
              onTap: () => context.push(RouteNames.settings),
            ),
            const SizedBox(height: 24),

            // Mode Switching / Reset
            if (mode == OperatingMode.guest)
              OutlinedButton.icon(
                onPressed: () => context.push(RouteNames.signUp),
                icon: const Icon(Icons.cloud_upload_outlined, size: 18),
                label: const Text('Upgrade to Registered Mode'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              )
            else
              TextButton(
                onPressed: () {
                  ref
                      .read(operatingModeProvider.notifier)
                      .setMode(OperatingMode.guest);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Switched to Guest Mode.')),
                  );
                },
                child: const Text('Switch to Guest Mode'),
              ),
            const SizedBox(height: 16),

            // Footer branding
            Text(
              '${AppConstants.appName} v1.0.0 (Phase 1 Bootstrap)',
              style: NivaTypography.labelSmall.copyWith(
                color: isDark
                    ? NivaColors.platinum.withValues(alpha: 0.6)
                    : null,
              ),
            ),
            Text(
              'Local-first · Privacy-first · RAAZ ML companion',
              style: NivaTypography.labelSmall.copyWith(
                color: isDark
                    ? NivaColors.platinum.withValues(alpha: 0.4)
                    : null,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8, top: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: NivaTypography.labelSmall.copyWith(
            color: NivaColors.electricCyan,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: NivaCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: NivaColors.deepNavy.withValues(alpha: 0.15),
              child: Icon(icon, color: NivaColors.electricCyan, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: NivaTypography.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: NivaTypography.bodySmall.copyWith(
                      color: NivaColors.platinum,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: NivaColors.platinum,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
