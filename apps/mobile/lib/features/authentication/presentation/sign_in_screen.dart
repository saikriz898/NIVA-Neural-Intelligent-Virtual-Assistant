import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/app_providers.dart';
import '../../../core/constants/niva_colors.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/niva_typography.dart';
import '../../../shared/models/operating_mode.dart';
import '../../../shared/widgets/niva_app_bar.dart';
import '../../../shared/widgets/niva_button.dart';
import '../../../shared/widgets/niva_card.dart';

/// Sign-in screen for Registered Mode users.
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignIn() {
    setState(() => _isLoading = true);
    // Placeholder sign-in: Set operating mode to registered and go to home
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        ref
            .read(operatingModeProvider.notifier)
            .setMode(OperatingMode.registered);
        ref.read(onboardingCompletedProvider.notifier).setCompleted(true);
        context.go(RouteNames.home);
      }
    });
  }

  void _continueAsGuest() {
    ref.read(operatingModeProvider.notifier).setMode(OperatingMode.guest);
    ref.read(onboardingCompletedProvider.notifier).setCompleted(true);
    context.go(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const NivaAppBar(title: 'Sign In', showBrandSymbol: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style: NivaTypography.displayMedium.copyWith(
                  color: isDark ? NivaColors.porcelain : NivaColors.midnight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Access your synchronized accounts and workspaces.',
                style: NivaTypography.bodyMedium.copyWith(
                  color: isDark
                      ? NivaColors.platinum
                      : NivaColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 32),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 24),

              NivaButton(
                text: 'Sign In',
                isLoading: _isLoading,
                onPressed: _onSignIn,
              ),
              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: () => context.push(RouteNames.signUp),
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                      color: isDark
                          ? NivaColors.electricCyan
                          : NivaColors.deepNavy,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              NivaCard(
                backgroundColor: isDark
                    ? NivaColors.surfaceDark
                    : NivaColors.platinum.withValues(alpha: 0.15),
                child: Column(
                  children: [
                    Text(
                      'Prefer to keep records only on this phone?',
                      style: NivaTypography.labelMedium,
                    ),
                    const SizedBox(height: 8),
                    NivaButton(
                      text: 'Use Guest Mode (Device-Local)',
                      variant: NivaButtonVariant.outline,
                      onPressed: _continueAsGuest,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
