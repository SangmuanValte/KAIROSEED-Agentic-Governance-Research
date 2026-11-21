# P vs NP — Research Specification

**Track ID:** KAIROSEED-PNP-001  
**Status:** PROPOSED; problem remains OPEN.

## 1. Source problem

Determine whether (P=NP), equivalently whether every decision language with polynomial-time nondeterministic verification also has a deterministic polynomial-time decision algorithm, under the standard complexity-theoretic definitions.

No proof of (P=NP) or (P\ne NP) is claimed here.

## 2. Definitions to lock

The formal specification must explicitly fix:

- A finite input alphabet and language representation.
- The deterministic Turing-machine model used to define (P).
- The nondeterministic Turing-machine or polynomial-time verifier model used to define (NP).
- Input length and polynomial resource bounds.
- Encoding conventions and their polynomial-overhead properties.
- Polynomial-time many-one reductions.
- The exact SAT language and encoding.

A verifier formulation should state a polynomially bounded witness relation, for example:

[
x\in L \iff \exists w,\ |w|\le p(|x|): R(x,w)=1,
]

where (R) is decidable in deterministic polynomial time and (p) is a polynomial fixed by the language.

The formalization must avoid silently changing machine models or encodings in ways that affect polynomial-time equivalence.

## 3. Proposed Lean pipeline

### `Challenge.lean`

- Define the machine and language models.
- Define polynomial-time decidability and polynomial-time verification.
- Define polynomial reductions and SAT.
- State (P\subseteq NP) and the target equivalence (P=NP\iff SAT\in P), with the exact reduction convention recorded.
- Do not assume the target conclusion in a definition or axiom.

### `Equivalence.lean`

Prove the correspondence between the chosen formal definitions and the intended standard complexity-theory definitions.

Expected intermediate results include:

- (P\subseteq NP).
- SAT belongs to NP.
- SAT is NP-hard under the declared reduction.
- SAT is NP-complete.
- (SAT\in P\Rightarrow P=NP).
- (P=NP\Rightarrow SAT\in P).

The equivalence theorem must depend on the formalized completeness result, not on an unproved assertion that SAT is complete.

### `Solution.lean`

The resolution target is exactly one of:

- A valid proof of (P=NP); or
- A valid proof of (P\ne NP).

A proof of a restricted circuit class, oracle-relative result, conditional statement, or special-case language is not a solution of the unrestricted problem. Such results may be valuable but must be labelled by their exact scope.

No `sorry`, `admit`, or hidden axiom may discharge the target.

### Evidence

Record Lean/Mathlib versions, theorem identifiers, axiom audit, source revision, build output, hashes, and independent reproduction. A successful build of the definitions and standard equivalences does not resolve P vs NP.

## 4. Known mathematical context

Standard established inclusions and completeness results are useful scaffolding, not a resolution:

- (P\subseteq NP).
- SAT is NP-complete under polynomial-time many-one reductions.
- Therefore (SAT\in P) would imply (P=NP).

Relativization, natural-proofs, and algebrization are known barrier frameworks relevant to many proof approaches. They are not proofs that (P\ne NP), nor do they show that all possible proof methods are impossible.

## 5. Validation and verification checklist

- [ ] Machine models and encodings fixed.
- [ ] Polynomial bounds explicit and correctly quantified.
- [ ] Verifier/witness definition equivalent to selected NP definition.
- [ ] Reduction notion fixed and proved to preserve required bounds.
- [ ] SAT encoding and membership proof checked.
- [ ] NP-hardness proof checked.
- [ ] (P=NP\iff SAT\in P) proved from preceding results.
- [ ] Target proof contains no `sorry` or `admit`.
- [ ] Axiom and dependency audit completed.
- [ ] Clean independent build reproduced.
- [ ] Independent mathematical review completed.

## 6. Current conclusion

**P vs NP remains OPEN.** This track currently specifies a proposed formalization and verification route. It contains no solution theorem and no machine-checked proof of either direction.
