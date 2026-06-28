// Version: v1
// Source STL: ../obj_8_Action mount 4.2.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [454.303528, 78.066719, 0.000000]
// Bounding box max: [478.303528, 102.066719, 10.000000]
// Bounding box size: [24.000000, 24.000000, 10.000000]
// Facets: 2226

source_stl = "../obj_8_Action mount 4.2.stl";
xy_center = [466.303528, 90.066719];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
