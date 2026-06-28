// Version: v1
// Source STL: obj_3_Action mount 12.3.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [114.944557, 142.293854, -0.000000]
// Bounding box max: [140.944565, 168.293854, 10.997000]
// Bounding box size: [26.000008, 26.000000, 10.997000]
// Facets: 1908

source_stl = "obj_3_Action mount 12.3.stl";
xy_center = [127.944561, 155.293854];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
