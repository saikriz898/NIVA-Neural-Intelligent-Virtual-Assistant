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

/// Sign-up screen for creating a new Registered account.
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isAgeConfirmed = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUp() {
    if (!_isAgeConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'You must confirm you are 18 years or older to register.',
          ),
          backgroundColor: NivaColors.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const NivaAppBar(title: 'Create Account'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Join NIVA',
                style: NivaTypography.displayMedium.copyWith(
                  color: isDark ? NivaColors.porcelain : NivaColors.midnight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Create your personal financial profile with backend-synchronized recovery.',
                style: NivaTypography.bodyMedium.copyWith(
                  color: isDark
                      ? NivaColors.platinum
                      : NivaColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 32),

              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 20),

              Row(
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
                    child: Text(
                      'I confirm I am 18 years of age or older.',
                      style: NivaTypography.bodySmall.copyWith(
                        color: isDark
                            ? NivaColors.platinum
                            : NivaColors.textSecondaryLight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              NivaButton(
                text: 'Create Account',
                isLoading: _isLoading,
                onPressed: _onSignUp,
              ),
              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: () => context.pop(),
                  child: Text(
                    'Already have an account? Sign In',
                    style: TextStyle(
                      color: isDark
                          ? NivaColors.electricCyan
                          : NivaColors.deepNavy,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
