// Version: v1
// Source STL: ../obj_2_Action mount_threaded_3blade.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [164.123993, -153.700012, 0.000000]
// Bounding box max: [187.123993, -130.700012, 23.000000]
// Bounding box size: [23.000000, 23.000000, 23.000000]
// Facets: 2748
// BOSL2 is included for future parametric threaded replacements of this imported threaded mesh.

include <BOSL2/std.scad>
include <BOSL2/threading.scad>

source_stl = "../obj_2_Action mount_threaded_3blade.stl";
xy_center = [175.623993, -142.200012];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
