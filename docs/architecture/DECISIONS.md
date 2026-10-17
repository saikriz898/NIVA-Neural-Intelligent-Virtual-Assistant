# Architecture Decision Register — Initial Baseline

| ID | Decision | Status |
|---|---|---|
| NIVA-ARCH-001 | NIVA = Neural Intelligent Virtual Assistant | Baseline |
| NIVA-ARCH-002 | RAAZ is integrated, not a separate financial wallet | Baseline |
| NIVA-ARCH-003 | Guest Mode device-only authority | Baseline |
| NIVA-ARCH-004 | Registered backend ledger authority | Baseline |
| NIVA-ARCH-005 | No duplicate balance for the same real account/owner | Baseline |
| NIVA-ARCH-006 | Protected explicit Guest migration; idempotent synchronization | Baseline |
| NIVA-ARCH-007 | Financial mutations through deterministic NIVA services | Baseline |
| NIVA-ARCH-008 | RAAZ trained from scratch, no pretrained weights or external hosted AI | Baseline |
| NIVA-ARCH-009 | Flutter/Dart Android; Next.js/TS web; Flutter iOS planned | Selected |
| NIVA-ARCH-010 | Drift/SQLite encrypted local data, Express/TS and PostgreSQL | Selected, validation pending |
| NIVA-ARCH-011 | Firebase Authentication for Registered identity only | Selected, integration pending |
| NIVA-ARCH-012 | Manual transaction recording, not real bank/UPI transfer | Baseline |
| NIVA-ARCH-013 | Minor access disabled until legal/safety gates are approved | Baseline |

**Pending:** key management and backup specifications, production hosting/region, journal model sign-off, inventory valuation, model dataset/performance gates and license decision. Design-stage choices do not imply tested implementations.
