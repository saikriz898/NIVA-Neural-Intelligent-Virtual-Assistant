import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/app_providers.dart';
import '../../features/accounts/presentation/accounts_screen.dart';
import '../../features/accounts/presentation/add_account_screen.dart';
import '../../features/authentication/presentation/sign_in_screen.dart';
import '../../features/authentication/presentation/sign_up_screen.dart';
import '../../features/budgets/presentation/budgets_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/dashboard/presentation/plans_screen.dart';
import '../../features/dashboard/presentation/you_screen.dart';
import '../../features/goals/presentation/goals_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/raaz/presentation/raaz_screen.dart';
import '../../features/settings/presentation/guest_backup_screen.dart';
import '../../features/settings/presentation/security_settings_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/settlements/presentation/settlements_screen.dart';
import '../../features/splits/presentation/split_details_screen.dart';
import '../../features/splits/presentation/splits_screen.dart';
import '../../features/transactions/presentation/record_expense_screen.dart';
import '../../features/transactions/presentation/record_income_screen.dart';
import '../../features/transactions/presentation/record_transfer_screen.dart';
import '../../features/transactions/presentation/transactions_screen.dart';
import '../../features/workspaces/presentation/workspaces_screen.dart';
import '../../shared/widgets/niva_shell.dart';
import 'route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

/// Riverpod provider delivering the application's declarative GoRouter configuration.
final routerProvider = Provider<GoRouter>((ref) {
  final isOnboardingCompleted = ref.watch(onboardingCompletedProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: isOnboardingCompleted
        ? RouteNames.home
        : RouteNames.onboarding,
    routes: [
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RouteNames.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),

      // Five primary destinations hosted within NivaShell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NivaShell(navigationShell: navigationShell);
        },
        branches: [
          // Destination 1: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          // Destination 2: Activity
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.activity,
                builder: (context, state) => const TransactionsScreen(),
              ),
            ],
          ),
          // Destination 3: RAAZ
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.raaz,
                builder: (context, state) => const RaazScreen(),
              ),
            ],
          ),
          // Destination 4: Plans
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.plans,
                builder: (context, state) => const PlansScreen(),
              ),
            ],
          ),
          // Destination 5: You
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.you,
                builder: (context, state) => const YouScreen(),
              ),
            ],
          ),
        ],
      ),

      // Accounts
      GoRoute(
        path: RouteNames.accounts,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AccountsScreen(),
      ),
      GoRoute(
        path: RouteNames.addAccount,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const AddAccountScreen(),
      ),

      // Transactions
      GoRoute(
        path: RouteNames.recordExpense,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const RecordExpenseScreen(),
      ),
      GoRoute(
        path: RouteNames.recordIncome,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const RecordIncomeScreen(),
      ),
      GoRoute(
        path: RouteNames.recordTransfer,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const RecordTransferScreen(),
      ),

      // Splits & Settlements
      GoRoute(
        path: RouteNames.splits,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SplitsScreen(),
      ),
      GoRoute(
        path: RouteNames.splitDetails,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'split-101';
          return SplitDetailsScreen(splitId: id);
        },
      ),
      GoRoute(
        path: RouteNames.settlements,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettlementsScreen(),
      ),

      // Budgets & Goals
      GoRoute(
        path: RouteNames.budgets,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const BudgetsScreen(),
      ),
      GoRoute(
        path: RouteNames.goals,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const GoalsScreen(),
      ),

      // Workspaces
      GoRoute(
        path: RouteNames.workspaces,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const WorkspacesScreen(),
      ),

      // Settings
      GoRoute(
        path: RouteNames.settings,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: RouteNames.securitySettings,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SecuritySettingsScreen(),
      ),
      GoRoute(
        path: RouteNames.guestBackup,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const GuestBackupScreen(),
      ),
    ],
  );
});
