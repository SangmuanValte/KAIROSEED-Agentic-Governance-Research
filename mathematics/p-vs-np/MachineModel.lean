import Mathlib

/-!
# KAIROSEED-PNP-001 — Machine Model

Status: PROPOSED SPECIFICATION.

This file introduces an explicit deterministic, single-tape Turing-machine
model over a three-symbol tape alphabet: blank, input-zero, and input-one.
Its purpose is to define the object whose transitions are counted as
computation steps before defining polynomial time, P, or NP.

Scope limitations:
* This is a chosen formal machine model, not yet proved equivalent to every
  standard Turing-machine convention.
* The tape is two-way infinite and represented as a total function on Int.
* The transition function is total, but halted configurations have no
  successor under next.
* No complexity-class definitions or polynomial bounds are introduced here.
* This specification has not yet been compiled or independently reviewed.
-/

namespace KAIROSEED.PNP.MachineModel

inductive Symbol
  | blank
  | zero
  | one
  deriving DecidableEq, Repr

inductive Move
  | left
  | right
  | stay
  deriving DecidableEq, Repr

abbrev State := Nat
abbrev Tape := Int → Symbol

/-- Complete instantaneous description of a machine. -/
structure Configuration where
  state : State
  tape : Tape
  head : Int

/-- A deterministic machine with designated halting states. -/
structure Machine where
  startState : State
  acceptState : State
  rejectState : State
  haltingStatesDistinct :
    startState ≠ acceptState ∧
    startState ≠ rejectState ∧
    acceptState ≠ rejectState
  transition : State → Symbol → State × Symbol × Move

def IsHalted (M : Machine) (c : Configuration) : Prop :=
  c.state = M.acceptState ∨ c.state = M.rejectState

/-- Encode a finite binary input from tape position zero; all other cells are blank. -/
def encodeInput (input : List Bool) : Tape :=
  fun position =>
    if 0 ≤ position then
      match input[position.toNat]? with
      | none => Symbol.blank
      | some false => Symbol.zero
      | some true => Symbol.one
    else
      Symbol.blank

def initialConfiguration (M : Machine) (input : List Bool) : Configuration :=
  { state := M.startState
    tape := encodeInput input
    head := 0 }

def moveHead (position : Int) (direction : Move) : Int :=
  match direction with
  | Move.left => position - 1
  | Move.right => position + 1
  | Move.stay => position

/--
One step reads the current cell, applies the transition function, writes one
symbol, changes state, and moves the head. Halted configurations have no
successor.
-/
def next (M : Machine) (c : Configuration) : Option Configuration :=
  if IsHalted M c then
    none
  else
    let (newState, written, direction) := M.transition c.state (c.tape c.head)
    some
      { state := newState
        tape := Function.update c.tape c.head written
        head := moveHead c.head direction }

abbrev ComputationTrace := List Configuration

/-- Every adjacent pair in a valid trace must follow the machine's step function. -/
def ValidTrace (M : Machine) : ComputationTrace → Prop
  | [] => True
  | [_] => True
  | first :: second :: rest =>
      next M first = some second ∧ ValidTrace M (second :: rest)

/-- Number of transitions represented by a nonempty finite trace. -/
def stepCount (trace : ComputationTrace) : Nat :=
  trace.length - 1

def StartsOnInput (M : Machine) (input : List Bool)
    (trace : ComputationTrace) : Prop :=
  trace.head? = some (initialConfiguration M input)

def AcceptsTrace (M : Machine) (trace : ComputationTrace) : Prop :=
  ∃ finalConfiguration, trace.getLast? = some finalConfiguration ∧
    finalConfiguration.state = M.acceptState

def RejectsTrace (M : Machine) (trace : ComputationTrace) : Prop :=
  ∃ finalConfiguration, trace.getLast? = some finalConfiguration ∧
    finalConfiguration.state = M.rejectState

/-- Existence of a finite, valid accepting computation on the input. -/
def Accepts (M : Machine) (input : List Bool) : Prop :=
  ∃ trace : ComputationTrace,
    trace ≠ [] ∧ StartsOnInput M input trace ∧
    ValidTrace M trace ∧ AcceptsTrace M trace

/-- Existence of a finite, valid rejecting computation on the input. -/
def Rejects (M : Machine) (input : List Bool) : Prop :=
  ∃ trace : ComputationTrace,
    trace ≠ [] ∧ StartsOnInput M input trace ∧
    ValidTrace M trace ∧ RejectsTrace M trace

def HaltsOn (M : Machine) (input : List Bool) : Prop :=
  Accepts M input ∨ Rejects M input

def inputLength (input : List Bool) : Nat :=
  input.length

end KAIROSEED.PNP.MachineModel
