# Navier–Stokes Existence and Smoothness — Research Specification

**Track ID:** KAIROSEED-NS-001  
**Status:** PROPOSED; the unrestricted three-dimensional global regularity problem remains OPEN.

## 1. Source problem and scope

The track concerns the three-dimensional incompressible Navier–Stokes equations with positive viscosity:

[
\partial_t u +(u\cdot\nabla)u = -\nabla p + \nu\Delta u,
\qquad \nabla\cdot u=0,
\qquad \nu>0.
]

The source problem must specify the spatial domain (for example (mathbb R^3) or the three-dimensional torus), initial-data class, boundary or decay conditions, solution concept, and precise regularity target. These choices are not interchangeable and must not be left implicit.

For a chosen formulation, the initial velocity (u_0) must satisfy the declared admissibility conditions, including divergence-free and any required smoothness, integrability, decay, or periodicity conditions.

This document does not claim global existence and smoothness, nor finite-time breakdown.

## 2. Distinct mathematical questions

Keep the following claims separate:

1. **Local existence:** existence on a nonzero time interval for data in a stated class.
2. **Uniqueness:** uniqueness within a stated solution class.
3. **Regularity persistence:** preservation of specified regularity while the solution exists.
4. **Conditional continuation:** a criterion under which a solution can be extended beyond a finite time.
5. **Global existence and regularity:** existence for all time with the exact regularity required by the source problem.
6. **Finite-time breakdown:** construction of admissible data and a solution that loses the required regularity in finite time, under the exact target formulation.

A conditional continuation theorem is not global regularity unless its condition is proved for every admissible initial datum. A weak-solution existence theorem is not automatically a smooth-solution theorem.

## 3. Proposed Lean pipeline

### `Challenge.lean`

Encode the exact source problem without assuming its answer:

- Domain: explicitly choose (mathbb R^3) or periodic domain.
- Viscosity: (
u>0).
- Initial data: declared function space and admissibility conditions.
- Pressure and velocity: explicit function spaces and time dependence.
- PDE: encode momentum equation and incompressibility.
- Initial condition and boundary/decay conditions.
- Solution concept and target regularity.
- Global time quantifier and target conclusion.

Do not hide global regularity inside an undefined predicate or an axiom.

### `Equivalence.lean`

Prove the semantic correspondence between the source formulation and the formal objects. Obligations include:

- Initial-data admissibility correspondence.
- PDE and incompressibility correspondence.
- Initial-condition correspondence.
- Pressure and velocity representation.
- Solution-concept correspondence.
- Regularity predicate correspondence.
- Global-in-time quantifier correspondence.
- Domain and boundary/decay-condition correspondence.

This stage establishes that the formal statement is the intended problem; it does not prove the problem's truth.

### `Solution.lean`

Develop either:

- A proof of global existence and the required regularity for every admissible datum in the selected source formulation; or
- A valid finite-time breakdown construction satisfying the exact source hypotheses and conclusion.

The target must not be weakened silently. Conditional estimates, nonlinear evolution-operator lemmas, local existence results, or continuation criteria are intermediate results unless they discharge the full global quantifier.

## 4. Mathematical subclaims and operator discipline

A study of nonlinear evolution operators may be useful, but every operator must have a declared domain, codomain, topology, and hypotheses. A regularity-preservation claim must identify:

- The function spaces and norms.
- The operator or solution map.
- The interval of existence.
- The assumptions on data and forcing.
- The exact regularity being preserved.
- Whether the result is local, conditional, or global.

For conditional continuation, state the criterion as an implication with all hypotheses explicit. Do not infer global regularity merely from a criterion whose antecedent has not been established for all admissible solutions.

## 5. Verification protocol

- Pin the Lean toolchain and Mathlib revision.
- Build the challenge, equivalence, and solution files.
- Do not let `Solution.lean` import the challenge in a way that assumes the desired result.
- Prohibit `sorry` and `admit` in proof-bearing targets.
- Audit dependencies with `#print axioms`; disclose every axiom.
- Preserve build logs, source revision, theorem names, hashes, and exact commands.
- Reproduce the build in a clean independent environment.
- Obtain independent mathematical review of the source correspondence, hypotheses, proof dependencies, and interpretation.

A kernel-accepted proof of a conditional lemma verifies that lemma under its assumptions. It does not verify the unrestricted Millennium problem.

## 6. Validation checklist

- [ ] Domain fixed: (mathbb R^3) or periodic.
- [ ] Viscosity and initial-data hypotheses explicit.
- [ ] Function spaces and norms defined.
- [ ] Pressure and velocity regularity specified.
- [ ] PDE, divergence-free condition, and initial condition formalized.
- [ ] Boundary or decay conditions formalized.
- [ ] Solution concept identified.
- [ ] Regularity target and time quantifiers explicit.
- [ ] Formal/source correspondence proved.
- [ ] Conditional results clearly separated from the unrestricted target.
- [ ] Target theorem contains no `sorry`, `admit`, or hidden target axiom.
- [ ] Axiom audit, reproducible build, and independent review completed.

## 7. Current conclusion

The unrestricted three-dimensional Navier–Stokes existence and smoothness problem remains OPEN. This track is a specification and verification plan. No full global-regularity theorem or finite-time breakdown result is claimed.
