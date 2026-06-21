#!/usr/bin/env python3
"""Print bounding boxes for binary STL and OpenSCAD OFF files."""

from __future__ import annotations

import argparse
import struct
from pathlib import Path
from typing import Iterable


def _bbox(points: Iterable[tuple[float, float, float]]) -> tuple[list[float], list[float]]:
    iterator = iter(points)
    try:
        first = next(iterator)
    except StopIteration as exc:
        raise ValueError("mesh has no vertices") from exc

    mins = [first[0], first[1], first[2]]
    maxs = [first[0], first[1], first[2]]
    for point in iterator:
        for axis in range(3):
            mins[axis] = min(mins[axis], point[axis])
            maxs[axis] = max(maxs[axis], point[axis])
    return mins, maxs


def read_binary_stl(path: Path) -> tuple[int, list[float], list[float]]:
    with path.open("rb") as stl:
        stl.seek(80)
        triangle_count = struct.unpack("<I", stl.read(4))[0]
        points: list[tuple[float, float, float]] = []
        for _ in range(triangle_count):
            record = stl.read(50)
            if len(record) != 50:
                raise ValueError(f"{path}: truncated STL triangle record")
            values = struct.unpack("<12fH", record)
            points.extend(
                [
                    (values[3], values[4], values[5]),
                    (values[6], values[7], values[8]),
                    (values[9], values[10], values[11]),
                ]
            )
    mins, maxs = _bbox(points)
    return triangle_count, mins, maxs


def read_off(path: Path) -> tuple[int, list[float], list[float]]:
    tokens = path.read_text(encoding="utf-8").split()
    if not tokens or tokens[0] != "OFF":
        raise ValueError(f"{path}: expected OFF header")

    vertex_count = int(tokens[1])
    index = 4
    points: list[tuple[float, float, float]] = []
    for _ in range(vertex_count):
        points.append(tuple(float(value) for value in tokens[index : index + 3]))
        index += 3

    mins, maxs = _bbox(points)
    return vertex_count, mins, maxs


def format_vector(values: list[float]) -> str:
    return "[" + ", ".join(f"{value:.3f}" for value in values) + "]"


def print_measurement(path: Path) -> None:
    suffix = path.suffix.lower()
    if suffix == ".stl":
        count, mins, maxs = read_binary_stl(path)
        count_label = "triangles"
    elif suffix == ".off":
        count, mins, maxs = read_off(path)
        count_label = "vertices"
    else:
        raise ValueError(f"{path}: unsupported file type; expected .stl or .off")

    size = [maxs[axis] - mins[axis] for axis in range(3)]
    print(path)
    print(f"  {count_label}: {count}")
    print(f"  min:  {format_vector(mins)}")
    print(f"  max:  {format_vector(maxs)}")
    print(f"  size: {format_vector(size)}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("paths", nargs="+", type=Path, help="STL/OFF files to measure")
    args = parser.parse_args()

    for path in args.paths:
        print_measurement(path)


if __name__ == "__main__":
    main()
