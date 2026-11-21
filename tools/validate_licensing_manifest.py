#!/usr/bin/env python3
"""Validate tracked paths against KAIROSEED's fail-closed licensing manifest.

The .yaml manifest is restricted to JSON-compatible YAML. This tool uses only
Python's standard library and does not grant licenses or determine ownership.
"""
from __future__ import annotations

import argparse
import fnmatch
import json
import re
import sys
from pathlib import PurePosixPath
from typing import Any


def safe_path(raw: str) -> str:
    if not raw or "\x00" in raw:
        raise ValueError("empty path or NUL byte")
    path = raw.replace("\\", "/")
    if path.startswith("/") or re.match(r"^[A-Za-z]:", path):
        raise ValueError("absolute paths are not permitted")
    parts = PurePosixPath(path).parts
    if any(part in ("", ".", "..") for part in parts):
        raise ValueError("non-canonical or traversal path")
    return str(PurePosixPath(path))


def load_manifest(path: str) -> dict[str, Any]:
    with open(path, "r", encoding="utf-8") as handle:
        data = json.load(handle)
    if not isinstance(data, dict):
        raise ValueError("manifest root must be an object")
    if data.get("schema") != "kairoseed-licensing-manifest":
        raise ValueError("unexpected manifest schema")
    if data.get("format_profile") != "json-compatible-yaml":
        raise ValueError("unsupported manifest format profile")
    rules = data.get("classification_rules")
    if not isinstance(rules, list) or not rules:
        raise ValueError("classification_rules must be a non-empty list")
    seen_ids: set[str] = set()
    for rule in rules:
        if not isinstance(rule, dict):
            raise ValueError("each rule must be an object")
        rule_id = rule.get("id")
        if not isinstance(rule_id, str) or not rule_id or rule_id in seen_ids:
            raise ValueError("rule IDs must be unique non-empty strings")
        seen_ids.add(rule_id)
        if not isinstance(rule.get("priority"), int):
            raise ValueError(f"{rule_id}: priority must be an integer")
        if not isinstance(rule.get("patterns"), list) or not rule["patterns"]:
            raise ValueError(f"{rule_id}: patterns must be a non-empty list")
        if rule.get("license_authorization") != "NOT_AUTHORIZED":
            raise ValueError(
                f"{rule_id}: this baseline validator expects all license "
                "authorizations to remain NOT_AUTHORIZED"
            )
    return data


def classify(path: str, rules: list[dict[str, Any]]) -> dict[str, Any]:
    matches = [
        rule
        for rule in rules
        if any(fnmatch.fnmatchcase(path, pattern) for pattern in rule["patterns"])
    ]
    if not matches:
        raise ValueError(f"unclassified tracked path: {path}")
    highest = max(rule["priority"] for rule in matches)
    winners = [rule for rule in matches if rule["priority"] == highest]
    signatures = {
        (
            rule.get("classification"),
            rule.get("candidate_spdx"),
            rule.get("action"),
        )
        for rule in winners
    }
    if len(signatures) != 1:
        raise ValueError(
            f"ambiguous equal-priority rules for {path}: "
            + ", ".join(rule["id"] for rule in winners)
        )
    # Identical top-priority matches are still suspicious: require one rule.
    if len(winners) != 1:
        raise ValueError(
            f"multiple equal-priority matches for {path}: "
            + ", ".join(rule["id"] for rule in winners)
        )
    return winners[0]


def read_inventory(args: argparse.Namespace) -> list[str]:
    if args.paths:
        raw_paths = args.paths
    elif args.from_stdin:
        raw_paths = sys.stdin.read().split("\x00")
        raw_paths = [item for item in raw_paths if item]
    else:
        raise ValueError("provide paths or --stdin (use git ls-files -z)")
    normalized = [safe_path(item) for item in raw_paths]
    if len(normalized) != len(set(normalized)):
        raise ValueError("duplicate paths in inventory")
    return sorted(normalized)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", default="licensing/LICENSING-MANIFEST.yaml")
    parser.add_argument("--stdin", dest="from_stdin", action="store_true",
                        help="read NUL-delimited paths, e.g. git ls-files -z")
    parser.add_argument("paths", nargs="*")
    parser.add_argument("--json", action="store_true", help="emit JSON summary")
    args = parser.parse_args()

    try:
        manifest = load_manifest(args.manifest)
        paths = read_inventory(args)
        results = []
        failures = []
        for path in paths:
            try:
                rule = classify(path, manifest["classification_rules"])
                results.append({
                    "path": path,
                    "rule": rule["id"],
                    "classification": rule["classification"],
                    "candidate_spdx": rule.get("candidate_spdx"),
                    "provenance_status": rule.get("provenance_status"),
                    "license_authorization": rule["license_authorization"],
                    "action": rule["action"],
                })
                if rule["action"] == "BLOCK_AUTOMATIC_ASSIGNMENT":
                    failures.append(f"{path}: third-party/review-blocked")
            except ValueError as exc:
                failures.append(str(exc))

        summary = {
            "schema": "kairoseed-licensing-validation-result",
            "manifest_version": manifest["schema_version"],
            "inventory_count": len(paths),
            "classified_count": len(results),
            "failures": failures,
            "license_grants_made": 0,
            "license_files_created": False,
            "results": results,
            "status": "PASS_CLASSIFICATION_ONLY" if not failures else "FAIL_CLOSED",
        }
        if args.json:
            print(json.dumps(summary, indent=2))
        else:
            print(f"Inventory: {len(paths)}; classified: {len(results)}")
            for failure in failures:
                print(f"BLOCK: {failure}")
            print(f"Result: {summary['status']}")
            print("License grants made: 0")
        return 0 if not failures else 1
    except (OSError, json.JSONDecodeError, ValueError) as exc:
        print(f"VALIDATION ERROR: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
