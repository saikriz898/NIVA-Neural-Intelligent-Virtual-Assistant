# Security Policy — NIVA

**Status:** Design-stage project. Not approved for handling production financial records.

Do not include bank passwords, UPI PINs, OTPs, card secrets, financial backups, PII, recovery phrases or model-training data derived from real users in GitHub issues or PRs.

Please use a **private contact channel with the project owner** for vulnerability disclosures; a security mailbox is not yet published.

## Release gates
- Encrypted local Guest/Registered storage with verified recovery procedures
- Identity, ownership and object-level authorization with negative tests
- Journal posting consistency, concurrency and idempotency tests
- No Guest financial-data automatic network transmission
- Explicit consent and idempotent Guest migration
- Privacy-conscious observability; tested backup restores
- RAAZ trained-model provenance and safe action-confirmation boundaries

**Important:** Recording a bank transfer, loan repayment or split settlement is a NIVA reference record, **not** an actual bank/UPI transfer.
