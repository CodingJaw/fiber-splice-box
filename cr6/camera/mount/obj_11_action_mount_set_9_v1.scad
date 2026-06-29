// Version: v1
// Source STL: obj_11_Action mount set 9.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [114.376930, -227.699997, -0.000000]
// Bounding box max: [180.376923, -211.699997, 15.000000]
// Bounding box size: [65.999992, 16.000000, 15.000000]
// Facets: 652

source_stl = "obj_11_Action mount set 9.stl";
xy_center = [147.376926, -219.699997];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
