// Version: v1
// Source STL: obj_5_Action mount set 8.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [113.624008, -175.700012, 0.000000]
// Bounding box max: [163.624008, -130.700012, 19.000000]
// Bounding box size: [50.000000, 45.000000, 19.000000]
// Facets: 1036

source_stl = "obj_5_Action mount set 8.stl";
xy_center = [138.624008, -153.200012];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
