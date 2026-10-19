import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';
import '../../../shared/widgets/niva_status_badge.dart';

/// Activity / Financial Ledger Screen (Destination 2)
class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Expenses',
    'Income',
    'Transfers',
    'Splits',
  ];

  void _showAddTransactionOptions() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Record Financial Activity',
                  style: NivaTypography.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Record manual finance entries. NIVA does not execute real bank/UPI payments.',
                  style: NivaTypography.bodySmall.copyWith(
                    color: NivaColors.platinum,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0x22E53935),
                    child: Icon(Icons.arrow_upward, color: NivaColors.error),
                  ),
                  title: const Text('Record Expense'),
                  subtitle: const Text(
                    'Track spending with category and account',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.push(RouteNames.recordExpense);
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0x2200D6A3),
                    child: Icon(Icons.arrow_downward, color: NivaColors.teal),
                  ),
                  title: const Text('Record Income'),
                  subtitle: const Text(
                    'Track salary, sales, or allowance received',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.push(RouteNames.recordIncome);
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0x2200AFFF),
                    child: Icon(
                      Icons.swap_horiz,
                      color: NivaColors.electricCyan,
                    ),
                  ),
                  title: const Text('Record Transfer'),
                  subtitle: const Text(
                    'Move funds between your own recorded accounts',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.push(RouteNames.recordTransfer);
                  },
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0x22FFA000),
                    child: Icon(Icons.call_split, color: NivaColors.warning),
                  ),
                  title: const Text('Record Split Bill'),
                  subtitle: const Text(
                    'Track who paid and individual repayments',
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.push(RouteNames.splits);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NivaAppBar(
        title: 'Activity',
        subtitle: 'Financial Ledger & Journal',
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionOptions,
        backgroundColor: NivaColors.electricCyan,
        foregroundColor: NivaColors.midnight,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                for (final filter in _filters)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      selected: _selectedFilter == filter,
                      label: Text(filter),
                      onSelected: (selected) {
                        if (selected) setState(() => _selectedFilter = filter);
                      },
                      selectedColor: NivaColors.deepNavy,
                      checkmarkColor: NivaColors.electricCyan,
                      labelStyle: TextStyle(
                        color: _selectedFilter == filter
                            ? NivaColors.electricCyan
                            : NivaColors.platinum,
                        fontWeight: _selectedFilter == filter
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Activity List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildDateHeader('Today · Oct 18, 2026'),
                const SizedBox(height: 8),
                _buildTransactionItem(
                  title: 'Grocery Store Market',
                  accountName: 'Cash Wallet',
                  amount: const FinancialAmount(-45000), // -₹450.00
                  isExpense: true,
                  badge: NivaStatusBadge(label: 'Saved (Local)'),
                ),
                const SizedBox(height: 8),
                _buildTransactionItem(
                  title: 'Record Transfer: ATM Cash Withdrawal',
                  accountName: 'Axis Bank → Cash Wallet',
                  amount: const FinancialAmount(500000), // ₹5,000.00
                  isTransfer: true,
                  badge: NivaStatusBadge(label: 'Balanced Journal'),
                ),
                const SizedBox(height: 16),
                _buildDateHeader('Yesterday · Oct 17, 2026'),
                const SizedBox(height: 8),
                _buildTransactionItem(
                  title: 'Team Dinner Split',
                  accountName: 'Axis Bank (You paid original ₹1,200)',
                  amount: const FinancialAmount(-120000), // -₹1,200.00
                  isExpense: true,
                  badge: NivaStatusBadge.partiallyPaid(),
                  onTap: () => context.push(RouteNames.splits),
                ),
                const SizedBox(height: 8),
                _buildTransactionItem(
                  title: 'Project Freelance Consultation',
                  accountName: 'Primary Savings Bank',
                  amount: const FinancialAmount(2500000), // +₹25,000.00
                  isIncome: true,
                  badge: NivaStatusBadge(label: 'Recorded Income'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader(String title) {
    return Text(
      title,
      style: NivaTypography.labelMedium.copyWith(
        color: NivaColors.platinum,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String accountName,
    required FinancialAmount amount,
    bool isExpense = false,
    bool isIncome = false,
    bool isTransfer = false,
    Widget? badge,
    VoidCallback? onTap,
  }) {
    final Color amountColor = isTransfer
        ? NivaColors.electricCyan
        : (isExpense ? NivaColors.error : NivaColors.teal);

    return NivaCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: amountColor.withValues(alpha: 0.15),
            child: Icon(
              isTransfer
                  ? Icons.swap_horiz
                  : (isExpense ? Icons.arrow_upward : Icons.arrow_downward),
              color: amountColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: NivaTypography.titleSmall),
                const SizedBox(height: 2),
                Text(
                  accountName,
                  style: NivaTypography.bodySmall.copyWith(
                    color: NivaColors.platinum,
                    fontSize: 11,
                  ),
                ),
                if (badge != null) ...[const SizedBox(height: 6), badge],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            isTransfer ? amount.format() : amount.format(showSign: true),
            style: NivaTypography.financialAmount.copyWith(color: amountColor),
          ),
        ],
      ),
    );
  }
}
