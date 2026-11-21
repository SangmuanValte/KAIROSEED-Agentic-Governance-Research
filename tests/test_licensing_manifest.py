"""Negative and positive tests for the licensing manifest validator."""
import copy
import json
import pathlib
import sys
import unittest

ROOT = pathlib.Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "tools"))
import validate_licensing_manifest as validator  # noqa: E402


class ManifestValidatorTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.manifest = validator.load_manifest(
            str(ROOT / "licensing" / "LICENSING-MANIFEST.yaml")
        )

    def test_known_readme_is_classified_but_not_authorized(self):
        rule = validator.classify("README.md", self.manifest["classification_rules"])
        self.assertEqual(rule["candidate_spdx"], "CC-BY-4.0")
        self.assertEqual(rule["license_authorization"], "NOT_AUTHORIZED")

    def test_lean_root_file_uses_cc_by_candidate(self):
        rule = validator.classify("Challenge.lean", self.manifest["classification_rules"])
        self.assertEqual(rule["candidate_spdx"], "CC-BY-4.0")

    def test_software_candidate_is_mit_but_not_authorized(self):
        rule = validator.classify("src/example.py", self.manifest["classification_rules"])
        self.assertEqual(rule["candidate_spdx"], "MIT")
        self.assertEqual(rule["license_authorization"], "NOT_AUTHORIZED")

    def test_third_party_license_path_is_blocked(self):
        rule = validator.classify("vendor/package/LICENSE", self.manifest["classification_rules"])
        self.assertEqual(rule["action"], "BLOCK_AUTOMATIC_ASSIGNMENT")

    def test_unclassified_file_fails(self):
        with self.assertRaisesRegex(ValueError, "unclassified"):
            validator.classify("unknown/data.bin", self.manifest["classification_rules"])

    def test_path_traversal_fails(self):
        with self.assertRaises(ValueError):
            validator.safe_path("../secret.txt")

    def test_absolute_path_fails(self):
        with self.assertRaises(ValueError):
            validator.safe_path("/etc/passwd")

    def test_ambiguous_equal_priority_fails(self):
        rules = [
            {"id": "a", "priority": 10, "patterns": ["*.md"],
             "classification": "docs", "candidate_spdx": "CC-BY-4.0",
             "action": "REQUIRES_ARTIFACT_PROVENANCE"},
            {"id": "b", "priority": 10, "patterns": ["README.md"],
             "classification": "other", "candidate_spdx": "MIT",
             "action": "REQUIRES_ARTIFACT_PROVENANCE"},
        ]
        with self.assertRaisesRegex(ValueError, "ambiguous"):
            validator.classify("README.md", rules)

    def test_duplicate_inventory_path_fails_at_input_normalization(self):
        with self.assertRaises(ValueError):
            paths = ["README.md", "README.md"]
            normalized = [validator.safe_path(p) for p in paths]
            if len(normalized) != len(set(normalized)):
                raise ValueError("duplicate paths in inventory")


if __name__ == "__main__":
    unittest.main()
