// Version: v1
// Source STL: obj_15_Action mount 1.2.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [93.124031, -175.696930, 0.000000]
// Bounding box max: [113.124031, -155.696930, 22.000000]
// Bounding box size: [20.000000, 20.000000, 22.000000]
// Facets: 2534

source_stl = "obj_15_Action mount 1.2.stl";
xy_center = [103.124031, -165.696930];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
