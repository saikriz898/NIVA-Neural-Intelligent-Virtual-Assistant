import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../core/utilities/money_formatter.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_button.dart';

/// Screen for recording an observed expense.
class RecordExpenseScreen extends StatefulWidget {
  const RecordExpenseScreen({super.key});

  @override
  State<RecordExpenseScreen> createState() => _RecordExpenseScreenState();
}

class _RecordExpenseScreenState extends State<RecordExpenseScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedCategory = 'Food & Dining';
  String _selectedAccount = 'Cash Wallet';
  bool _isSaving = false;

  final List<String> _categories = [
    'Food & Dining',
    'Transport & Fuel',
    'Groceries & Household',
    'Utilities & Bills',
    'Health & Medical',
    'Shopping',
    'Other Expense',
  ];

  final List<String> _accounts = [
    'Cash Wallet',
    'Primary Savings Bank',
    'UPI Stored Value',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onSaveExpense() {
    final minorUnits = MoneyFormatter.tryParseToMinorUnits(
      _amountController.text,
    );
    if (minorUnits == null || minorUnits <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid expense amount.'),
          backgroundColor: NivaColors.error,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Expense of ${FinancialAmount(minorUnits).format()} recorded to $_selectedCategory.',
            ),
            backgroundColor: NivaColors.teal,
          ),
        );
        context.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NivaAppBar(title: 'Record Expense'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount Spent (₹)', style: NivaTypography.titleSmall),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: NivaTypography.financialDisplay.copyWith(
                color: NivaColors.error,
              ),
              decoration: const InputDecoration(
                hintText: '0.00',
                prefixText: '₹ ',
              ),
            ),
            const SizedBox(height: 20),

            Text('Category', style: NivaTypography.titleSmall),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              items: _categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedCategory = val);
              },
            ),
            const SizedBox(height: 16),

            Text('Paid From Account', style: NivaTypography.titleSmall),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedAccount,
              items: _accounts
                  .map((a) => DropdownMenuItem(value: a, child: Text(a)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedAccount = val);
              },
            ),
            const SizedBox(height: 16),

            Text('Description / Merchant', style: NivaTypography.titleSmall),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: 'e.g. Swiggy lunch, Tea stall, Petrol station',
              ),
            ),
            const SizedBox(height: 32),

            NivaButton(
              text: 'Save Expense',
              isLoading: _isSaving,
              onPressed: _onSaveExpense,
            ),
          ],
        ),
      ),
    );
  }
}
