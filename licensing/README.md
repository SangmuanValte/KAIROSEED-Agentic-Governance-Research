# Licensing Governance

This directory contains the repository's licensing policy implementation records. It does not itself grant a license.

## Documents

- [KAIROSEED-LIC-002 — Repository Licensing Audit](KAIROSEED-LIC-002-REPOSITORY-AUDIT.md)
- [KAIROSEED-LIC-003 — Manifest Verification Specification](KAIROSEED-LIC-003-MANIFEST-VERIFICATION-SPECIFICATION.md)
- [KAIROSEED-PROV-001 — Artifact Ownership and Provenance](KAIROSEED-PROV-001-PROVENANCE-SPECIFICATION.md)
- [Machine-readable licensing manifest](LICENSING-MANIFEST.yaml)

## Current decision boundary

The manifest records candidate classifications only. All entries remain `UNREVIEWED` and `NOT_AUTHORIZED`. No repository-wide or retroactive license grant is made by these documents.

Do not add a root `LICENSE` file, per-file SPDX grant headers, or a repository license declaration until ownership/provenance and licensing authority have been reviewed and the exact scope has been approved.

## Validation

Run from the repository root:

```bash
python -m unittest discover -s tests -p 'test_licensing_manifest.py' -v
git ls-files -z | python tools/validate_licensing_manifest.py --stdin
```

The validator uses only the Python standard library. The manifest is restricted to JSON-compatible YAML; do not add YAML-only syntax such as anchors, aliases, tags, or implicit date values.

A successful validator run means only that the supplied tracked-file inventory is classified unambiguously. It does not establish ownership, legal compatibility, or license authorization.
