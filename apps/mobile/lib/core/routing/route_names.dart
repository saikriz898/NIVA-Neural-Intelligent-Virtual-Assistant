/// Strongly typed route paths and names for go_router navigation.
abstract final class RouteNames {
  static const String onboarding = '/onboarding';
  static const String signIn = '/auth/sign-in';
  static const String signUp = '/auth/sign-up';

  // Five primary shell destinations
  static const String home = '/home';
  static const String activity = '/activity';
  static const String raaz = '/raaz';
  static const String plans = '/plans';
  static const String you = '/you';

  // Feature detail routes
  static const String accounts = '/accounts';
  static const String addAccount = '/accounts/new';

  static const String recordExpense = '/transactions/record-expense';
  static const String recordIncome = '/transactions/record-income';
  static const String recordTransfer = '/transactions/record-transfer';

  static const String splits = '/splits';
  static const String splitDetails = '/splits/:id';

  static const String settlements = '/settlements';
  static const String budgets = '/budgets';
  static const String goals = '/goals';
  static const String workspaces = '/workspaces';

  static const String settings = '/settings';
  static const String securitySettings = '/settings/security';
  static const String guestBackup = '/settings/backup';
}
