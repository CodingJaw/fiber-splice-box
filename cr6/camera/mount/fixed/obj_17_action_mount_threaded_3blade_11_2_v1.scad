// Version: v1
// Source STL: ../obj_17_Action mount_threaded_3blade 11.2.stl
// Converted as an OpenSCAD import wrapper with the mesh centered on the X/Y origin.
// Bounding box min: [45.521721, 117.815903, 0.000000]
// Bounding box max: [68.521721, 140.815903, 23.000000]
// Bounding box size: [23.000000, 23.000000, 23.000000]
// Facets: 2748
// BOSL2 is included for future parametric threaded replacements of this imported threaded mesh.

include <BOSL2/std.scad>
include <BOSL2/threading.scad>

source_stl = "../obj_17_Action mount_threaded_3blade 11.2.stl";
xy_center = [57.021721, 129.315903];

module imported_part() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

imported_part();
