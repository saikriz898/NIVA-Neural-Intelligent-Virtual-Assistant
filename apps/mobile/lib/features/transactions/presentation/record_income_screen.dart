import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../core/utilities/money_formatter.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_button.dart';

/// Screen for recording an observed income or money receipt.
class RecordIncomeScreen extends StatefulWidget {
  const RecordIncomeScreen({super.key});

  @override
  State<RecordIncomeScreen> createState() => _RecordIncomeScreenState();
}

class _RecordIncomeScreenState extends State<RecordIncomeScreen> {
  final _amountController = TextEditingController();
  final _sourceController = TextEditingController();
  String _selectedCategory = 'Salary / Wages';
  String _selectedAccount = 'Primary Savings Bank';
  bool _isSaving = false;

  final List<String> _categories = [
    'Salary / Wages',
    'Freelance / Consulting',
    'Allowance / Pocket Money',
    'Business Sales',
    'Investment Returns',
    'Gift / Other',
  ];

  final List<String> _accounts = [
    'Primary Savings Bank',
    'Cash Wallet',
    'UPI Stored Value',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _sourceController.dispose();
    super.dispose();
  }

  void _onSaveIncome() {
    final minorUnits = MoneyFormatter.tryParseToMinorUnits(
      _amountController.text,
    );
    if (minorUnits == null || minorUnits <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid income amount.'),
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
              'Income of ${FinancialAmount(minorUnits).format()} recorded to $_selectedAccount.',
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
      appBar: const NivaAppBar(title: 'Record Income'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Income Amount (₹)', style: NivaTypography.titleSmall),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: NivaTypography.financialDisplay.copyWith(
                color: NivaColors.teal,
              ),
              decoration: const InputDecoration(
                hintText: '0.00',
                prefixText: '₹ ',
              ),
            ),
            const SizedBox(height: 20),

            Text('Income Source Category', style: NivaTypography.titleSmall),
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

            Text('Deposited Into Account', style: NivaTypography.titleSmall),
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

            Text('Source / Payer Name', style: NivaTypography.titleSmall),
            const SizedBox(height: 8),
            TextField(
              controller: _sourceController,
              decoration: const InputDecoration(
                hintText: 'e.g. Employer, Client, Family',
              ),
            ),
            const SizedBox(height: 32),

            NivaButton(
              text: 'Save Income',
              isLoading: _isSaving,
              onPressed: _onSaveIncome,
            ),
          ],
        ),
      ),
    );
  }
}
