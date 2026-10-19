import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/niva_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/financial_amount.dart';
import '../../../shared/models/operating_mode.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_card.dart';
import '../../../shared/widgets/niva_status_badge.dart';

/// Dashboard (Home) screen:
/// - Net recorded balance display (integer minor units only)
/// - Mode status indicator (Guest local-only vs Registered sync)
/// - Quick action shortcuts: Record Transfer, Expense, Income, Split
/// - RAAZ conversational trigger bar
/// - Linked accounts preview
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mode = ref.watch(operatingModeProvider);

    // Initial placeholder balance: 48,250 INR = 4,825,000 paise (integer minor units)
    const recordedTotal = FinancialAmount(4825000);

    return Scaffold(
      appBar: NivaAppBar(
        title: AppConstants.appName,
        subtitle: mode == OperatingMode.guest ? 'Device-Local' : 'Synchronized',
        showBrandSymbol: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            onPressed: () => context.push(RouteNames.accounts),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            Future.delayed(const Duration(milliseconds: 500)),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Operating mode badge banner
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (mode == OperatingMode.guest)
                    NivaStatusBadge.guest()
                  else
                    NivaStatusBadge.registered(),
                  TextButton.icon(
                    onPressed: () => context.push(RouteNames.workspaces),
                    icon: const Icon(Icons.apartment, size: 16),
                    label: const Text('Personal Workspace'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      textStyle: NivaTypography.labelSmall,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Total Recorded Balance Hero Card
              NivaCard(
                gradient: NivaColors.brandGradient,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recorded Total Balance',
                          style: NivaTypography.titleSmall.copyWith(
                            color: NivaColors.platinum,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Recorded',
                            style: NivaTypography.labelSmall.copyWith(
                              color: NivaColors.teal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recordedTotal.format(),
                      style: NivaTypography.financialDisplay.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Truthful record of user-reported accounts. Not a live bank API balance.',
                      style: NivaTypography.bodySmall.copyWith(
                        color: NivaColors.platinum.withValues(alpha: 0.8),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Quick Actions Row
              Row(
                children: [
                  _QuickActionButton(
                    icon: Icons.arrow_upward_rounded,
                    color: NivaColors.error,
                    label: 'Expense',
                    onTap: () => context.push(RouteNames.recordExpense),
                  ),
                  const SizedBox(width: 8),
                  _QuickActionButton(
                    icon: Icons.arrow_downward_rounded,
                    color: NivaColors.teal,
                    label: 'Income',
                    onTap: () => context.push(RouteNames.recordIncome),
                  ),
                  const SizedBox(width: 8),
                  _QuickActionButton(
                    icon: Icons.swap_horiz_rounded,
                    color: NivaColors.electricCyan,
                    label: 'Record Transfer',
                    onTap: () => context.push(RouteNames.recordTransfer),
                  ),
                  const SizedBox(width: 8),
                  _QuickActionButton(
                    icon: Icons.call_split_rounded,
                    color: NivaColors.warning,
                    label: 'Split Bill',
                    onTap: () => context.push(RouteNames.splits),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // RAAZ Prompt / Search Bar
              NivaCard(
                onTap: () => context.go(RouteNames.raaz),
                backgroundColor: isDark
                    ? NivaColors.deepNavy.withValues(alpha: 0.25)
                    : NivaColors.surfaceCardLight,
                borderColor: NivaColors.electricCyan.withValues(alpha: 0.4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: NivaColors.teal,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Ask RAAZ in English, Tamil, or Tanglish...',
                        style: NivaTypography.bodyMedium.copyWith(
                          color: isDark
                              ? NivaColors.platinum
                              : NivaColors.textSecondaryLight,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.mic_none_outlined,
                      size: 20,
                      color: NivaColors.platinum,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Accounts Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recorded Accounts',
                    style: NivaTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.push(RouteNames.accounts),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _AccountTile(
                title: 'Primary Savings Bank',
                subtitle: 'Bank Account · Axis',
                amount: const FinancialAmount(3620000), // ₹36,200.00
                icon: Icons.account_balance,
              ),
              const SizedBox(height: 8),
              _AccountTile(
                title: 'Cash Wallet',
                subtitle: 'Physical Cash',
                amount: const FinancialAmount(705000), // ₹7,050.00
                icon: Icons.payments_outlined,
              ),
              const SizedBox(height: 8),
              _AccountTile(
                title: 'UPI Linked Stored Value',
                subtitle: 'Mapped to Axis Funding Account',
                amount: const FinancialAmount(500000), // ₹5,000.00
                icon: Icons.qr_code_2_outlined,
              ),
              const SizedBox(height: 24),

              // Recent Activity Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Activity',
                    style: NivaTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go(RouteNames.activity),
                    child: const Text('See All'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _ActivityPreviewTile(
                title: 'Team Lunch Split',
                subtitle: 'You paid ₹1,200 · 3 people owe ₹900',
                amount: const FinancialAmount(-120000),
                status: NivaStatusBadge.partiallyPaid(),
              ),
              const SizedBox(height: 8),
              _ActivityPreviewTile(
                title: 'Record Transfer to Savings',
                subtitle: 'Cash → Axis Bank (Self transfer)',
                amount: const FinancialAmount(200000),
                isTransfer: true,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          decoration: BoxDecoration(
            color: isDark ? NivaColors.surfaceCardDark : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark
                  ? NivaColors.platinum.withValues(alpha: 0.12)
                  : NivaColors.platinum.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: color.withValues(alpha: 0.15),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: NivaTypography.labelSmall.copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  const _AccountTile({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final FinancialAmount amount;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return NivaCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: NivaColors.deepNavy.withValues(alpha: 0.15),
            child: Icon(icon, color: NivaColors.electricCyan, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: NivaTypography.titleSmall),
                Text(
                  subtitle,
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

class _ActivityPreviewTile extends StatelessWidget {
  const _ActivityPreviewTile({
    required this.title,
    required this.subtitle,
    required this.amount,
    this.status,
    this.isTransfer = false,
  });

  final String title;
  final String subtitle;
  final FinancialAmount amount;
  final Widget? status;
  final bool isTransfer;

  @override
  Widget build(BuildContext context) {
    return NivaCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isTransfer
                ? NivaColors.electricCyan.withValues(alpha: 0.15)
                : (amount.isNegative
                      ? NivaColors.error.withValues(alpha: 0.15)
                      : NivaColors.teal.withValues(alpha: 0.15)),
            child: Icon(
              isTransfer
                  ? Icons.swap_horiz
                  : (amount.isNegative
                        ? Icons.arrow_upward
                        : Icons.arrow_downward),
              color: isTransfer
                  ? NivaColors.electricCyan
                  : (amount.isNegative ? NivaColors.error : NivaColors.teal),
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
                  subtitle,
                  style: NivaTypography.bodySmall.copyWith(
                    color: NivaColors.platinum,
                    fontSize: 11,
                  ),
                ),
                if (status != null) ...[const SizedBox(height: 6), status!],
              ],
            ),
          ),
          Text(
            isTransfer ? amount.format() : amount.format(showSign: true),
            style: NivaTypography.financialAmount.copyWith(
              color: isTransfer
                  ? NivaColors.electricCyan
                  : (amount.isNegative ? NivaColors.error : NivaColors.teal),
            ),
          ),
        ],
      ),
    );
  }
}
