import Mathlib

/-!
# KAIROSEED-NS-001 — Challenge: source alternatives

Status: SPECIFICATION SCAFFOLD; NOT YET A COMPLETE PDE FORMALIZATION.

This file captures the quantifier structure of the four alternatives (A)–(D)
in Charles Fefferman's Clay problem statement.

The PDE semantics are deliberately isolated in `NavierStokesSemantics`.
That interface must later be instantiated with explicit function spaces,
differential operators, regularity, decay/periodicity, initial conditions,
and energy conditions. Until that work is done, the four propositions below
are abstract source-shaped specifications, not verified Navier–Stokes theorems.

No proof of any alternative is asserted here.
-/

namespace KAIROSEED.NavierStokes

/-- The two spatial settings in Fefferman's alternatives. -/
inductive SpatialDomain
  | wholeSpaceR3
  | periodicTorus
  deriving DecidableEq, Repr

/--
Semantic interface for the source problem.

Interpretation obligations:
* `admissibleInitial` must encode smoothness, divergence-freeness, and
  the exact decay or periodicity/energy hypotheses for the selected domain.
* `admissibleForce` must encode the exact smoothness and decay conditions
  on the external force.
* `globalUnforcedSolution` must mean existence of velocity and pressure
  on the full time half-line satisfying the PDE, incompressibility, initial
  data, domain conditions, required smoothness, and the source energy bound.
* `globalForcedSolution` must mean the corresponding forced problem,
  including the exact solution and energy conditions in alternatives (C)/(D).

These fields are semantic obligations, not axioms asserting that a solution
exists. Their concrete definitions and source-correspondence proofs remain
open work.
-/
structure NavierStokesSemantics where
  InitialVelocity : SpatialDomain → Type
  SmoothForce : SpatialDomain → Type
  admissibleInitial :
    (d : SpatialDomain) → InitialVelocity d → Prop
  admissibleForce :
    (d : SpatialDomain) → SmoothForce d → Prop
  globalUnforcedSolution :
    (d : SpatialDomain) → (ν : ℝ) → InitialVelocity d → Prop
  globalForcedSolution :
    (d : SpatialDomain) → (ν : ℝ) →
      InitialVelocity d → SmoothForce d → Prop

/-- Fefferman alternative (A): unforced global existence and smoothness on R³. -/
def AlternativeA (S : NavierStokesSemantics) : Prop :=
  ∀ ν : ℝ, 0 < ν →
    ∀ u₀ : S.InitialVelocity .wholeSpaceR3,
      S.admissibleInitial .wholeSpaceR3 u₀ →
        S.globalUnforcedSolution .wholeSpaceR3 ν u₀

/-- Fefferman alternative (B): unforced periodic global existence and smoothness. -/
def AlternativeB (S : NavierStokesSemantics) : Prop :=
  ∀ ν : ℝ, 0 < ν →
    ∀ u₀ : S.InitialVelocity .periodicTorus,
      S.admissibleInitial .periodicTorus u₀ →
        S.globalUnforcedSolution .periodicTorus ν u₀

/-- Fefferman alternative (C): admissible forced breakdown on R³. -/
def AlternativeC (S : NavierStokesSemantics) : Prop :=
  ∀ ν : ℝ, 0 < ν →
    ∃ u₀ : S.InitialVelocity .wholeSpaceR3,
      ∃ f : S.SmoothForce .wholeSpaceR3,
        S.admissibleInitial .wholeSpaceR3 u₀ ∧
        S.admissibleForce .wholeSpaceR3 f ∧
        ¬ S.globalForcedSolution .wholeSpaceR3 ν u₀ f

/-- Fefferman alternative (D): admissible forced breakdown on the periodic torus. -/
def AlternativeD (S : NavierStokesSemantics) : Prop :=
  ∀ ν : ℝ, 0 < ν →
    ∃ u₀ : S.InitialVelocity .periodicTorus,
      ∃ f : S.SmoothForce .periodicTorus,
        S.admissibleInitial .periodicTorus u₀ ∧
        S.admissibleForce .periodicTorus f ∧
        ¬ S.globalForcedSolution .periodicTorus ν u₀ f

/--
The source statement accepts any one of alternatives (A)–(D).
This disjunction records the accepted target shape; it does not prove it.
-/
def ClayAcceptedAlternative (S : NavierStokesSemantics) : Prop :=
  AlternativeA S ∨ AlternativeB S ∨ AlternativeC S ∨ AlternativeD S

end KAIROSEED.NavierStokes
