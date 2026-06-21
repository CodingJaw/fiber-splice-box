#!/usr/bin/env python3
"""Check that hinge_small_v6 exposes the expected Customizer sections/parameters."""

from __future__ import annotations

from pathlib import Path

SCAD_FILE = Path("parts/hinge_small/hinge_small_v6.scad")
REQUIRED_TEXT = [
    "/* [View] */",
    "/* [Left Hinge] */",
    "/* [Right Hinge] */",
    "/* [Hinge Gap] */",
    "/* [Mounting Holes] */",
    "/* [Barrels] */",
    "/* [Spacer] */",
    "/* [Pin Cap] */",
    "show_part =",
    "spacer_shaft_diameter =",
    "spacer_head_diameter =",
    "spacer_head_thickness =",
    "spacer_screw_hole_diameter =",
    "spacer_screw_hole_depth =",
]


def main() -> None:
    text = SCAD_FILE.read_text(encoding="utf-8")
    missing = [required for required in REQUIRED_TEXT if required not in text]
    if missing:
        print(f"{SCAD_FILE}: missing expected Customizer text:")
        for item in missing:
            print(f"  - {item}")
        raise SystemExit(1)

    print(f"{SCAD_FILE}: Customizer sections and spacer controls are present")


if __name__ == "__main__":
    main()
