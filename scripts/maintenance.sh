#!/usr/bin/env bash
set -euo pipefail

EXPORT_DIR="${1:-/tmp/hinge_small_v6_exports}"

python3 scripts/check_hinge_small_customizer.py
python3 scripts/measure_mesh_bounds.py parts/hinge_small/*.stl

if command -v openscad >/dev/null 2>&1; then
  scripts/render_hinge_small_v6.sh "$EXPORT_DIR"
  python3 scripts/compare_hinge_small_v6.py "$EXPORT_DIR"
else
  echo "OpenSCAD is not installed; skipping render and STL/SCAD comparison checks." >&2
fi
