import 'package:flutter/material.dart';

import '../constants/niva_colors.dart';
import 'niva_typography.dart';

/// Custom theme extension exposing NIVA brand tokens to the widget tree.
@immutable
class NivaColorTokens extends ThemeExtension<NivaColorTokens> {
  const NivaColorTokens({
    required this.midnight,
    required this.deepNavy,
    required this.electricCyan,
    required this.teal,
    required this.platinum,
    required this.porcelain,
    required this.cardBackground,
    required this.borderSubtle,
    required this.textMuted,
  });

  final Color midnight;
  final Color deepNavy;
  final Color electricCyan;
  final Color teal;
  final Color platinum;
  final Color porcelain;
  final Color cardBackground;
  final Color borderSubtle;
  final Color textMuted;

  @override
  NivaColorTokens copyWith({
    Color? midnight,
    Color? deepNavy,
    Color? electricCyan,
    Color? teal,
    Color? platinum,
    Color? porcelain,
    Color? cardBackground,
    Color? borderSubtle,
    Color? textMuted,
  }) {
    return NivaColorTokens(
      midnight: midnight ?? this.midnight,
      deepNavy: deepNavy ?? this.deepNavy,
      electricCyan: electricCyan ?? this.electricCyan,
      teal: teal ?? this.teal,
      platinum: platinum ?? this.platinum,
      porcelain: porcelain ?? this.porcelain,
      cardBackground: cardBackground ?? this.cardBackground,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      textMuted: textMuted ?? this.textMuted,
    );
  }

  @override
  NivaColorTokens lerp(ThemeExtension<NivaColorTokens>? other, double t) {
    if (other is! NivaColorTokens) return this;
    return NivaColorTokens(
      midnight: Color.lerp(midnight, other.midnight, t)!,
      deepNavy: Color.lerp(deepNavy, other.deepNavy, t)!,
      electricCyan: Color.lerp(electricCyan, other.electricCyan, t)!,
      teal: Color.lerp(teal, other.teal, t)!,
      platinum: Color.lerp(platinum, other.platinum, t)!,
      porcelain: Color.lerp(porcelain, other.porcelain, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
    );
  }

  static const dark = NivaColorTokens(
    midnight: NivaColors.midnight,
    deepNavy: NivaColors.deepNavy,
    electricCyan: NivaColors.electricCyan,
    teal: NivaColors.teal,
    platinum: NivaColors.platinum,
    porcelain: NivaColors.porcelain,
    cardBackground: NivaColors.surfaceCardDark,
    borderSubtle: Color(0x33C6CDD8),
    textMuted: NivaColors.textMutedDark,
  );

  static const light = NivaColorTokens(
    midnight: NivaColors.midnight,
    deepNavy: NivaColors.deepNavy,
    electricCyan: NivaColors.electricCyan,
    teal: NivaColors.teal,
    platinum: NivaColors.platinum,
    porcelain: NivaColors.porcelain,
    cardBackground: NivaColors.surfaceCardLight,
    borderSubtle: Color(0x66C6CDD8),
    textMuted: NivaColors.textMutedLight,
  );
}

/// NIVA Theme definitions conforming to `assets/branding/BRAND_GUIDE.md`.
abstract final class NivaTheme {
  /// Dark theme - Default mode reflecting NIVA's Midnight and Deep Navy aesthetic.
  static ThemeData get darkTheme {
    final colorScheme = const ColorScheme.dark().copyWith(
      primary: NivaColors.electricCyan,
      onPrimary: NivaColors.midnight,
      primaryContainer: NivaColors.deepNavy,
      onPrimaryContainer: NivaColors.porcelain,
      secondary: NivaColors.teal,
      onSecondary: NivaColors.midnight,
      surface: NivaColors.surfaceDark,
      onSurface: NivaColors.textPrimaryDark,
      error: NivaColors.error,
      onError: Colors.white,
      outline: NivaColors.platinum.withValues(alpha: 0.25),
      outlineVariant: NivaColors.platinum.withValues(alpha: 0.12),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: NivaColors.midnight,
      colorScheme: colorScheme,
      fontFamily: NivaTypography.fontFamily,
      extensions: const [NivaColorTokens.dark],
      appBarTheme: const AppBarTheme(
        backgroundColor: NivaColors.midnight,
        foregroundColor: NivaColors.porcelain,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: NivaTypography.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: NivaColors.surfaceCardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: NivaColors.platinum.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: NivaColors.electricCyan,
          foregroundColor: NivaColors.midnight,
          elevation: 0,
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: NivaTypography.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: NivaColors.electricCyan,
          side: const BorderSide(color: NivaColors.electricCyan, width: 1.5),
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: NivaTypography.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: NivaColors.electricCyan,
          textStyle: NivaTypography.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: NivaColors.surfaceDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: NivaColors.platinum.withValues(alpha: 0.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: NivaColors.platinum.withValues(alpha: 0.2),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: NivaColors.electricCyan,
            width: 2,
          ),
        ),
        hintStyle: TextStyle(
          color: NivaColors.platinum.withValues(alpha: 0.5),
          fontSize: 14,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: NivaColors.midnight,
        indicatorColor: NivaColors.deepNavy,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return NivaTypography.labelSmall.copyWith(
              color: NivaColors.electricCyan,
              fontWeight: FontWeight.w600,
            );
          }
          return NivaTypography.labelSmall.copyWith(
            color: NivaColors.platinum.withValues(alpha: 0.7),
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: NivaColors.electricCyan,
              size: 24,
            );
          }
          return IconThemeData(
            color: NivaColors.platinum.withValues(alpha: 0.7),
            size: 24,
          );
        }),
      ),
      dividerTheme: DividerThemeData(
        color: NivaColors.platinum.withValues(alpha: 0.12),
        thickness: 1,
      ),
    );
  }

  /// Light theme - Clean Porcelain aesthetic for users preferring light mode.
  static ThemeData get lightTheme {
    final colorScheme = const ColorScheme.light().copyWith(
      primary: NivaColors.deepNavy,
      onPrimary: Colors.white,
      primaryContainer: NivaColors.porcelain,
      onPrimaryContainer: NivaColors.deepNavy,
      secondary: NivaColors.teal,
      onSecondary: Colors.white,
      surface: NivaColors.porcelain,
      onSurface: NivaColors.textPrimaryLight,
      error: NivaColors.error,
      onError: Colors.white,
      outline: NivaColors.platinum,
      outlineVariant: NivaColors.platinum.withValues(alpha: 0.5),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: NivaColors.porcelain,
      colorScheme: colorScheme,
      fontFamily: NivaTypography.fontFamily,
      extensions: const [NivaColorTokens.light],
      appBarTheme: const AppBarTheme(
        backgroundColor: NivaColors.porcelain,
        foregroundColor: NivaColors.midnight,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: NivaTypography.fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: NivaColors.midnight,
        ),
      ),
      cardTheme: CardThemeData(
        color: NivaColors.surfaceCardLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0x33C6CDD8), width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: NivaColors.deepNavy,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: NivaTypography.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: NivaColors.deepNavy,
          side: const BorderSide(color: NivaColors.deepNavy, width: 1.5),
          minimumSize: const Size.fromHeight(48),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: NivaTypography.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: NivaColors.deepNavy,
          textStyle: NivaTypography.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: NivaColors.platinum),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: NivaColors.platinum),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: NivaColors.deepNavy, width: 2),
        ),
        hintStyle: const TextStyle(
          color: NivaColors.textMutedLight,
          fontSize: 14,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: NivaColors.porcelain,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return NivaTypography.labelSmall.copyWith(
              color: NivaColors.deepNavy,
              fontWeight: FontWeight.w600,
            );
          }
          return NivaTypography.labelSmall.copyWith(
            color: NivaColors.textSecondaryLight,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: NivaColors.deepNavy, size: 24);
          }
          return const IconThemeData(
            color: NivaColors.textSecondaryLight,
            size: 24,
          );
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0x33C6CDD8),
        thickness: 1,
      ),
    );
  }
}
