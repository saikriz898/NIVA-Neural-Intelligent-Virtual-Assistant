import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/niva_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';

/// Application Preferences and General Settings Screen.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: const NivaAppBar(
        title: 'Settings',
        subtitle: 'Preferences & Configuration',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'APPEARANCE',
            style: NivaTypography.labelSmall.copyWith(
              color: NivaColors.electricCyan,
            ),
          ),
          const SizedBox(height: 8),
          NivaCard(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    themeMode == ThemeMode.system
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: themeMode == ThemeMode.system
                        ? NivaColors.electricCyan
                        : NivaColors.platinum,
                  ),
                  title: const Text('System Default'),
                  onTap: () {
                    ref
                        .read(themeModeProvider.notifier)
                        .setMode(ThemeMode.system);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    themeMode == ThemeMode.dark
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: themeMode == ThemeMode.dark
                        ? NivaColors.electricCyan
                        : NivaColors.platinum,
                  ),
                  title: const Text('Dark Mode (Midnight & Deep Navy)'),
                  onTap: () {
                    ref
                        .read(themeModeProvider.notifier)
                        .setMode(ThemeMode.dark);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    themeMode == ThemeMode.light
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: themeMode == ThemeMode.light
                        ? NivaColors.electricCyan
                        : NivaColors.platinum,
                  ),
                  title: const Text('Light Mode (Porcelain)'),
                  onTap: () {
                    ref
                        .read(themeModeProvider.notifier)
                        .setMode(ThemeMode.light);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'DATA & SECURITY',
            style: NivaTypography.labelSmall.copyWith(
              color: NivaColors.electricCyan,
            ),
          ),
          const SizedBox(height: 8),
          NivaCard(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.lock_outline,
                    color: NivaColors.electricCyan,
                  ),
                  title: const Text('App Lock & Biometrics'),
                  subtitle: const Text(
                    'Require fingerprint or PIN upon app resume',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(RouteNames.securitySettings),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.backup_outlined,
                    color: NivaColors.electricCyan,
                  ),
                  title: const Text('Encrypted Backup & Recovery'),
                  subtitle: const Text(
                    'Export password-protected device backup',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.push(RouteNames.guestBackup),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'RAAZ COMPANION',
            style: NivaTypography.labelSmall.copyWith(
              color: NivaColors.electricCyan,
            ),
          ),
          const SizedBox(height: 8),
          NivaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.auto_awesome,
                    color: NivaColors.teal,
                  ),
                  title: const Text('Assistance Level'),
                  subtitle: const Text('Standard (Suggestions + Explanations)'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    'RAAZ ML models are trained from scratch without external foundation APIs or telemetry by default.',
                    style: NivaTypography.bodySmall.copyWith(
                      color: NivaColors.platinum,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'ABOUT NIVA',
            style: NivaTypography.labelSmall.copyWith(
              color: NivaColors.electricCyan,
            ),
          ),
          const SizedBox(height: 8),
          NivaCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(AppConstants.appFullName),
                  subtitle: const Text('Version 1.0.0-phase1-bootstrap'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    'A privacy-first, local-first financial management platform.\n'
                    'Official repository: github.com/saikriz898/NIVA-Neural-Intelligent-Virtual-Assistant',
                    style: NivaTypography.bodySmall.copyWith(
                      color: NivaColors.platinum,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
