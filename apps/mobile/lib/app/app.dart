import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../core/routing/app_router.dart';
import '../core/theme/niva_theme.dart';
import 'app_providers.dart';

/// Root application widget for NIVA.
///
/// Configures MaterialApp with:
/// - Declarative go_router integration
/// - NIVA light and dark themes
/// - ThemeMode state management via Riverpod
class NivaApp extends ConsumerWidget {
  const NivaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: NivaTheme.lightTheme,
      darkTheme: NivaTheme.darkTheme,
      themeMode: themeMode,
    );
  }
}
