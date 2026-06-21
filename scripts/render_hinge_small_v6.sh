#!/usr/bin/env bash
set -euo pipefail

SCAD_FILE="parts/hinge_small/hinge_small_v6.scad"
OUT_DIR="${1:-/tmp/hinge_small_v6_exports}"

mkdir -p "$OUT_DIR"

openscad -o "$OUT_DIR/assembly.off" "$SCAD_FILE"
openscad -D 'show_part="exploded"' -o "$OUT_DIR/exploded.off" "$SCAD_FILE"
openscad -D 'show_part="left_hinge"' -o "$OUT_DIR/left_hinge.off" "$SCAD_FILE"
openscad -D 'show_part="right_hinge"' -o "$OUT_DIR/right_hinge.off" "$SCAD_FILE"
openscad -D 'show_part="spacer"' -o "$OUT_DIR/spacer.off" "$SCAD_FILE"
openscad -D 'show_part="cap"' -o "$OUT_DIR/cap.off" "$SCAD_FILE"

wc -c "$OUT_DIR"/*.off
