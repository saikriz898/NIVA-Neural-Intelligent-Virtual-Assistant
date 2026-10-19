import 'package:flutter/material.dart';

import '../../core/constants/niva_colors.dart';
import '../../core/theme/niva_typography.dart';

/// Semantic status badge for financial records, splits, and sync states.
class NivaStatusBadge extends StatelessWidget {
  const NivaStatusBadge({
    super.key,
    required this.label,
    this.color,
    this.icon,
  });

  final String label;
  final Color? color;
  final IconData? icon;

  factory NivaStatusBadge.paid() => const NivaStatusBadge(
    label: 'Paid',
    color: NivaColors.teal,
    icon: Icons.check_circle_outline,
  );

  factory NivaStatusBadge.partiallyPaid() => const NivaStatusBadge(
    label: 'Partially Paid',
    color: NivaColors.warning,
    icon: Icons.pie_chart_outline,
  );

  factory NivaStatusBadge.unpaid() => const NivaStatusBadge(
    label: 'Unpaid',
    color: NivaColors.error,
    icon: Icons.error_outline,
  );

  factory NivaStatusBadge.settled() => const NivaStatusBadge(
    label: 'Settled',
    color: NivaColors.electricCyan,
    icon: Icons.verified_outlined,
  );

  factory NivaStatusBadge.guest() => const NivaStatusBadge(
    label: 'Device-Local (Guest)',
    color: NivaColors.electricCyan,
    icon: Icons.phone_android_outlined,
  );

  factory NivaStatusBadge.registered() => const NivaStatusBadge(
    label: 'Synchronized (Registered)',
    color: NivaColors.teal,
    icon: Icons.cloud_done_outlined,
  );

  factory NivaStatusBadge.pendingSync() => const NivaStatusBadge(
    label: 'Pending Sync',
    color: NivaColors.warning,
    icon: Icons.sync_problem_outlined,
  );

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? NivaColors.platinum;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: effectiveColor.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: effectiveColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: NivaTypography.labelSmall.copyWith(
              color: effectiveColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
