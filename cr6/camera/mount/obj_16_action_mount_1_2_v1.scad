// Version: v1
// Source STL: obj_16_Action mount 1.2.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [434.780396, 189.307098, 0.000000]
// Bounding box max: [454.780396, 209.307098, 22.000000]
// Bounding box size: [20.000000, 20.000000, 22.000000]
// Facets: 2534

source_stl = "obj_16_Action mount 1.2.stl";
xy_center = [444.780396, 199.307098];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
