// Version: v1
// Source STL: obj_10_Action mount 4.2 (1).stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [407.786896, 77.338387, 0.000000]
// Bounding box max: [431.786896, 101.338387, 10.000000]
// Bounding box size: [24.000000, 24.000000, 10.000000]
// Facets: 2226

source_stl = "obj_10_Action mount 4.2 (1).stl";
xy_center = [419.786896, 89.338387];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
