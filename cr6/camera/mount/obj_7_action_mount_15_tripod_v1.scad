// Version: v1
// Source STL: obj_7_Action mount 15 tripod.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [137.079559, -211.199997, 0.000000]
// Bounding box max: [172.079559, -176.199997, 23.000000]
// Bounding box size: [35.000000, 35.000000, 23.000000]
// Facets: 1152

source_stl = "obj_7_Action mount 15 tripod.stl";
xy_center = [154.579559, -193.699997];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
