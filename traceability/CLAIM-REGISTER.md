# Claim Register

**Document ID:** KRS-CLAIMS-001  
**Version:** 0.1  
**Status:** PROPOSED

This register assigns stable identifiers to substantive claims in the KAIROSEED manuscript. The traceability matrix is the authoritative cross-reference for specifications, implementations, tests, and evidence.

| Claim ID | Short name | Claim boundary | Initial status |
|---|---|---|---|
| KRS-C-001 | Capability/authority separation | Architectural invariant; does not alone prove enforcement | PROPOSED |
| KRS-C-002 | Proposal/authorization separation | Lifecycle distinction | PROPOSED |
| KRS-C-003 | GOVANA authorization | Bounded authorization under specified policy and authority assumptions | PROPOSED |
| KRS-C-004 | Deterministic evaluation | Determinism for fixed complete inputs, policy version, and evaluator configuration | PROPOSED |
| KRS-C-005 | Conflict fail-closed | Unresolved conflict cannot produce authorization | PROPOSED |
| KRS-C-006 | PEP re-verification | PEP validates the token and action context at enforcement boundary | PROPOSED |
| KRS-C-007 | Scope preservation | Executed operations remain within the granted scope | PROPOSED |
| KRS-C-008 | Runtime boundedness | JIREH enforces specified runtime invariants within a declared threat model | PROPOSED |
| KRS-C-009 | Monitoring fail-safe | Loss of mandatory monitoring prevents protected execution | PROPOSED |
| KRS-C-010 | Receipt attribution | Receipt records identify relevant decision and execution events | PROPOSED |
| KRS-C-011 | Hash-chain integrity | Alteration of linked receipts is detectable under stated assumptions | PROPOSED |
| KRS-C-012 | Cryptographic validation | Token integrity and authenticity are checked under a declared key-trust model | PROPOSED |
| KRS-C-013 | Replay protection | Reuse is rejected within the documented consistency and persistence model | PROPOSED |
| KRS-C-014 | R-08 disclosure | Reported negative finding; original artifacts required | NOT_VERIFIED |
| KRS-C-015 | MUTATED_UNLOGGED disclosure | Reported state-mutation bypass; reproduction and regression evidence required | NOT_VERIFIED |
| KRS-C-016 | Mutation attribution | Every protected mutation is linked to authorization and attributable evidence | OPEN |

## Claim wording rule

Claims must be no broader than their evidence. Prefer bounded formulations such as:

- “The tested implementation rejects the supplied expired-token test vector.”
- “The formal model proves the stated invariant under assumptions A–C.”

Avoid unbounded formulations such as:

- “The system is secure.”
- “All unauthorized actions are impossible.”
- “The ledger proves that no event was omitted.”

## Change record

| Version | Change |
|---|---|
| 0.1 | Initial claim identifiers and boundaries established |
