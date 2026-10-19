import 'package:flutter/material.dart';

import '../../core/constants/niva_colors.dart';
import '../../core/theme/niva_typography.dart';

enum NivaButtonVariant { primary, secondary, outline, text }

/// Reusable styled button component supporting NIVA brand aesthetics.
class NivaButton extends StatelessWidget {
  const NivaButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = NivaButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
  });

  final String text;
  final VoidCallback? onPressed;
  final NivaButtonVariant variant;
  final Widget? icon;
  final bool isLoading;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget childContent;
    if (isLoading) {
      childContent = SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == NivaButtonVariant.primary
                ? (isDark ? NivaColors.midnight : Colors.white)
                : NivaColors.electricCyan,
          ),
        ),
      );
    } else if (icon != null) {
      childContent = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [icon!, const SizedBox(width: 8), Text(text)],
      );
    } else {
      childContent = Text(text);
    }

    Widget button;

    switch (variant) {
      case NivaButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? NivaColors.electricCyan
                : NivaColors.deepNavy,
            foregroundColor: isDark ? NivaColors.midnight : Colors.white,
          ),
          child: childContent,
        );
      case NivaButtonVariant.secondary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark
                ? NivaColors.deepNavy
                : NivaColors.surfaceCardDark,
            foregroundColor: NivaColors.porcelain,
            side: BorderSide(
              color: NivaColors.platinum.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: childContent,
        );
      case NivaButtonVariant.outline:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: isDark
                ? NivaColors.electricCyan
                : NivaColors.deepNavy,
            side: BorderSide(
              color: isDark ? NivaColors.electricCyan : NivaColors.deepNavy,
              width: 1.5,
            ),
          ),
          child: childContent,
        );
      case NivaButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: isDark
                ? NivaColors.electricCyan
                : NivaColors.deepNavy,
            textStyle: NivaTypography.labelLarge,
          ),
          child: childContent,
        );
    }

    if (isFullWidth && variant != NivaButtonVariant.text) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
