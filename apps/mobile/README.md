# NIVA Mobile — Flutter Application (Phase 1)

Official mobile application for **NIVA — Neural Intelligent Virtual Assistant**, a privacy-first, local-first financial management platform.

## Architecture & Technology Stack

- **Framework:** Flutter (Channel stable, 3.47.7+)
- **Language:** Dart 3.13.5+
- **Architecture:** Feature-first modular architecture with presentation, domain, and data layers
- **State Management:** Riverpod (`flutter_riverpod: ^3.4.3`)
- **Declarative Navigation:** GoRouter (`go_router: ^18.1.0`)
- **Persistence (Planned Phase 1 Target):** Encrypted Drift / SQLite
- **Design System:** NIVA official color tokens (Midnight, Deep Navy, Electric Cyan, Teal, Platinum, Porcelain) and Inter typography

## Project Structure

```text
apps/mobile/lib/
├── app/                        # Root application widget and global Riverpod providers
│   ├── app.dart
│   └── app_providers.dart
├── core/                       # Core system foundations
│   ├── constants/              # NivaColors and AppConstants
│   ├── errors/                 # AppFailure and error domain hierarchy
│   ├── routing/                # GoRouter route tree and RouteNames
│   ├── theme/                  # NivaTheme, NivaColorTokens extension, and typography
│   └── utilities/              # Integer-based MoneyFormatter and DateFormatter
├── shared/                     # Reusable cross-feature widgets and models
│   ├── models/                 # FinancialAmount (integer minor units), OperatingMode
│   └── widgets/                # NivaAppBar, NivaButton, NivaCard, NivaShell, NivaSymbol, NivaStatusBadge
└── features/                   # Feature-first modules
    ├── onboarding/             # Language selection, 18+ eligibility gate, Guest/Registered choice
    ├── authentication/         # Sign In and Sign Up for Registered Mode
    ├── dashboard/              # Home dashboard, Plans hub, and You user hub
    ├── accounts/               # Money accounts and opening balances
    ├── transactions/           # Financial activity ledger, expense/income, Record Transfer
    ├── splits/                 # Split bill management, participant shares, partial repayments
    ├── settlements/            # Linked repayments without duplicating income
    ├── budgets/                # Category spending limits and reserved allocations
    ├── goals/                  # Savings targets and progress tracking
    ├── raaz/                   # Own-trained RAAZ ML companion (English, Tamil, Tanglish)
    ├── workspaces/             # Personal, Household, and Business workspace separation
    └── settings/               # App preferences, biometric security, and encrypted Guest backup
```

## Setup, Run & Test Commands

All commands should be executed from within `apps/mobile/` or pointing to this directory:

### 1. Install Dependencies
```bash
cd apps/mobile
flutter pub get
```

### 2. Format Code
```bash
dart format .
```

### 3. Run Static Analysis
```bash
flutter analyze
```

### 4. Run Automated Widget & Domain Tests
```bash
flutter test
```

### 5. Run Mobile Application
```bash
# List available devices / emulators
flutter devices

# Run on target device (e.g. Android emulator or connected device)
flutter run
```

## Key Financial Invariants & Product Rules

1. **Integer Minor Units:** Ledger balances and financial calculations **NEVER** use floating-point types (`double`). All monetary values are represented as integer minor units (`int minorUnits`, e.g. 100 paise = ₹1.00).
2. **Guest Mode Device Authority:** Guest Mode records are stored exclusively in an encrypted SQLite database on the local device. No automatic or silent cloud uploads occur.
3. **Registered Mode Backend Authority:** Registered Mode uses a backend-authoritative PostgreSQL journal with conflict-aware synchronization.
4. **No Live Payment Execution:** NIVA records observed and manual transactions. Transfers between user accounts are explicitly labeled **"Record Transfer"** and do not generate income or execute live bank movements.
5. **Split Bill Accounting:** Splits record who paid the original bill and track individual partial repayments. Repayments reduce outstanding receivables and are never recorded as new income.
6. **RAAZ Machine Learning Companion:** RAAZ models are trained from scratch without external hosted foundation APIs. RAAZ prepares drafts and explains data; it **cannot** independently authorize or commit transactions to the financial ledger.
7. **Age Eligibility:** Initial release is restricted to adults aged 18 and older. Minor access (ages 15–17) remains disabled until dedicated legal and guardian consent frameworks are approved.
8. **No Splash Screens:** Instant launch into the application experience per product requirements.
