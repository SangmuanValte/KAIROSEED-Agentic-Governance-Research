# KAIROSEED Research Claim Traceability Matrix

**Document ID:** KRS-TRACE-001  
**Version:** 0.1  
**Status:** PROPOSED  
**Last updated:** 2026-11-21

## 1. Purpose

This matrix connects each substantive manuscript claim to the specification, implementation, test, evidence artifact, and verification status needed to support it.

A claim is not established merely because it appears in the manuscript or because a corresponding component has been named.

## 2. Status vocabulary

| Status | Meaning |
|---|---|
| PROPOSED | Design intention or research hypothesis |
| SPECIFIED | Reviewable specification exists |
| IMPLEMENTED | Corresponding implementation exists at a recorded revision |
| TESTED | A defined test was executed and results retained |
| TEST_FAILED | Test produced an unsuccessful result |
| FORMALLY_VERIFIED | A formal proof establishes the stated property under declared assumptions |
| INDEPENDENTLY_VERIFIED | A suitably independent reviewer verified the stated scope |
| NOT_VERIFIED | Available evidence is insufficient |
| OPEN | Requirement remains unresolved |
| NOT_APPLICABLE | Does not apply, with documented justification |

Statuses are scoped. A unit-test pass is not an independent verification. A proof of a model is not automatically a proof of its implementation.

## 3. Claim traceability

| Claim ID | Paper section | Claim | Specification | Implementation reference | Test reference | Evidence reference | Initial status |
|---|---|---|---|---|---|---|---|
| KRS-C-001 | Introduction | Capability does not imply authority | System model; authorization boundary | TBD | TBD | TBD | PROPOSED |
| KRS-C-002 | System model | Proposal is distinct from authorization | Action lifecycle | TBD | State-transition tests TBD | TBD | PROPOSED |
| KRS-C-003 | GOVANA | GOVANA evaluates policy and grants bounded authorization | GOVANA specification | TBD | Decision/authorization tests TBD | TBD | PROPOSED |
| KRS-C-004 | Constraint Language | Policy evaluation is deterministic for fixed inputs and configuration | Constraint semantics | TBD | Determinism tests TBD | TBD | PROPOSED |
| KRS-C-005 | Constraint Language | Unresolved conflicts fail closed | Conflict semantics | TBD | Conflict/malformed-input tests TBD | TBD | PROPOSED |
| KRS-C-006 | PEP | PEP re-verifies authorization before protected execution | PEP specification | TBD | Invalid-token and bypass tests TBD | TBD | PROPOSED |
| KRS-C-007 | PEP | Executed scope does not exceed authorized scope | Scope model | TBD | Scope-escalation tests TBD | TBD | PROPOSED |
| KRS-C-008 | JIREH | Runtime execution is bounded by declared invariants | JIREH runtime specification | TBD | Runtime violation tests TBD | TBD | PROPOSED |
| KRS-C-009 | JIREH | Monitoring failure disables protected execution | Monitoring-failure specification | TBD | Fault-injection tests TBD | TBD | PROPOSED |
| KRS-C-010 | Receipt layer | Receipts record attributable decisions and outcomes | Receipt schema | TBD | Schema/attribution tests TBD | TBD | PROPOSED |
| KRS-C-011 | Ledger | Receipts are linked by a verifiable hash chain | Ledger specification | TBD | Tamper/chain verification tests TBD | TBD | PROPOSED |
| KRS-C-012 | Cryptography | Authorization envelopes are cryptographically validated | GAT and signing profile | TBD | Signature/key-validation tests TBD | TBD | PROPOSED |
| KRS-C-013 | Replay protection | Consumed authorization identifiers cannot be reused within the declared deployment scope | Replay specification | TBD | Concurrent/persistent replay tests TBD | TBD | PROPOSED |
| KRS-C-014 | Experiments | R-08 is a reproducible negative finding | Original R-08 protocol | TBD | Original reproduction and regression TBD | TBD | NOT_VERIFIED |
| KRS-C-015 | Experiments | MUTATED_UNLOGGED exposed a state-mutation bypass in an earlier prototype | Original bypass protocol | TBD | Reproduction and regression TBD | TBD | NOT_VERIFIED |
| KRS-C-016 | Security analysis | Protected mutations are attributable to authorization and evidence records | Mutation-boundary specification | TBD | Mutation-path/fault-injection tests TBD | TBD | OPEN |

## 4. Requirements traceability

| Requirement ID | Requirement | Acceptance evidence | Initial status |
|---|---|---|---|
| KRS-R-001 | Define G-04 as a testable predicate | Predicate, trusted inputs, failure semantics, reproducible tests | OPEN |
| KRS-R-002 | Establish production key custody | Key lifecycle, protected storage, rotation, revocation, audit evidence | OPEN |
| KRS-R-003 | Obtain independent third-party verification | External report with scope, methods, findings, and reviewer independence | OPEN |
| KRS-R-004 | Close formal proof obligations | Formal model, theorem statements, proof artifacts, assumption review | OPEN |
| KRS-R-005 | Establish reproducible evaluation | Versioned environment, test protocols, raw outputs, replayable artifacts | OPEN |
| KRS-R-006 | Demonstrate ledger completeness within declared threat model | Mutation-path coverage, fault injection, independent review | OPEN |
| KRS-R-007 | Establish distributed replay protection | Atomic consume semantics, concurrency tests, persistence and recovery tests, consistency assumptions | OPEN |
| KRS-R-008 | Establish receipt trust and anchoring | Canonicalization, signing/checkpoint model, truncation/replacement threat analysis | OPEN |

## 5. Evidence-link requirements

Every evidence record must identify:

- evidence ID and linked claim/requirement IDs;
- repository-relative artifact path;
- source commit SHA;
- artifact type and creation method;
- test environment and dependency versions;
- input and output digests where applicable;
- preregistered expected result;
- observed result;
- reviewer and review scope;
- limitations and unresolved anomalies.

## 6. Change control

- Retain a claim ID when its meaning remains stable.
- Allocate a new claim ID when the claim materially changes.
- Record affected manuscript sections, specifications, tests, and evidence.
- Mark evidence invalidated by a changed implementation or specification.
- Preserve failed and superseded results in Git history.
- Never promote a status without the evidence required by the status policy.

## 7. Current disposition

This is an initial traceability baseline. All implementation and evidence references marked TBD are missing, not implicitly satisfied.

**Overall:** PROPOSED · UNVERIFIED · NOT PRODUCTION AUTHORIZED.
