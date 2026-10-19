import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';

/// Plans Screen (Destination 4):
/// - Budgets overview (category limits, reserved vs spent)
/// - Savings goals & allocations
/// - Recurring commitments & bills due
class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NivaAppBar(
        title: 'Plans',
        subtitle: 'Budgets, Goals & Commitments',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Budget / Goal',
            onPressed: () => context.push(RouteNames.budgets),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reserved money vs Spent note
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
                    color: NivaColors.electricCyan,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Invariant: Reserved goal money is earmarked in plans; it does not generate fictitious bank transactions.',
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

            // Budgets Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly Budgets',
                  style: NivaTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                  onPressed: () => context.push(RouteNames.budgets),
                  child: const Text('Manage'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _BudgetProgressBar(
              category: 'Food & Dining',
              spent: const FinancialAmount(650000), // ₹6,500.00
              limit: const FinancialAmount(1000000), // ₹10,000.00
              progress: 0.65,
              color: NivaColors.electricCyan,
            ),
            const SizedBox(height: 12),
            _BudgetProgressBar(
              category: 'Transport & Fuel',
              spent: const FinancialAmount(320000), // ₹3,200.00
              limit: const FinancialAmount(400000), // ₹4,000.00
              progress: 0.80,
              color: NivaColors.warning,
            ),
            const SizedBox(height: 24),

            // Savings Goals Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Savings Goals',
                  style: NivaTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton(
                  onPressed: () => context.push(RouteNames.goals),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _GoalCard(
              title: 'Emergency Fund (6 Months)',
              allocated: const FinancialAmount(15000000), // ₹1,50,000.00
              target: const FinancialAmount(30000000), // ₹3,00,000.00
              progress: 0.50,
            ),
            const SizedBox(height: 12),
            _GoalCard(
              title: 'Annual Insurance Premium',
              allocated: const FinancialAmount(1800000), // ₹18,000.00
              target: const FinancialAmount(2400000), // ₹24,000.00
              progress: 0.75,
            ),
            const SizedBox(height: 24),

            // Recurring commitments
            Text(
              'Upcoming Commitments',
              style: NivaTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            NivaCard(
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0x2200D6A3),
                    child: Icon(Icons.wifi, color: NivaColors.teal, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Broadband Internet',
                          style: NivaTypography.titleSmall,
                        ),
                        Text(
                          'Due in 4 days · Oct 22',
                          style: NivaTypography.bodySmall.copyWith(
                            color: NivaColors.platinum,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    const FinancialAmount(99900).format(), // ₹999.00
                    style: NivaTypography.financialAmount,
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

class _BudgetProgressBar extends StatelessWidget {
  const _BudgetProgressBar({
    required this.category,
    required this.spent,
    required this.limit,
    required this.progress,
    required this.color,
  });

  final String category;
  final FinancialAmount spent;
  final FinancialAmount limit;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return NivaCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category, style: NivaTypography.titleSmall),
              Text(
                '${spent.format()} / ${limit.format()}',
                style: NivaTypography.labelSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: NivaColors.platinum.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.title,
    required this.allocated,
    required this.target,
    required this.progress,
  });

  final String title;
  final FinancialAmount allocated;
  final FinancialAmount target;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return NivaCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: NivaTypography.titleSmall),
              Text(
                '${(progress * 100).toInt()}%',
                style: NivaTypography.labelSmall.copyWith(
                  color: NivaColors.teal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${allocated.format()} allocated of ${target.format()}',
            style: NivaTypography.bodySmall.copyWith(
              color: NivaColors.platinum,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: NivaColors.platinum.withValues(alpha: 0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(NivaColors.teal),
            ),
          ),
        ],
      ),
    );
  }
}
