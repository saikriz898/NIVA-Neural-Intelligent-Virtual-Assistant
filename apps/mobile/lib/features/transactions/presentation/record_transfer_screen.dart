import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../core/utilities/money_formatter.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_button.dart';
import '../../../shared/widgets/niva_card.dart';

/// Screen for recording an observed manual transfer between accounts.
///
/// Strict Invariant (NIVA-ARCH-012):
/// - Labeled "Record Transfer", NEVER "Send Money", "Pay", or "Transfer".
/// - NIVA records manual observed activity; it does NOT execute real bank or UPI transfers.
/// - Transfers between user's own accounts do NOT generate income or revenue.
class RecordTransferScreen extends StatefulWidget {
  const RecordTransferScreen({super.key});

  @override
  State<RecordTransferScreen> createState() => _RecordTransferScreenState();
}

class _RecordTransferScreenState extends State<RecordTransferScreen> {
  final _amountController = TextEditingController();
  final _referenceController = TextEditingController();

  String _fromAccount = 'Primary Savings Bank';
  String _toAccount = 'Cash Wallet';
  bool _isSaving = false;

  final List<String> _availableAccounts = [
    'Primary Savings Bank',
    'Cash Wallet',
    'UPI Stored Value',
    'Secondary Checking',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _referenceController.dispose();
    super.dispose();
  }

  void _onRecordTransfer() {
    final minorUnits = MoneyFormatter.tryParseToMinorUnits(
      _amountController.text,
    );
    if (minorUnits == null || minorUnits <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid transfer amount.'),
          backgroundColor: NivaColors.error,
        ),
      );
      return;
    }

    if (_fromAccount == _toAccount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Source and destination accounts must be different.'),
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
              '${AppConstants.recordTransferLabel} saved: ${FinancialAmount(minorUnits).format()} '
              'from $_fromAccount to $_toAccount.',
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
      appBar: const NivaAppBar(
        title: AppConstants.recordTransferLabel,
        subtitle: 'Observe self-account transfer',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment execution warning banner
            NivaCard(
              backgroundColor: const Color(0x22FFA000),
              borderColor: NivaColors.warning,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: NivaColors.warning,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Non-Banking Execution Notice',
                          style: NivaTypography.labelMedium.copyWith(
                            color: NivaColors.warning,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppConstants.paymentBoundaryDisclaimer,
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
            const SizedBox(height: 24),

            // Amount Field (Integer Minor Units)
            Text('Transfer Amount (₹)', style: NivaTypography.titleSmall),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: NivaTypography.financialDisplay,
              decoration: const InputDecoration(
                hintText: '0.00',
                prefixText: '₹ ',
              ),
            ),
            const SizedBox(height: 24),

            // From Account
            Text('From Account (Source)', style: NivaTypography.titleSmall),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _fromAccount,
              items: _availableAccounts.map((acc) {
                return DropdownMenuItem(value: acc, child: Text(acc));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _fromAccount = val);
              },
            ),
            const SizedBox(height: 16),

            // To Account
            Text('To Account (Destination)', style: NivaTypography.titleSmall),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _toAccount,
              items: _availableAccounts.map((acc) {
                return DropdownMenuItem(value: acc, child: Text(acc));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _toAccount = val);
              },
            ),
            const SizedBox(height: 16),

            // Reference description
            Text(
              'Reference / Note (Optional)',
              style: NivaTypography.titleSmall,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _referenceController,
              decoration: const InputDecoration(
                hintText: 'e.g. ATM cash withdrawal, self UPI transfer',
              ),
            ),
            const SizedBox(height: 16),

            // Financial Invariant note
            Text(
              'Invariant: Transfers between one\'s own accounts do NOT increase net assets or generate income.',
              style: NivaTypography.labelSmall.copyWith(
                color: NivaColors.platinum,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 32),

            // Explicit Button
            NivaButton(
              text: AppConstants.recordTransferLabel,
              isLoading: _isSaving,
              onPressed: _onRecordTransfer,
            ),
          ],
        ),
      ),
    );
  }
}
