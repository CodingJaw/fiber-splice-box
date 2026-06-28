// Version: v1
// Source STL: ../obj_12_Action mount 2.4.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [473.235931, 119.851257, 0.000000]
// Bounding box max: [497.235931, 143.851257, 12.750000]
// Bounding box size: [24.000000, 24.000000, 12.750000]
// Facets: 2162

source_stl = "../obj_12_Action mount 2.4.stl";
xy_center = [485.235931, 131.851257];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
