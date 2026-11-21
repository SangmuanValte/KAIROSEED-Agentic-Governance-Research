# KAIROSEED: Verification-First Governance for Bounded Authorization of Agentic Systems

**Subtitle:** Design Foundations, Governance Architecture, and Cryptographic Enforcement

**Status:** PROPOSED · UNVERIFIED  
**Research owner:** Sangmuan Valte  
**Repository:** KAIROSEED-Agentic-Governance-Research

## Purpose

This repository documents the KAIROSEED research architecture, its specifications, manuscript claims, evaluation plans, and supporting evidence. Its primary purpose is to make every substantive paper claim traceable to a specification, implementation, test, evidence artifact, and verification status.

## Central research invariant

\[
\text{Capability} \not\Rightarrow \text{Authority}
\]

An agent's technical ability to invoke a tool or mutate state does not, by itself, establish permission to perform that operation.

## Research contributions

1. **GOVANA Core and Constraint Language** — proposed pre-execution governance evaluation and deterministic policy-rule processing.
2. **PEP and JIREH** — proposed authorization re-verification and bounded runtime execution controls.
3. **Cryptographic Receipt and Ledger Layer** — proposed refusal codes, hash-chained receipts, and replayable audit artifacts.

## Important status boundary

This repository is a research and documentation workspace. Repository creation, specification publication, code presence, or a passing test does not by itself establish security, correctness, independent verification, or production readiness.

The following are explicitly open until evidence is added and reviewed:

- independent third-party verification and external audit;
- production key custody and hardware-backed signing;
- definition and closure of gate G-04;
- formal proof closure;
- reproducibility and regression evidence for R-08 and MUTATED_UNLOGGED.

## Repository map

- `manuscript/` — paper drafts and bibliographic material.
- `specification/` — normative system and component specifications.
- `traceability/` — claim, requirement, test, and evidence registers.
- `experiments/` — experiment protocols and results, including negative findings.
- `formal/` — formal models, proof artifacts, and proof-status records.
- `evidence/` — immutable or versioned evidence artifacts and digests.
- `governance/` — claim-status, change-control, and release policies.

## Traceability workflow

Every claim receives a stable identifier. Follow the chain:

**Manuscript claim → Specification → Implementation → Test → Evidence → Verification status**

Missing links must be recorded as missing. Do not infer implementation or verification from prose.

Start with:
- [Traceability Matrix](traceability/TRACEABILITY-MATRIX.md)
- [Claim Register](traceability/CLAIM-REGISTER.md)
- [Requirements Register](traceability/REQUIREMENTS-REGISTER.md)
- [Evidence Register](traceability/EVIDENCE-REGISTER.md)
- [Claim Status Policy](governance/claim-status-policy.md)
- [Manuscript workspace](manuscript/README.md)

## Disclosure and research integrity

Negative findings must be retained, not silently removed after a redesign. In particular, R-08 and MUTATED_UNLOGGED require original test conditions, observed outcomes, corrective changes, and regression evidence before any resolution claim is made.

## Licensing governance and reuse

No repository-wide license is asserted by this initial documentation commit. Candidate classifications are not license grants. Ownership, provenance, third-party rights, and licensing authority must be reviewed before any license is applied. See the [licensing governance index](licensing/README.md), [repository audit](licensing/KAIROSEED-LIC-002-REPOSITORY-AUDIT.md), [manifest verification specification](licensing/KAIROSEED-LIC-003-MANIFEST-VERIFICATION-SPECIFICATION.md), and [provenance specification](licensing/KAIROSEED-PROV-001-PROVENANCE-SPECIFICATION.md).

## Research disposition

**PROPOSED · UNVERIFIED · NOT PRODUCTION AUTHORIZED**
