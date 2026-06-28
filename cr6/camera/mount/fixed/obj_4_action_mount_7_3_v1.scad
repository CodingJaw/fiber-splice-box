// Version: v1
// Source STL: ../obj_4_Action mount 7.3.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [172.124008, -169.200012, -0.000000]
// Bounding box max: [187.124008, -154.200012, 34.998001]
// Bounding box size: [15.000000, 15.000000, 34.998001]
// Facets: 872

source_stl = "../obj_4_Action mount 7.3.stl";
xy_center = [179.624008, -161.700012];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
