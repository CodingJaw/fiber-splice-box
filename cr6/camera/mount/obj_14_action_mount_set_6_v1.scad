// Version: v1
// Source STL: obj_14_Action mount set 6.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [78.759140, -253.139328, 0.000000]
// Bounding box max: [110.759140, -238.139328, 16.000000]
// Bounding box size: [32.000000, 15.000000, 16.000000]
// Facets: 1620

source_stl = "obj_14_Action mount set 6.stl";
xy_center = [94.759140, -245.639328];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
