#!/usr/bin/env python3
"""Compare v6 OpenSCAD exports against original hinge_small STL dimensions."""

from __future__ import annotations

import argparse
import struct
from pathlib import Path

EXPECTED_PAIRS = {
    "Hinge_small_L.stl": "left_hinge.off",
    "Hinge_small_R.stl": "right_hinge.off",
    "Hinge_small_Sp.stl": "spacer.off",
    "Hinge_small_Cap.stl": "cap.off",
}


def bbox(points: list[tuple[float, float, float]]) -> tuple[list[float], list[float]]:
    mins = [min(point[axis] for point in points) for axis in range(3)]
    maxs = [max(point[axis] for point in points) for axis in range(3)]
    return mins, maxs


def stl_size(path: Path) -> list[float]:
    points: list[tuple[float, float, float]] = []
    with path.open("rb") as stl:
        stl.seek(80)
        triangle_count = struct.unpack("<I", stl.read(4))[0]
        for _ in range(triangle_count):
            values = struct.unpack("<12fH", stl.read(50))
            points.extend(
                [
                    (values[3], values[4], values[5]),
                    (values[6], values[7], values[8]),
                    (values[9], values[10], values[11]),
                ]
            )
    mins, maxs = bbox(points)
    return [maxs[axis] - mins[axis] for axis in range(3)]


def off_size(path: Path) -> list[float]:
    tokens = path.read_text(encoding="utf-8").split()
    if tokens[0] != "OFF":
        raise ValueError(f"{path}: expected OFF header")
    vertex_count = int(tokens[1])
    index = 4
    points: list[tuple[float, float, float]] = []
    for _ in range(vertex_count):
        points.append(tuple(float(value) for value in tokens[index : index + 3]))
        index += 3
    mins, maxs = bbox(points)
    return [maxs[axis] - mins[axis] for axis in range(3)]


def format_size(values: list[float]) -> str:
    return "[" + ", ".join(f"{value:.3f}" for value in values) + "]"


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("export_dir", type=Path, help="Directory created by render_hinge_small_v6.sh")
    parser.add_argument("--tolerance", type=float, default=0.25, help="Allowed per-axis size delta in mm")
    parser.add_argument("--source-dir", type=Path, default=Path("parts/hinge_small"))
    args = parser.parse_args()

    failed = False
    for stl_name, off_name in EXPECTED_PAIRS.items():
        original_size = stl_size(args.source_dir / stl_name)
        generated_size = off_size(args.export_dir / off_name)
        deltas = [abs(original_size[axis] - generated_size[axis]) for axis in range(3)]
        ok = all(delta <= args.tolerance for delta in deltas)
        failed = failed or not ok
        status = "PASS" if ok else "FAIL"
        print(f"{status} {stl_name} -> {off_name}")
        print(f"  STL size: {format_size(original_size)}")
        print(f"  v6 size:  {format_size(generated_size)}")
        print(f"  delta:    {format_size(deltas)}")

    if failed:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
