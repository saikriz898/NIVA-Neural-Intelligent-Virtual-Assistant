import 'package:flutter/material.dart';

import '../../../core/constants/niva_colors.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';
import '../../../shared/widgets/niva_status_badge.dart';

/// Detailed view of a split bill with individual participant repayments.
class SplitDetailsScreen extends StatefulWidget {
  const SplitDetailsScreen({super.key, required this.splitId});

  final String splitId;

  @override
  State<SplitDetailsScreen> createState() => _SplitDetailsScreenState();
}

class _SplitDetailsScreenState extends State<SplitDetailsScreen> {
  // Example split participants
  final List<_Participant> _participants = [
    const _Participant(
      name: 'You (Organizer)',
      share: FinancialAmount(30000),
      isPaid: true,
      isPayer: true,
    ),
    const _Participant(
      name: 'Dinesh',
      share: FinancialAmount(30000),
      isPaid: true,
      repaidAmount: FinancialAmount(30000),
    ),
    const _Participant(
      name: 'Suresh',
      share: FinancialAmount(30000),
      isPaid: false,
    ),
    const _Participant(
      name: 'Priya',
      share: FinancialAmount(30000),
      isPaid: false,
    ),
  ];

  void _recordRepayment(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Record Repayment from $name linked to this split.'),
        backgroundColor: NivaColors.teal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const totalBill = FinancialAmount(120000); // ₹1,200.00
    const totalRepaid = FinancialAmount(30000); // ₹300.00 repaid by Dinesh
    const remainingReceivable = FinancialAmount(60000); // ₹600.00 remaining

    return Scaffold(
      appBar: NivaAppBar(
        title: 'Team Dinner Split',
        subtitle: 'Split ID: ${widget.splitId}',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Split Summary Card
            NivaCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Original Bill Total',
                        style: NivaTypography.titleSmall,
                      ),
                      NivaStatusBadge.partiallyPaid(),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    totalBill.format(),
                    style: NivaTypography.financialDisplay,
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Payer of Bill', 'You (Axis Bank)'),
                  _buildSummaryRow(
                    'Your Share',
                    const FinancialAmount(30000).format(),
                  ),
                  _buildSummaryRow('Collected So Far', totalRepaid.format()),
                  _buildSummaryRow(
                    'Remaining Receivable',
                    remainingReceivable.format(),
                    isHighlight: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Participant breakdown
            Text(
              'Participants & Repayments (4)',
              style: NivaTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            for (final p in _participants) ...[
              NivaCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: p.isPaid
                          ? const Color(0x2200D6A3)
                          : const Color(0x22E53935),
                      child: Icon(
                        p.isPaid ? Icons.check : Icons.hourglass_top,
                        color: p.isPaid ? NivaColors.teal : NivaColors.error,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.name, style: NivaTypography.titleSmall),
                          Text(
                            p.isPayer
                                ? 'Paid initial ₹1,200.00'
                                : (p.isPaid
                                      ? 'Fully repaid ${p.share.format()}'
                                      : 'Owes ${p.share.format()}'),
                            style: NivaTypography.bodySmall.copyWith(
                              color: NivaColors.platinum,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!p.isPaid && !p.isPayer)
                      OutlinedButton(
                        onPressed: () => _recordRepayment(p.name),
                        style: OutlinedButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                        ),
                        child: const Text(
                          'Record Repayment',
                          style: TextStyle(fontSize: 11),
                        ),
                      )
                    else if (p.isPaid)
                      NivaStatusBadge.paid(),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: NivaTypography.bodySmall.copyWith(
              color: NivaColors.platinum,
            ),
          ),
          Text(
            value,
            style: NivaTypography.labelSmall.copyWith(
              color: isHighlight ? NivaColors.warning : null,
              fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _Participant {
  const _Participant({
    required this.name,
    required this.share,
    required this.isPaid,
    this.isPayer = false,
    this.repaidAmount,
  });

  final String name;
  final FinancialAmount share;
  final bool isPaid;
  final bool isPayer;
  final FinancialAmount? repaidAmount;
}
