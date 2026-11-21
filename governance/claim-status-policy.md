# Claim Status and Evidence Policy

**Document ID:** KRS-GOV-001  
**Version:** 0.1

## Purpose

This policy governs how manuscript claims and engineering requirements are described, tested, and promoted through evidence states.

## Status meanings

- **PROPOSED:** intended design or hypothesis; no implementation implied.
- **SPECIFIED:** a versioned specification exists and has been reviewed for internal consistency.
- **IMPLEMENTED:** source code or configuration exists at a pinned revision.
- **TESTED:** a defined test was executed and its inputs and outputs retained.
- **TEST_FAILED:** observed behavior did not satisfy the preregistered expected result.
- **FORMALLY_VERIFIED:** a formal proof establishes the exact stated theorem under declared assumptions.
- **INDEPENDENTLY_VERIFIED:** an appropriately independent reviewer verified the stated scope.
- **NOT_VERIFIED:** evidence is missing, incomplete, or insufficient.
- **OPEN:** an unmet requirement remains.

These are not necessarily a single linear maturity ladder. A component may be implemented and tested while remaining not independently verified.

## Promotion requirements

1. PROPOSED → SPECIFIED: versioned specification and review record.
2. SPECIFIED → IMPLEMENTED: source revision and implementation mapping.
3. IMPLEMENTED → TESTED: reproducible test protocol, expected result, observed result, and retained output.
4. FORMALLY_VERIFIED: theorem, assumptions, proof artifact, tool/version, and proof-check result.
5. INDEPENDENTLY_VERIFIED: reviewer identity/role, independence basis, scope, method, findings, and report.

No automatic promotion occurs.

## Failure disclosure

Negative results must remain in the research record. Corrective work must link to the original failure and include regression evidence. A later passing test does not erase the earlier failure.

## Security claim limits

- A valid signature does not establish legitimate authority.
- A hash chain does not establish event completeness.
- A deterministic evaluator does not establish policy correctness.
- A passing test does not prove absence of untested bypasses.
- A formal proof of an abstract model does not automatically prove source-code conformance.
- Separate component names do not establish organizational or technical independence.

## Release boundary

No release may imply production authorization, external certification, or independent verification without corresponding evidence and approval.
