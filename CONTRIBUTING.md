# Contributing to NIVA

NIVA is under architecture review and not ready for real financial data. Use feature branches and PRs; do not push experiments directly to `main`.

## Contribution requirements
- Discuss financial behavior changes before coding; cite PRD/TRD/LLD decision and include deterministic test fixtures.
- All monetary values must use exact minor units; financial actions require explicit user confirmation and validated domain services.
- Do not introduce external pretrained AI models or hosted AI APIs to RAAZ.
- Preserve Guest device-only privacy and backend resource-level authorization for Registered Mode.
- Update design docs and add failure-case tests along with any API/schema change.
- Don't commit secrets, private records, protected receipts, user conversations, copied bank statements or unapproved ML datasets.

## Code review
PRs should identify scope, affected modes, schema/API impacts, financial invariants, security risks, tests run, and rollback strategy. No claim of production readiness without evidence.

See [security policy](SECURITY.md) and [architecture decisions](docs/architecture/DECISIONS.md).
