# Abstract

Autonomous agents possess expanding technical capabilities to invoke tools and mutate state, yet capability is routinely conflated with legitimate permission. We present KAIROSEED, a verification-first governance architecture for bounded authorization of agentic systems built on the invariant that

\[
\text{Capability} \not\Rightarrow \text{Authority}.
\]

KAIROSEED enforces this boundary through three contributions: (1) GOVANA Core and a deterministic Constraint Language, compiling policies into pre-execution verification gates that block ambiguous or unauthorized proposals; (2) a Policy Enforcement Point (PEP) and JIREH, coupling mandatory pre-execution re-verification with bounded runtime execution; and (3) a Cryptographic Receipt and Ledger Layer producing refusal codes, hash-chained receipts, and replayable audit artifacts. We also disclose negative experimental findings—specifically R-08 and the MUTATED_UNLOGGED state-mutation bypass—that exposed gaps in earlier prototypes and shaped our fail-closed design. KAIROSEED is presented as a proposed architecture; independent verification, key custody, and G-04 gate closure remain open requirements.

## Keywords

agentic systems, authorization, AI governance, policy enforcement, runtime security, cryptographic receipts, auditability, fail-closed systems
