import 'package:flutter/material.dart';

import '../../core/constants/niva_colors.dart';
import '../../core/theme/niva_typography.dart';
import 'niva_symbol.dart';

/// Standardized NIVA App Bar adhering to the brand identity.
class NivaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NivaAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBrandSymbol = false,
    this.actions,
    this.leading,
    this.bottom,
  });

  final String title;
  final String? subtitle;
  final bool showBrandSymbol;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget? leadingWidget = leading;
    if (leadingWidget == null && showBrandSymbol) {
      leadingWidget = const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: Center(child: NivaSymbol(size: 28)),
      );
    }

    return AppBar(
      leading: leadingWidget,
      leadingWidth: showBrandSymbol ? 44 : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: NivaTypography.titleLarge.copyWith(
              color: isDark ? NivaColors.porcelain : NivaColors.midnight,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: NivaTypography.labelSmall.copyWith(
                color: isDark
                    ? NivaColors.platinum
                    : NivaColors.textSecondaryLight,
              ),
            ),
        ],
      ),
      actions: actions,
      bottom: bottom,
    );
  }
}
