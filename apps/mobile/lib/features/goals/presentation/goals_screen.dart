import 'package:flutter/material.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';

/// Goals Screen: Savings targets and reserved financial allocations.
class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NivaAppBar(
        title: 'Savings Goals',
        subtitle: 'Target Allocations',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'New Goal',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Create savings goal dialog.')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildGoalCard(
            title: 'Emergency Fund',
            target: const FinancialAmount(30000000), // ₹3,00,000.00
            allocated: const FinancialAmount(15000000), // ₹1,50,000.00
            targetDate: 'Dec 2026',
          ),
          const SizedBox(height: 12),
          _buildGoalCard(
            title: 'Annual Insurance',
            target: const FinancialAmount(2400000), // ₹24,000.00
            allocated: const FinancialAmount(1800000), // ₹18,000.00
            targetDate: 'Nov 2026',
          ),
          const SizedBox(height: 12),
          _buildGoalCard(
            title: 'Laptop Upgrade',
            target: const FinancialAmount(8000000), // ₹80,000.00
            allocated: const FinancialAmount(2000000), // ₹20,000.00
            targetDate: 'Mar 2027',
          ),
        ],
      ),
    );
  }

  Widget _buildGoalCard({
    required String title,
    required FinancialAmount target,
    required FinancialAmount allocated,
    required String targetDate,
  }) {
    final progress = allocated.minorUnits / target.minorUnits;

    return NivaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: NivaTypography.titleMedium),
              Text(
                'Target: $targetDate',
                style: NivaTypography.labelSmall.copyWith(
                  color: NivaColors.platinum,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${allocated.format()} saved of ${target.format()}',
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
              valueColor: const AlwaysStoppedAnimation<Color>(NivaColors.teal),
            ),
          ),
        ],
      ),
    );
  }
}
