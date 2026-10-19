import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/niva_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/operating_mode.dart';
import '../../../shared/widgets/niva_button.dart';
import '../../../shared/widgets/niva_card.dart';
import '../../../shared/widgets/niva_symbol.dart';

/// Onboarding screen:
/// - Language Selection: English, Tamil, Tanglish
/// - 18+ Eligibility Gate verification
/// - Guest Mode vs Registered Mode selection
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  String _selectedLanguage = 'English';
  bool _isAgeConfirmed = false;
  OperatingMode _selectedMode = OperatingMode.guest;

  void _onContinue() {
    if (!_isAgeConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Initial eligibility requires confirming you are 18 years of age or older.',
          ),
          backgroundColor: NivaColors.error,
        ),
      );
      return;
    }

    ref.read(operatingModeProvider.notifier).setMode(_selectedMode);
    ref.read(onboardingCompletedProvider.notifier).setCompleted(true);

    if (_selectedMode == OperatingMode.registered) {
      context.go(RouteNames.signIn);
    } else {
      context.go(RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              const Center(child: NivaSymbol(size: 72)),
              const SizedBox(height: 16),
              Text(
                AppConstants.appName,
                style: NivaTypography.displayLarge.copyWith(
                  color: isDark ? NivaColors.porcelain : NivaColors.midnight,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppConstants.appTagline,
                textAlign: TextAlign.center,
                style: NivaTypography.titleMedium.copyWith(
                  color: isDark ? NivaColors.electricCyan : NivaColors.deepNavy,
                ),
              ),
              const SizedBox(height: 32),

              // Language selection
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Preferred Language',
                  style: NivaTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  for (final lang in ['English', 'தமிழ் (Tamil)', 'Tanglish'])
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: OutlinedButton(
                          onPressed: () =>
                              setState(() => _selectedLanguage = lang),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: _selectedLanguage == lang
                                ? (isDark
                                      ? NivaColors.deepNavy
                                      : NivaColors.deepNavy.withValues(
                                          alpha: 0.08,
                                        ))
                                : null,
                            side: BorderSide(
                              color: _selectedLanguage == lang
                                  ? NivaColors.electricCyan
                                  : (isDark
                                        ? NivaColors.platinum.withValues(
                                            alpha: 0.2,
                                          )
                                        : NivaColors.platinum),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          child: Text(
                            lang,
                            style: NivaTypography.labelSmall.copyWith(
                              color: _selectedLanguage == lang
                                  ? (isDark
                                        ? NivaColors.electricCyan
                                        : NivaColors.deepNavy)
                                  : (isDark
                                        ? NivaColors.platinum
                                        : NivaColors.textPrimaryLight),
                              fontWeight: _selectedLanguage == lang
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 28),

              // Operating Mode Selection
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose Experience',
                  style: NivaTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              NivaCard(
                onTap: () =>
                    setState(() => _selectedMode = OperatingMode.guest),
                borderColor: _selectedMode == OperatingMode.guest
                    ? NivaColors.electricCyan
                    : null,
                backgroundColor: _selectedMode == OperatingMode.guest
                    ? (isDark
                          ? NivaColors.deepNavy.withValues(alpha: 0.3)
                          : NivaColors.porcelain)
                    : null,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(
                        _selectedMode == OperatingMode.guest
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: _selectedMode == OperatingMode.guest
                            ? NivaColors.electricCyan
                            : NivaColors.platinum,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Guest Mode',
                                style: NivaTypography.titleMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: NivaColors.teal.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Private & Local',
                                  style: NivaTypography.labelSmall.copyWith(
                                    color: NivaColors.teal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Financial records remain stored in an encrypted local database on your device. Zero automatic cloud uploads.',
                            style: NivaTypography.bodySmall.copyWith(
                              color: isDark
                                  ? NivaColors.platinum
                                  : NivaColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              NivaCard(
                onTap: () =>
                    setState(() => _selectedMode = OperatingMode.registered),
                borderColor: _selectedMode == OperatingMode.registered
                    ? NivaColors.electricCyan
                    : null,
                backgroundColor: _selectedMode == OperatingMode.registered
                    ? (isDark
                          ? NivaColors.deepNavy.withValues(alpha: 0.3)
                          : NivaColors.porcelain)
                    : null,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Icon(
                        _selectedMode == OperatingMode.registered
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: _selectedMode == OperatingMode.registered
                            ? NivaColors.electricCyan
                            : NivaColors.platinum,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Registered Mode',
                                style: NivaTypography.titleMedium.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: NivaColors.electricCyan.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Cloud Synced',
                                  style: NivaTypography.labelSmall.copyWith(
                                    color: NivaColors.electricCyan,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Synchronized backend ledger with multi-device access, shared workspaces, and verified recovery.',
                            style: NivaTypography.bodySmall.copyWith(
                              color: isDark
                                  ? NivaColors.platinum
                                  : NivaColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 18+ Eligibility Gate
              NivaCard(
                backgroundColor: isDark
                    ? NivaColors.surfaceDark
                    : NivaColors.platinum.withValues(alpha: 0.15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _isAgeConfirmed,
                      activeColor: NivaColors.electricCyan,
                      onChanged: (val) =>
                          setState(() => _isAgeConfirmed = val ?? false),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Eligibility Confirmation (18+)',
                            style: NivaTypography.labelLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'I confirm I am at least 18 years old. NIVA initial access for minors (aged 15–17) remains disabled pending separate legal and guardian-consent safeguards.',
                            style: NivaTypography.bodySmall.copyWith(
                              color: isDark
                                  ? NivaColors.platinum
                                  : NivaColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Action button
              NivaButton(
                text: _selectedMode == OperatingMode.guest
                    ? 'Enter as Guest'
                    : 'Continue to Sign In',
                onPressed: _onContinue,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
