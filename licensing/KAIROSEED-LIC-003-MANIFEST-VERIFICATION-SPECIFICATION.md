# KAIROSEED-LIC-003 — Licensing Manifest Verification Specification

**Version:** 0.1  
**Status:** SPECIFIED; IMPLEMENTATION IN REVIEW  
**Related:** KAIROSEED-LIC-001 v1.1, KAIROSEED-LIC-002, KAIROSEED-PROV-001

## 1. Purpose

Define a deterministic, fail-closed mechanism for classifying tracked repository artifacts and checking whether licensing prerequisites are present. The validator is a policy-consistency tool, not a legal decision-maker.

## 2. State distinctions

The following states are independent and must never be collapsed:

`POLICY_ADOPTED ≠ PROVENANCE_REVIEWED ≠ OWNERSHIP_SUPPORTED ≠ LICENSE_AUTHORIZED ≠ LICENSE_IMPLEMENTED ≠ RELEASE_AUTHORIZED`

A successful manifest validation means only that the supplied inventory is classified consistently under the manifest. It does not mean a license is legally effective, ownership is proven, or release is authorized.

## 3. Required manifest properties

The manifest must:

- identify its schema and policy baseline;
- use repository-relative paths;
- use explicit path entries or reviewed pattern rules;
- declare the candidate classification and candidate SPDX license;
- state provenance and authorization status separately;
- use deterministic rule resolution;
- fail on unclassified tracked files;
- fail on ambiguous matches;
- fail on invalid or unsafe paths;
- never infer license approval from a directory name, extension, author field, or GitHub permission;
- preserve a review-required state for unknown, third-party, disputed, and unclassified material.

## 4. Precedence and resolution

Use this order:

1. Explicit artifact-level deny/review override.
2. Explicit artifact-level approved classification.
3. Specific path-pattern rule.
4. General path-pattern rule.
5. No match: fail closed.

A rule's numeric priority is explicit. The highest priority wins. If two matching rules share the highest priority and produce different classifications, validation fails as ambiguous. Do not silently choose the first item in a YAML list.

A deny/review override always blocks automatic license approval, regardless of candidate category.

## 5. Classification policy

The intended policy baseline is:

| Artifact | Candidate SPDX identifier |
|---|---|
| Original Lean formalization | CC-BY-4.0 |
| Original research manuscripts and documentation | CC-BY-4.0 |
| Original specifications and diagrams | CC-BY-4.0 |
| Original executable software | MIT |
| Third-party material | Original applicable license |
| Unknown, disputed, or mixed-provenance material | null; review required |

These are policy defaults only. Each artifact still requires provenance and authority review. Third-party license terms must not be overwritten by repository defaults.

## 6. Manifest format

The repository manifest uses a deliberately restricted JSON-compatible YAML subset. This permits parsing with Python's standard-library JSON parser and avoids an implicit third-party parser dependency. YAML features such as anchors, tags, aliases, implicit dates, and custom scalar types are not permitted. If a future change adopts general YAML, the parser and test suite must be changed explicitly.

## 7. Validator input and output

Input is the complete tracked-file inventory from the target Git revision, normally:

`git ls-files -z`

The validator must:
- read NUL-delimited paths;
- normalize separators to POSIX form;
- reject absolute paths, empty paths, and `..` traversal;
- classify each path deterministically;
- report every missing, ambiguous, or blocked path;
- exit nonzero when the inventory is incomplete or invalid;
- emit a machine-readable summary where requested.

The validator must not fetch network content, inspect personal accounts, or modify repository files.

## 8. Required negative tests

At minimum, test:

- unclassified new file;
- path traversal;
- absolute path;
- ambiguous equal-priority rules;
- third-party override over documentation fallback;
- vendored Lean file blocked from Lean default;
- unknown binary/data file;
- mixed-provenance artifact;
- ownership unknown;
- ownership evidence without license authority;
- license authorization absent;
- missing tracked-file inventory;
- malformed manifest;
- duplicate artifact path;
- stale digest.

## 9. Acceptance criteria

The implementation is acceptable only when:

1. all tests pass locally in a clean environment;
2. every tracked file is either classified or explicitly review-blocked;
3. all conflicts and unsafe paths fail closed;
4. no license file is created or license grant asserted by the validator;
5. the manifest reports proposed candidate licenses separately from approval;
6. the exact commit, tool version, command, and test output are retained;
7. independent review remains a separate state.

## 10. Security and legal limitations

A manifest can contain inaccurate declarations. A passing validator cannot establish that a provenance statement is true, that a person owns copyright, that a license is compatible, or that a license grant is enforceable. Human review and legally sufficient authority evidence remain mandatory.

**Disposition:** deterministic classification and fail-closed validation specified; legal ownership and licensing decisions remain outside automated validation.
