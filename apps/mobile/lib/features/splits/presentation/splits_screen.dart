import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';
import '../../../shared/widgets/niva_status_badge.dart';

/// Splits Screen:
/// - List of split group expenses
/// - Highlights who paid original bill, participant shares, and partial repayments
class SplitsScreen extends StatelessWidget {
  const SplitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NivaAppBar(
        title: 'Split Expenses',
        subtitle: 'Participants & Partial Repayments',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'New Split',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Split creation dialog.')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Informational rule banner
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
                  Icons.info_outline,
                  size: 18,
                  color: NivaColors.teal,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Rule: Repayments reduce outstanding receivables; they are linked to the original split and NEVER counted as new income.',
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

          // Primary Example Split Bill Card
          NivaCard(
            onTap: () => context.push('/splits/split-101'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Team Dinner Split',
                      style: NivaTypography.titleMedium,
                    ),
                    NivaStatusBadge.partiallyPaid(),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Original Bill: ₹1,200.00 · Oct 17, 2026',
                  style: NivaTypography.bodySmall.copyWith(
                    color: NivaColors.platinum,
                  ),
                ),
                const Divider(height: 20),
                Text(
                  'Paid by: You (Axis Bank)',
                  style: NivaTypography.labelSmall.copyWith(
                    color: NivaColors.electricCyan,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your share (1/4): ₹300.00',
                      style: NivaTypography.bodySmall,
                    ),
                    Text(
                      'Owed to you: ₹600.00 / ₹900.00',
                      style: NivaTypography.labelSmall.copyWith(
                        color: NivaColors.warning,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 300 / 900, // 33% repaid
                    minHeight: 6,
                    backgroundColor: NivaColors.platinum.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      NivaColors.teal,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Dinesh repaid ₹300.00 · Suresh & Priya pending (₹300 each)',
                  style: NivaTypography.bodySmall.copyWith(
                    color: NivaColors.platinum,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          NivaCard(
            onTap: () => context.push('/splits/split-102'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Weekend Road Trip Fuel',
                      style: NivaTypography.titleMedium,
                    ),
                    NivaStatusBadge.settled(),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Original Bill: ₹2,400.00 · Oct 12, 2026',
                  style: NivaTypography.bodySmall.copyWith(
                    color: NivaColors.platinum,
                  ),
                ),
                const Divider(height: 20),
                Text(
                  'Paid by: Ramesh (Shared equally by 4)',
                  style: NivaTypography.labelSmall.copyWith(
                    color: NivaColors.platinum,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your share: ₹600.00',
                      style: NivaTypography.bodySmall,
                    ),
                    NivaStatusBadge.paid(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
