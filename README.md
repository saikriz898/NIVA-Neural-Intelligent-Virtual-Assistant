# NIVA — Neural Intelligent Virtual Assistant

**Your Money. Your Intelligence. Your Future.**

NIVA is a local-first, privacy-conscious financial management product for personal, household, and small-business records. **RAAZ** is the integrated, separately trained financial ML assistant.

> **Status:** Repository initialization / architecture and UI specifications in review. No live financial services, bank transfers, pretrained language model, or production-ready security controls are implemented yet.

## What NIVA will do

- **Guest Mode:** device-only financial recordkeeping; no automatic uploads or server recovery.
- **Registered Mode:** authenticated access and securely synchronized authorized records.
- **Accounts and activity:** exact-money recordkeeping, income, expenses, transfers *recorded for reference*, budgets, savings, receivables, split bills and repayments.
- **Workspaces:** Personal, Household and Business, with independent authorization boundaries.
- **RAAZ:** project-trained intent, entity extraction, categorization and guided conversation, with deterministic NIVA validation.
- **Platforms:** Flutter Android first → Next.js web → Flutter iOS.

**Financial truth:** NIVA records reference information and does **not** execute bank/UPI transfers in the initial release. Recording a repayment is not proof money arrived. Future regulated payment integrations require separate consent, security and legal reviews.

**AI independence:** RAAZ's core ML models are planned for training from scratch with project-controlled, approved datasets; no pretrained foundation-model weights or external hosted AI inference APIs are part of the baseline.

## Repository map

| Location | Purpose |
|---|---|
| `apps/mobile/` | Flutter Android-first client |
| `apps/web/` | Next.js authenticated web |
| `services/api/` | Node.js/TypeScript/Express backend |
| `ml/raaz/` | Independently trained RAAZ ML pipeline |
| `contracts/` | OpenAPI and financial-event schemas |
| `docs/` | Product, architecture, design, ADRs and security |
| `assets/branding/` | NIVA brand tokens and versioned illustrations |
| `.github/` | Templates and repository automation |

The directories currently contain architecture notes/placeholders, not generated applications. Do not assume they are runnable until their respective bootstrap milestones.

## Getting started

1. Read [`docs/architecture/OVERVIEW.md`](docs/architecture/OVERVIEW.md).
2. Review [`docs/architecture/DECISIONS.md`](docs/architecture/DECISIONS.md) and [`docs/security/SECURITY_BASELINE.md`](docs/security/SECURITY_BASELINE.md).
3. Use [`docs/roadmap/INITIALIZATION.md`](docs/roadmap/INITIALIZATION.md) to track actual implementation.
4. Follow [`CONTRIBUTING.md`](CONTRIBUTING.md) before opening a PR.

### Brand

![NIVA mark](assets/branding/niva-symbol.svg)

Colors and usage: [`assets/branding/BRAND_GUIDE.md`](assets/branding/BRAND_GUIDE.md). The included SVG is a clean repository-safe brand interpretation; the previously approved metallic PNG master and app-icon exports should be imported as exact assets after visual review.

## Privacy and safety

This repository is **public**. Never commit financial records, account numbers, bank secrets, tokens, credentials, local database files, real conversations, personal training data or private backups. See [`SECURITY.md`](SECURITY.md).

## License

No open-source license is granted yet. Third-party contributions and public release require an explicit licensing decision. All rights reserved by the respective rights holder unless stated otherwise.
