# KAIROSEED-PROV-001 — Artifact Ownership and Provenance Specification

**Version:** 0.1  
**Status:** SPECIFIED REQUIREMENTS; NO OWNERSHIP DETERMINATIONS MADE  
**Related:** KAIROSEED-LIC-001, KAIROSEED-LIC-002, KAIROSEED-LIC-003

## 1. Purpose

Define the minimum evidence required before assigning or applying a license to an artifact in the KAIROSEED repository. This specification records provenance; it does not determine legal ownership or replace legal advice.

## 2. Core rules

1. A file path, repository owner field, commit author, or push permission does not independently establish copyright ownership.
2. Every artifact must have a provenance status.
3. Unknown or disputed origin is a blocking condition for license assignment.
4. Third-party material retains its original license and required notices unless a documented, valid permission says otherwise.
5. AI-assisted or generated content must be recorded with its human contribution and source context; do not presume that generation establishes exclusive ownership.
6. A license candidate is not an effective license grant.
7. Retroactive licensing requires explicit authority and a documented scope decision.
8. Changes to an artifact invalidate stale provenance review when the change materially affects authorship, source, or embedded material.

## 3. Required provenance record

Each record must contain:

| Field | Requirement |
|---|---|
| `artifact_id` | Stable unique identifier |
| `path` | Repository-relative path; no absolute paths or traversal |
| `sha256` | SHA-256 of the exact reviewed bytes |
| `source_commit` | Commit containing the reviewed artifact |
| `artifact_type` | Documentation, manuscript, Lean, software, data, image, generated, third-party, or other |
| `creator_or_contributor` | Known contributor(s), or UNKNOWN |
| `origin` | Original, adapted, copied, generated, imported, or unknown |
| `source_references` | Source URLs/identifiers and retrieval details where applicable |
| `third_party_components` | Embedded or adapted external material, or explicit none-known finding |
| `ownership_basis` | Evidence supporting ownership or licensing authority; never infer |
| `candidate_license` | Proposed SPDX identifier or null |
| `license_authority` | Person/entity and documented authority, or UNKNOWN |
| `reviewer` | Reviewer and review date |
| `status` | One of the controlled states below |
| `limitations` | Missing facts, scope limits, and unresolved questions |

## 4. Controlled statuses

- `UNREVIEWED`: no provenance review completed.
- `IN_PROGRESS`: evidence collection is underway.
- `ORIGINALITY_SUPPORTED`: evidence supports original creation, but ownership/authority may still be unresolved.
- `OWNERSHIP_SUPPORTED`: documented evidence supports ownership for the stated scope.
- `THIRD_PARTY_REVIEW_REQUIRED`: external content or license obligations need review.
- `DISPUTED`: conflicting ownership or provenance information exists.
- `UNKNOWN`: origin or ownership cannot be established.
- `APPROVED_FOR_LICENSE_ASSIGNMENT`: authorized reviewer recorded sufficient evidence and authority for the exact artifact and proposed license.
- `REJECTED`: proposed assignment is not supported.

Only `APPROVED_FOR_LICENSE_ASSIGNMENT` permits the artifact to pass the provenance gate. That status must identify the authority and evidence; it must never be inferred from a test pass.

## 5. Evidence quality

Acceptable evidence may include signed contributor declarations, employment or contractor agreements that expressly cover the relevant rights, documented assignments, original source history, permissions from rightsholders, and verified upstream license notices. The adequacy of evidence depends on jurisdiction and facts; automated tooling cannot decide it.

A Git commit can help establish when a contribution entered a repository and which account authored it. It does not alone establish legal title or authority to license.

## 6. Hashing and canonicalization

For text artifacts, hash the exact repository blob bytes (UTF-8 bytes as stored), not a rendered or normalized copy. Record the algorithm as SHA-256. Do not normalize line endings or Unicode before hashing unless a separate canonicalization profile is explicitly versioned. For Git objects, record both the Git blob/object identifier and SHA-256 when available; they are different identifiers.

## 7. Third-party material

Record each third-party component separately with:

- upstream name and exact version/commit;
- source URL or archive identifier;
- license identifier and source of that identification;
- copyright and attribution notices;
- modifications made;
- distribution or compatibility conditions;
- review decision and reviewer.

When the license is unknown, conflicting, or not redistributable under the proposed terms, block redistribution and request review.

## 8. Change and retention

Preserve prior records when artifacts change. Create a new provenance revision tied to the new digest. Do not overwrite a failed or disputed review. Retain evidence according to applicable law, agreements, privacy requirements, and repository retention policy.

## 9. Explicit non-goals

This specification does not:
- determine copyright law;
- certify ownership;
- create contributor agreements;
- authorize retroactive licensing;
- grant a license;
- establish that AI-generated content is copyrightable;
- replace review of third-party terms.

**Acceptance condition:** every artifact proposed for licensing has a path-specific, digest-bound provenance record, and every record passing the gate includes evidence of authority for the exact licensing action.
