# Navier–Stokes Existence and Smoothness — Research Specification

**Track ID:** KAIROSEED-NS-001  
**Status:** SPECIFICATION TRACK ACTIVE; OpenAI published a proof claim for Clay alternatives (C) and (D) on 8 September 2026. On 11 September 2026, the Clay Mathematics Institute announced that the problem had apparently been settled and that its evaluation process would be deliberately unhurried. KAIROSEED has not independently audited the proof or reproduced its Lean build. No prize determination is claimed here.

## 1. Source problem and scope

The track concerns the three-dimensional incompressible Navier–Stokes equations with positive viscosity:

[
\partial_t u +(u\cdot\nabla)u = -\nabla p + \nu\Delta u,
\qquad \nabla\cdot u=0,
\qquad \nu>0.
]

The source problem must specify the spatial domain (for example (mathbb R^3) or the three-dimensional torus), initial-data class, boundary or decay conditions, solution concept, and precise regularity target. These choices are not interchangeable and must not be left implicit.

For a chosen formulation, the initial velocity (u_0) must satisfy the declared admissibility conditions, including divergence-free and any required smoothness, integrability, decay, or periodicity conditions.

This track does not claim authorship or independent verification of the externally published result. Its purpose is to formalize the source alternatives, inspect proof-to-source correspondence, reproduce the released formalization, audit assumptions and dependencies, and commission independent mathematical review.

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

## 7. External result and evaluation status (2026-11-21)

OpenAI published *Finite Time Blowup for Navier–Stokes* on 8 September 2026. The paper states a construction, for every positive viscosity, with smooth forcing and initially zero velocity, whose velocity becomes unbounded in finite time while kinetic energy remains uniformly bounded. It states that this establishes Fefferman's alternative (C) on the whole space and alternative (D) on the periodic domain. OpenAI also released a Lean formalization.

On 11 September 2026, the Clay Mathematics Institute announced that the problem had apparently been settled and said that its evaluation process would be deliberately unhurried. That announcement is not a prize award or a public independent verification report.

**KAIROSEED status:** external proof claim identified; primary-source materials identified; independent reproduction and mathematical review by this project NOT PERFORMED.

- **Published claim:** OpenAI reports a proof of alternatives (C) and (D).
- **Institutional status:** Clay announced apparent settlement and an evaluation process.
- **KAIROSEED verification status:** NOT VERIFIED by this project.
- **Prize status:** no award is claimed here.

The unforced global-regularity alternatives (A) and (B) are distinct from the forced-breakdown alternatives (C) and (D). The published claim for (C)/(D) must not be misreported as a proof of unforced blowup.

## 8. KAIROSEED verification work plan

1. Freeze the authoritative Fefferman statement and map every hypothesis and conclusion to formal predicates.
2. Retrieve the released Lean source and pin its exact commit, Lean toolchain, and Mathlib revision.
3. Reproduce the build in a clean environment without modifying the upstream proof.
4. Audit proof holes, axioms, theorem dependencies, imported assumptions, and any custom kernel or trust boundary.
5. Map the analytical paper's lemmas to the Lean theorem graph and verify that the formal theorem proves the stated alternative.
6. Independently check the admissibility of the initial data and forcing, the finite-time singularity conclusion, and the energy bound.
7. Record limitations, failed checks, reviewer independence, and all evidence in the Evidence Register.

No external proof is promoted to INDEPENDENTLY_VERIFIED merely because a Lean artifact is published or a model reports that its proof was checked.

## 9. Sources

- Charles L. Fefferman, [official Clay problem statement (PDF)](https://www.claymath.org/wp-content/uploads/2022/06/navierstokes.pdf).
- OpenAI, [On the Navier–Stokes Millennium Prize Problem (8 September 2026)](https://openai.com/index/navier-stokes-solution/).
- OpenAI, [Finite Time Blowup for Navier–Stokes (paper)](https://cdn.openai.com/pdf/32d9f210-8b73-45e0-91bc-82a30aef8a9a/navier-stokes.pdf).
- Clay Mathematics Institute, [Navier–Stokes Announcement (11 September 2026)](https://www.claymath.org/news/navier-stokes-announcement/).