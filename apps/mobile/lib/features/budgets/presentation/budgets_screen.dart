import 'package:flutter/material.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';

/// Budgets management screen.
class BudgetsScreen extends StatelessWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NivaAppBar(
        title: 'Budgets',
        subtitle: 'Monthly Spending Limits',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create Budget',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Budget limit creator.')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBudgetTile(
            category: 'Food & Dining',
            spent: const FinancialAmount(650000), // ₹6,500.00
            limit: const FinancialAmount(1000000), // ₹10,000.00
            color: NivaColors.electricCyan,
          ),
          const SizedBox(height: 12),
          _buildBudgetTile(
            category: 'Transport & Fuel',
            spent: const FinancialAmount(320000), // ₹3,200.00
            limit: const FinancialAmount(400000), // ₹4,000.00
            color: NivaColors.warning,
          ),
          const SizedBox(height: 12),
          _buildBudgetTile(
            category: 'Entertainment & Subscriptions',
            spent: const FinancialAmount(150000), // ₹1,500.00
            limit: const FinancialAmount(300000), // ₹3,000.00
            color: NivaColors.teal,
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetTile({
    required String category,
    required FinancialAmount spent,
    required FinancialAmount limit,
    required Color color,
  }) {
    final progress = spent.minorUnits / limit.minorUnits;

    return NivaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category, style: NivaTypography.titleMedium),
              Text(
                '${(progress * 100).toInt()}% used',
                style: NivaTypography.labelSmall.copyWith(
                  color: progress > 0.8 ? NivaColors.warning : NivaColors.teal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${spent.format()} spent of ${limit.format()}',
            style: NivaTypography.bodySmall.copyWith(
              color: NivaColors.platinum,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: NivaColors.platinum.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
