# P vs NP — Research Specification

**Track ID:** KAIROSEED-PNP-001  
**Status:** PROPOSED; problem remains OPEN.

## 1. Governing principle

**Define computation first; measure it second; classify it third; prove complexity results last.**

The formalization must not begin by defining P or NP over an unexplained abstract algorithm interface and then treating those definitions as the standard complexity classes. It must first specify what a machine is and what constitutes a computation.

## 2. Source problem

Determine whether (P=NP), equivalently whether every decision language with polynomial-time nondeterministic verification also has a deterministic polynomial-time decision algorithm, under the standard complexity-theoretic definitions.

No proof of (P=NP) or (P\ne NP) is claimed here.

## 3. Required order of formalization

### Stage 1 — Computational model

File: [`MachineModel.lean`](MachineModel.lean)

Specify:
- The machine and its control states.
- The tape alphabet and input encoding.
- The tape and head position.
- Complete configurations.
- The transition function and one-step semantics.
- Accepting and rejecting halting states.
- Finite computation traces and trace validity.

The current Lean file proposes a deterministic, single-tape, two-way-infinite Turing machine with a finite binary input encoding and a three-symbol tape alphabet. It is a proposed model, not yet a verified equivalence with every conventional Turing-machine formulation.

### Stage 2 — Computation measurement

Define the step count as the number of valid transitions in a finite computation trace. Then prove that the trace representation and step-count definition agree with the operational machine semantics.

Required obligations include:
- Every adjacent pair in a valid trace is a permitted machine transition.
- A halted configuration has no successor.
- Determinism yields at most one next configuration from a given configuration.
- Accept and reject are disjoint.
- Input length is determined by the input encoding, not by execution.
- The chosen cost measure is related to standard machine-step counting.

### Stage 3 — Complexity classification

Only after Stages 1 and 2:
- Define polynomial resource bounds over the selected input-length measure.
- Define P using deterministic machines that halt with the correct decision within a polynomial bound.
- Define NP using a nondeterministic machine model or a polynomial-time verifier with polynomially bounded certificates.
- Prove the equivalence of the selected NP formulations.
- Prove polynomial-overhead simulation results for any alternative machine or encoding conventions used.

### Stage 4 — Complexity results

Only after the model and class correspondence obligations:
- Define polynomial-time many-one reductions.
- Fix the exact SAT language and encoding.
- Prove SAT belongs to NP.
- Prove SAT is NP-hard under the declared reduction.
- Derive SAT NP-completeness.
- Derive the equivalence between P=NP and SAT belonging to P under the established definitions.
- Keep the unrestricted P vs NP resolution as a separate target.

## 4. Current Lean artifacts and limitations

### `MachineModel.lean`

Status: **PROPOSED; not compiled or independently reviewed.**

It introduces the deterministic machine, configurations, tape encoding, transition step, finite traces, acceptance/rejection predicates, and input-length function. Its definitions are a starting specification. The following proof obligations remain open:
- Prove determinism of the one-step semantics.
- Prove acceptance and rejection are mutually exclusive.
- Establish trace-length/transition-count correspondence, including the empty-trace convention.
- Clarify total transition behavior and halting semantics.
- Prove adequacy relative to the intended standard Turing-machine model.
- Compile in a pinned Lean/Mathlib environment and record exact output.

### `Challenge.lean`

Status: **ABSTRACT SPECIFICATION SCAFFOLD; not the final definition of P or NP.**

Its decider and verifier are abstract functions equipped with cost bounds. They do not yet execute on the concrete machine defined in `MachineModel.lean`. Do not use their class predicates as established standard P and NP until a correspondence theorem connects the interfaces.

## 5. Later proof pipeline

### `Equivalence.lean`

Prove correspondence between the concrete machine semantics, resource measures, encodings, and standard complexity-theory definitions. Expected results include P ⊆ NP, SAT ∈ NP, SAT NP-hardness, SAT NP-completeness, and the SAT/P=NP equivalence. Each result must depend on established preceding lemmas, not assumed claims.

### `Solution.lean`

The resolution target is exactly one of:
- A valid proof of (P=NP); or
- A valid proof of (P\ne NP).

A result about a restricted circuit class, oracle-relative result, conditional statement, or special-case language is not a solution of the unrestricted problem. Such results must be labelled by their exact scope.

No `sorry`, `admit`, or hidden axiom may discharge the target.

## 6. Evidence and verification checklist

- [ ] Computational model explicitly specified.
- [ ] Input encoding and input-length measure fixed.
- [ ] Transition and halting semantics specified.
- [ ] Trace validity and step counting formally related.
- [ ] Determinism and accept/reject disjointness proved.
- [ ] Concrete model compiled in a pinned Lean/Mathlib environment.
- [ ] Polynomial bounds explicitly quantified.
- [ ] P and NP defined over the selected model.
- [ ] Verifier/witness definition proved equivalent to selected NP definition.
- [ ] Encoding and machine simulations shown to incur polynomial overhead.
- [ ] Reduction notion fixed and proved to preserve required bounds.
- [ ] SAT encoding and membership proof checked.
- [ ] NP-hardness proof checked.
- [ ] (P=NP iff SAT ∈ P) proved from preceding results.
- [ ] Target proof contains no `sorry` or `admit`.
- [ ] Axiom and dependency audit completed.
- [ ] Clean independent build reproduced.
- [ ] Independent mathematical review completed.

## 7. Known mathematical context

Standard established inclusions and completeness results are useful scaffolding, not a resolution:
- P ⊆ NP.
- SAT is NP-complete under polynomial-time many-one reductions.
- Therefore SAT ∈ P would imply P=NP.

Relativization, natural-proofs, and algebrization are known barrier frameworks relevant to many proof approaches. They are not proofs that P ≠ NP, nor do they show that all possible proof methods are impossible.

## 8. Current conclusion

**P vs NP remains OPEN.** The repository currently contains a proposed machine-model specification and an abstract P/NP scaffold. It does not yet contain a compiled, validated standard complexity formalization or a solution theorem.
