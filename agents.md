For OpenSCAD work, use BOSL2 when useful for rounded boxes, chamfers, screw holes, nut traps, threaded rods, threaded nuts, hinges, dovetails, anchors, and geometry transforms.

When given an STL, treat it as reference geometry. Inspect it with Python/trimesh, admesh, Meshlab, or Blender, then recreate the part as clean editable OpenSCAD primitives. Do not use STL-to-polyhedron conversion as the final model unless specifically requested.

Every OpenSCAD revision must be checked by rendering with OpenSCAD. When possible, create both an STL and a PNG preview before presenting the result.
