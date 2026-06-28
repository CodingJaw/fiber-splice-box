// Version: v1
// Source STL: obj_13_Action mount 2.22.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [392.824799, 117.323708, 0.000000]
// Bounding box max: [416.824799, 141.323715, 10.000000]
// Bounding box size: [24.000000, 24.000008, 10.000000]
// Facets: 2226

source_stl = "obj_13_Action mount 2.22.stl";
xy_center = [404.824799, 129.323711];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
