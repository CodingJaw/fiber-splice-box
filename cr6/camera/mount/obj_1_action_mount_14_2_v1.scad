// Version: v1
// Source STL: obj_1_Action mount 14.2.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [115.200218, 94.333191, 0.000000]
// Bounding box max: [141.200226, 120.333191, 12.000000]
// Bounding box size: [26.000008, 26.000000, 12.000000]
// Facets: 1908

source_stl = "obj_1_Action mount 14.2.stl";
xy_center = [128.200222, 107.333191];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
