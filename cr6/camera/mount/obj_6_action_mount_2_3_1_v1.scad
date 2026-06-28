// Version: v1
// Source STL: obj_6_Action mount 2.3 (1).stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [433.536438, 119.265518, 0.000000]
// Bounding box max: [457.536438, 143.265518, 10.000000]
// Bounding box size: [24.000000, 24.000000, 10.000000]
// Facets: 2058

source_stl = "obj_6_Action mount 2.3 (1).stl";
xy_center = [445.536438, 131.265518];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
