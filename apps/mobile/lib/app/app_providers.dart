import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../shared/models/operating_mode.dart';

/// Notifier and provider for managing application theme mode (System / Dark / Light).
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.dark;

  void setMode(ThemeMode mode) => state = mode;
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

/// Notifier and provider for managing active operating mode (Guest / Registered).
class OperatingModeNotifier extends Notifier<OperatingMode> {
  @override
  OperatingMode build() => OperatingMode.guest;

  void setMode(OperatingMode mode) => state = mode;
}

final operatingModeProvider =
    NotifierProvider<OperatingModeNotifier, OperatingMode>(
      OperatingModeNotifier.new,
    );

/// Notifier and provider tracking whether onboarding has been completed.
class OnboardingCompletedNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void setCompleted(bool completed) => state = completed;
}

final onboardingCompletedProvider =
    NotifierProvider<OnboardingCompletedNotifier, bool>(
      OnboardingCompletedNotifier.new,
    );
