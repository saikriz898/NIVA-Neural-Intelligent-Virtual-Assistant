import 'package:flutter/material.dart';

/// NIVA official branding color tokens as defined in `assets/branding/tokens.json`.
///
/// Design system:
/// - Midnight (#081729): Dark background and dark surface foundation
/// - Deep Navy (#082D6B): Branded text, strong UI surfaces and containers
/// - Electric Cyan (#00AFFF): Primary interactive highlight and accents
/// - Teal (#00D6A3): Secondary accent, growth, and positive status indicator
/// - Platinum (#C6CDD8): Neutral borders, dividers, and subtle strokes
/// - Porcelain (#F7F8FA): Primary light surface and clean background
abstract final class NivaColors {
  // Brand tokens
  static const Color midnight = Color(0xFF081729);
  static const Color deepNavy = Color(0xFF082D6B);
  static const Color electricCyan = Color(0xFF00AFFF);
  static const Color teal = Color(0xFF00D6A3);
  static const Color platinum = Color(0xFFC6CDD8);
  static const Color porcelain = Color(0xFFF7F8FA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color ink = Color(0xFF192438);

  // Surface and card variations
  static const Color surfaceDark = Color(0xFF0D223A);
  static const Color surfaceCardDark = Color(0xFF102A48);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceCardLight = Color(0xFFFFFFFF);

  // Text variations
  static const Color textPrimaryDark = Color(0xFFF7F8FA);
  static const Color textSecondaryDark = Color(0xFFC6CDD8);
  static const Color textMutedDark = Color(0xFF7E8B9B);

  static const Color textPrimaryLight = Color(0xFF081729);
  static const Color textSecondaryLight = Color(0xFF4A5568);
  static const Color textMutedLight = Color(0xFF8A99AD);

  // Semantic feedback
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA000);
  static const Color success = Color(0xFF00D6A3);
  static const Color info = Color(0xFF00AFFF);

  // Gradients
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [deepNavy, electricCyan],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [electricCyan, teal],
  );
}
