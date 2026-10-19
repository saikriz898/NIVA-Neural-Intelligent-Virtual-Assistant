import 'package:flutter/material.dart';

import '../../core/constants/niva_colors.dart';

/// Styled card container with subtle borders and consistent border radii.
class NivaCard extends StatelessWidget {
  const NivaCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.gradient,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final effectiveBg =
        backgroundColor ??
        (isDark ? NivaColors.surfaceCardDark : NivaColors.surfaceCardLight);
    final effectiveBorder =
        borderColor ??
        (isDark
            ? NivaColors.platinum.withValues(alpha: 0.15)
            : NivaColors.platinum.withValues(alpha: 0.6));

    final decoration = BoxDecoration(
      color: gradient == null ? effectiveBg : null,
      gradient: gradient,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: effectiveBorder, width: 1),
    );

    Widget content = Container(
      margin: margin,
      decoration: decoration,
      child: Padding(padding: padding, child: child),
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: content,
        ),
      );
    }

    return content;
  }
}
