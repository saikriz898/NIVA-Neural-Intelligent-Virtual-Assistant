import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';

/// Accounts Screen:
/// - Displays real financial accounts (Bank, Cash, Stored Value)
/// - Invariant: Exactly one authoritative recorded balance per distinct real account
class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NivaAppBar(
        title: 'Money Accounts',
        subtitle: 'One balance per real account',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Account',
            onPressed: () => context.push(RouteNames.addAccount),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Single balance invariant explanation
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
                  Icons.verified_user_outlined,
                  size: 18,
                  color: NivaColors.electricCyan,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Invariant: NIVA maintains exactly one authoritative recorded balance per real account. UPI shortcuts map to their underlying funding accounts without duplicating balances.',
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

          Text('Bank Accounts', style: NivaTypography.titleSmall),
          const SizedBox(height: 8),
          _buildAccountCard(
            title: 'Axis Bank Savings',
            accountNumber: '•••• 4892 · Primary',
            amount: const FinancialAmount(3620000), // ₹36,200.00
            icon: Icons.account_balance,
            tag: 'Authoritative',
          ),
          const SizedBox(height: 16),

          Text('Cash Accounts', style: NivaTypography.titleSmall),
          const SizedBox(height: 8),
          _buildAccountCard(
            title: 'Cash Wallet',
            accountNumber: 'Physical Cash on Hand',
            amount: const FinancialAmount(705000), // ₹7,050.00
            icon: Icons.payments_outlined,
            tag: 'Manual Reconciled',
          ),
          const SizedBox(height: 16),

          Text('Stored Value & UPI Mapping', style: NivaTypography.titleSmall),
          const SizedBox(height: 8),
          _buildAccountCard(
            title: 'UPI Stored Value Wallet',
            accountNumber: 'Funding Account: Axis Bank (•••• 4892)',
            amount: const FinancialAmount(500000), // ₹5,000.00
            icon: Icons.qr_code_2_outlined,
            tag: 'Linked',
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard({
    required String title,
    required String accountNumber,
    required FinancialAmount amount,
    required IconData icon,
    required String tag,
  }) {
    return NivaCard(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: NivaColors.deepNavy.withValues(alpha: 0.2),
            child: Icon(icon, color: NivaColors.electricCyan, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: NivaTypography.titleSmall),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: NivaColors.teal.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tag,
                        style: NivaTypography.labelSmall.copyWith(
                          fontSize: 9,
                          color: NivaColors.teal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  accountNumber,
                  style: NivaTypography.bodySmall.copyWith(
                    color: NivaColors.platinum,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(amount.format(), style: NivaTypography.financialAmount),
        ],
      ),
    );
  }
}
