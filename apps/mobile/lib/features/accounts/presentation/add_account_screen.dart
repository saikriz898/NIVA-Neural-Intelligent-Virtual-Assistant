import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../core/utilities/money_formatter.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_button.dart';

/// Screen to add a new tracked money account with opening balance.
class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({super.key});

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();
  String _accountType = 'Bank Account';
  bool _isSaving = false;

  final List<String> _accountTypes = [
    'Bank Account',
    'Cash on Hand',
    'Stored Value Wallet',
    'Credit Card',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  void _onSaveAccount() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an account name.'),
          backgroundColor: NivaColors.error,
        ),
      );
      return;
    }

    final openingBalance = MoneyFormatter.tryParseToMinorUnits(
      _balanceController.text.isEmpty ? '0' : _balanceController.text,
    );

    if (openingBalance == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid opening balance.'),
          backgroundColor: NivaColors.error,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Account "$name" created with opening balance of ${FinancialAmount(openingBalance).format()}.',
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
      appBar: const NivaAppBar(title: 'Add Account'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Account Name', style: NivaTypography.titleSmall),
            const SizedBox(height: 8),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'e.g. HDFC Salary, Petty Cash, GPay Wallet',
              ),
            ),
            const SizedBox(height: 20),

            Text('Account Type', style: NivaTypography.titleSmall),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _accountType,
              items: _accountTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _accountType = val);
              },
            ),
            const SizedBox(height: 20),

            Text(
              'Opening Recorded Balance (₹)',
              style: NivaTypography.titleSmall,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _balanceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: NivaTypography.financialDisplay,
              decoration: const InputDecoration(
                hintText: '0.00',
                prefixText: '₹ ',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Stored as exact integer minor units (paise). Never floating-point.',
              style: NivaTypography.labelSmall.copyWith(
                color: NivaColors.platinum,
              ),
            ),
            const SizedBox(height: 32),

            NivaButton(
              text: 'Save Account',
              isLoading: _isSaving,
              onPressed: _onSaveAccount,
            ),
          ],
        ),
      ),
    );
  }
}
