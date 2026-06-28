// Version: v1
// Source STL: ../obj_9_Action mount set 10.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [39.768509, -219.094513, 0.000000]
// Bounding box max: [107.436852, -188.573227, 30.000000]
// Bounding box size: [67.668343, 30.521286, 30.000000]
// Facets: 1776

source_stl = "../obj_9_Action mount set 10.stl";
xy_center = [73.602680, -203.833870];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
