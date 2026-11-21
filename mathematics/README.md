# KAIROSEED Mathematical Research Workstream

**Branch:** `research/pnp-navier-stokes-verification`  
**Parent:** `main`  
**Status:** Research protocol and problem specifications proposed; no resolution of either open problem is claimed.

## Purpose

This workstream develops a reproducible, evidence-bounded method for formalizing and evaluating mathematical arguments concerning:

1. **P vs NP** — whether every language decidable in nondeterministic polynomial time is decidable in deterministic polynomial time.
2. **Navier–Stokes existence and smoothness** — the global existence and regularity question for the three-dimensional incompressible Navier–Stokes equations under a precisely stated admissible-data and domain formulation.

The workstream is about mathematical specification, proof development, validation, and verification. It does not assert that either problem has been solved.

## Files

- [Shared Validation and Verification Protocol](verification-protocol.md)
- [P vs NP Research Specification](p-vs-np/README.md)
- [Navier–Stokes Research Specification](navier-stokes/README.md)

## Shared research pipeline

`Source problem → Challenge.lean → Equivalence.lean → Solution.lean → kernel check → reproducible evidence → independent review`

Each stage has a distinct burden:

- **Source problem:** authoritative mathematical statement and scope.
- **Challenge:** explicit definitions, hypotheses, quantifiers, and target theorem.
- **Equivalence:** proof that the formal statement faithfully represents the source problem.
- **Solution:** proof of the target theorem or a precisely formulated counterexample, without hiding the target in assumptions.
- **Kernel check:** machine checking of the proof term in a pinned environment.
- **Evidence:** build logs, dependency versions, hashes, axiom audit, and reproducibility instructions.
- **Independent review:** separate assessment of source fidelity, proof dependencies, and interpretation.

A successful check of one stage does not automatically discharge later stages.

## Status vocabulary

Use only scoped, evidence-backed statuses:

- `PROPOSED`
- `SPECIFIED`
- `FORMALIZED`
- `VALIDATED`
- `KERNEL_CHECKED`
- `REPRODUCIBLE`
- `INDEPENDENTLY_REVIEWED`
- `OPEN`
- `FAILED`
- `NOT_VERIFIED`

A Lean kernel check means that the kernel accepted a formal proof term relative to the recorded environment and axioms. It does not, by itself, establish that the formal theorem is the intended source problem, that assumptions are appropriate, or that an independent mathematical review has occurred.

## Non-claims

- No proof of (P=NP) or (P\ne NP) is claimed.
- No proof of global regularity or finite-time breakdown for the full three-dimensional incompressible Navier–Stokes problem is claimed.
- A conditional regularity theorem is not a solution of the unrestricted global problem.
- A formalized statement is not a proved statement.
- A green build is not a substitute for source fidelity, axiom review, or independent scrutiny.
