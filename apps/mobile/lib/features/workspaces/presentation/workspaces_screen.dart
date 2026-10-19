import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app_providers.dart';
import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/operating_mode.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';

/// Workspaces Screen:
/// - Personal, Household, Business scopes
/// - Clear ownership boundaries
class WorkspacesScreen extends ConsumerWidget {
  const WorkspacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(operatingModeProvider);

    return Scaffold(
      appBar: const NivaAppBar(
        title: 'Workspaces',
        subtitle: 'Personal, Household & Business',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Boundary description card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: NivaColors.deepNavy.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: NivaColors.platinum.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.security,
                  size: 18,
                  color: NivaColors.electricCyan,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Workspace Rule: Workspaces classify permitted transactions but never duplicate money balances. Household and Business workspaces require Registered Mode authorization.',
                    style: NivaTypography.bodySmall.copyWith(
                      color: NivaColors.platinum,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _buildWorkspaceCard(
            title: 'Personal Workspace',
            subtitle: 'Personal accounts, daily spending, goals, and private settlements.',
            icon: Icons.person,
            isActive: true,
            isLocked: false,
            badge: 'Active',
            onTap: () {},
          ),
          const SizedBox(height: 12),

          _buildWorkspaceCard(
            title: 'Household Workspace',
            subtitle: 'Authorized shared expenses, family contributions, and utility bills.',
            icon: Icons.home,
            isActive: false,
            isLocked: mode == OperatingMode.guest,
            badge: mode == OperatingMode.guest ? 'Registered Only' : 'Switch',
            onTap: () {
              if (mode == OperatingMode.guest) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Household sharing requires Registered Mode identity authorization.',
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 12),

          _buildWorkspaceCard(
            title: 'Business Workspace',
            subtitle: 'Sales, customer receivables, supplier obligations, and inventory records.',
            icon: Icons.storefront,
            isActive: false,
            isLocked: mode == OperatingMode.guest,
            badge: mode == OperatingMode.guest ? 'Registered Only' : 'Switch',
            onTap: () {
              if (mode == OperatingMode.guest) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Business ledger requires Registered Mode identity authorization.',
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWorkspaceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isActive,
    required bool isLocked,
    required String badge,
    required VoidCallback onTap,
  }) {
    return NivaCard(
      onTap: onTap,
      borderColor: isActive ? NivaColors.electricCyan : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: isActive
                    ? NivaColors.deepNavy
                    : NivaColors.deepNavy.withValues(alpha: 0.15),
                child: Icon(
                  icon,
                  color: isActive
                      ? NivaColors.electricCyan
                      : NivaColors.platinum,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(title, style: NivaTypography.titleMedium)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isActive
                      ? NivaColors.teal.withValues(alpha: 0.15)
                      : NivaColors.platinum.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badge,
                  style: NivaTypography.labelSmall.copyWith(
                    color: isActive ? NivaColors.teal : NivaColors.platinum,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: NivaTypography.bodySmall.copyWith(
              color: NivaColors.platinum,
            ),
          ),
        ],
      ),
    );
  }
}
