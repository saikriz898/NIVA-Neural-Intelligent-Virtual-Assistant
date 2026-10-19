import 'package:flutter/material.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';
import '../../../shared/widgets/niva_status_badge.dart';

/// Settlements Screen:
/// - Records repayments of split expenses and debt obligations
/// - Key rule: Settlements link to original splits/debts and NEVER duplicate income.
class SettlementsScreen extends StatelessWidget {
  const SettlementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NivaAppBar(
        title: 'Settlements',
        subtitle: 'Receivables & Repayment History',
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          NivaCard(
            backgroundColor: NivaColors.deepNavy.withValues(alpha: 0.15),
            child: Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet,
                  color: NivaColors.teal,
                  size: 24,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Outstanding Receivables',
                        style: NivaTypography.titleSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        const FinancialAmount(60000).format(), // ₹600.00
                        style: NivaTypography.financialDisplay.copyWith(
                          color: NivaColors.warning,
                        ),
                      ),
                      Text(
                        'Money owed to you from 2 participants across 1 active split.',
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
          const SizedBox(height: 20),

          Text(
            'Settlement History',
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
                  child: Icon(Icons.check, color: NivaColors.teal, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Repayment from Dinesh',
                        style: NivaTypography.titleSmall,
                      ),
                      Text(
                        'Linked to "Team Dinner Split" · Oct 18',
                        style: NivaTypography.bodySmall.copyWith(
                          color: NivaColors.platinum,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 4),
                      NivaStatusBadge(label: 'Linked Settlement'),
                    ],
                  ),
                ),
                Text(
                  const FinancialAmount(30000).format(), // ₹300.00
                  style: NivaTypography.financialAmount.copyWith(
                    color: NivaColors.teal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          NivaCard(
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0x2200AFFF),
                  child: Icon(
                    Icons.done_all,
                    color: NivaColors.electricCyan,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You repaid Ramesh',
                        style: NivaTypography.titleSmall,
                      ),
                      Text(
                        'Linked to "Road Trip Fuel" · Oct 13',
                        style: NivaTypography.bodySmall.copyWith(
                          color: NivaColors.platinum,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 4),
                      NivaStatusBadge.settled(),
                    ],
                  ),
                ),
                Text(
                  const FinancialAmount(60000).format(), // ₹600.00
                  style: NivaTypography.financialAmount.copyWith(
                    color: NivaColors.electricCyan,
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
