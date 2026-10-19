import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:niva/app/app.dart';
import 'package:niva/app/app_providers.dart';
import 'package:niva/core/constants/app_constants.dart';
import 'package:niva/core/theme/niva_theme.dart';
import 'package:niva/core/utilities/money_formatter.dart';
import 'package:niva/shared/models/financial_amount.dart';
import 'package:niva/shared/models/operating_mode.dart';

class _TestOnboardingNotifier extends OnboardingCompletedNotifier {
  @override
  bool build() => true;
}

class _TestOperatingModeNotifier extends OperatingModeNotifier {
  @override
  OperatingMode build() => OperatingMode.guest;
}

void main() {
  group('NIVA Financial Invariants & Domain Tests', () {
    test('FinancialAmount enforces integer minor units without float loss', () {
      const amount1 = FinancialAmount(120000); // ₹1,200.00
      const amount2 = FinancialAmount(30000); // ₹300.00

      expect(amount1.minorUnits, 120000);
      expect(amount1.format(), '₹1,200.00');

      final sum = amount1 + amount2;
      expect(sum.minorUnits, 150000);
      expect(sum.format(), '₹1,500.00');

      final diff = amount1 - amount2;
      expect(diff.minorUnits, 90000);
      expect(diff.format(), '₹900.00');
    });

    test(
      'MoneyFormatter parses string amounts into exact integer minor units',
      () {
        expect(MoneyFormatter.tryParseToMinorUnits('1200'), 120000);
        expect(MoneyFormatter.tryParseToMinorUnits('1,200.50'), 120050);
        expect(MoneyFormatter.tryParseToMinorUnits('₹48,250.75'), 4825075);
        expect(MoneyFormatter.tryParseToMinorUnits('invalid'), isNull);
      },
    );

    test('NivaColorTokens theme extension provides approved brand palette', () {
      final darkTokens = NivaColorTokens.dark;
      expect(darkTokens.midnight, const Color(0xFF081729));
      expect(darkTokens.deepNavy, const Color(0xFF082D6B));
      expect(darkTokens.electricCyan, const Color(0xFF00AFFF));
      expect(darkTokens.teal, const Color(0xFF00D6A3));
      expect(darkTokens.platinum, const Color(0xFFC6CDD8));
      expect(darkTokens.porcelain, const Color(0xFFF7F8FA));
    });
  });

  group('NIVA App & Widget Navigation Tests', () {
    testWidgets(
      'App renders onboarding with 18+ eligibility gate and brand symbol',
      (tester) async {
        await tester.pumpWidget(const ProviderScope(child: NivaApp()));
        await tester.pumpAndSettle();

        // Verify Brand Name & Tagline
        expect(find.text(AppConstants.appName), findsOneWidget);
        expect(find.text(AppConstants.appTagline), findsOneWidget);

        // Verify Language selector options
        expect(find.text('English'), findsOneWidget);
        expect(find.text('தமிழ் (Tamil)'), findsOneWidget);
        expect(find.text('Tanglish'), findsOneWidget);

        // Verify Mode selections
        expect(find.text('Guest Mode'), findsOneWidget);
        expect(find.text('Registered Mode'), findsOneWidget);

        // Verify 18+ Eligibility Checkbox
        expect(find.text('Eligibility Confirmation (18+)'), findsOneWidget);
      },
    );

    testWidgets('Cannot proceed past onboarding without confirming 18+ age', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(const ProviderScope(child: NivaApp()));
      await tester.pumpAndSettle();

      // Tap 'Enter as Guest' without checking 18+ box
      final enterButton = find.text('Enter as Guest');
      expect(enterButton, findsOneWidget);
      await tester.tap(enterButton);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      // Snack bar warning displayed
      expect(
        find.textContaining(
          'Initial eligibility requires confirming you are 18',
        ),
        findsOneWidget,
      );
    });

    testWidgets(
      'Main shell renders 5 primary navigation destinations when authenticated/home',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              onboardingCompletedProvider.overrideWith(
                _TestOnboardingNotifier.new,
              ),
              operatingModeProvider.overrideWith(
                _TestOperatingModeNotifier.new,
              ),
            ],
            child: const NivaApp(),
          ),
        );
        await tester.pumpAndSettle();

        // If user confirms 18+ and enters, verify bottom navigation bar has the 5 destinations:
        // Home, Activity, RAAZ, Plans, You
        expect(find.byType(NavigationBar), findsOneWidget);
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Activity'), findsOneWidget);
        expect(find.text('RAAZ'), findsOneWidget);
        expect(find.text('Plans'), findsOneWidget);
        expect(find.text('You'), findsOneWidget);
      },
    );

    testWidgets(
      'Dashboard displays recorded balance and Record Transfer action',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              onboardingCompletedProvider.overrideWith(
                _TestOnboardingNotifier.new,
              ),
              operatingModeProvider.overrideWith(
                _TestOperatingModeNotifier.new,
              ),
            ],
            child: const NivaApp(),
          ),
        );
        await tester.pumpAndSettle();

        // Check Recorded Balance Label
        expect(find.text('Recorded Total Balance'), findsOneWidget);

        // Check Record Transfer action button
        expect(find.text(AppConstants.recordTransferLabel), findsOneWidget);
      },
    );
  });
}
