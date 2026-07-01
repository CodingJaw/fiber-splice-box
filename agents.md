# AGENTS.md — OpenSCAD Rules

Project uses OpenSCAD, BOSL2, Orca Slicer, FreeCAD, and a Creality CR-6 SE.

Create clean, parametric, editable OpenSCAD models for FDM printing. Do not create mesh-only models unless explicitly requested.

## File Versioning

Never overwrite an existing .scad file.

For every change, create the next versioned file:
part_v1.scad
part_v2.scad
part_v3.scad

If the source file has no version number, save the changed file as _v1.

Do not delete old versions unless explicitly requested.

## OpenSCAD Customizer

Use dropdowns for word choices.

Good:

/* [Display] */
Display_Item = "Both"; // [Both, Bolt Only, Nut Only, Fit Test]

/* [Placement] */
Mount_Side = "Left"; // [Left, Right]

Bad:

Display_Item = "type bolt or nut here";
Mount_Side = "left";

Number settings may use normal number boxes or sliders.

Group settings with Customizer headers:

/* [Display] */
/* [Main Dimensions] */
/* [Thread Settings] */
/* [Print Clearance] */
/* [Box Settings] */
/* [Tray Settings] */
/* [Hinge Settings] */
/* [Clamp Settings] */
/* [Advanced] */
/* [Hidden] */

Put common settings near the top. Put helper/internal values under [Hidden].

## BOSL2

Use BOSL2 when useful for:
rounded boxes
chamfers
screw holes
countersinks
counterbores
nut traps
threaded rods
threaded nuts
hinges
dovetails
anchors
transforms

Use BOSL2 thread modules instead of hand-made spiral threads whenever possible.

For printed threads, start loose and include clearance settings.

Good starting values for printed 1/4-20 parts:

Bolt_Tolerance = "1A";
Nut_Tolerance = "1B";
Bolt_Undersize = 0.20;
Nut_Slop = 0.30;

## Standard SCAD Layout

Use this layout for new files:

/*
File:
Version:
Previous Version:
Purpose:
Changes:
*/

include <BOSL2/std.scad>

/* [Display] */
Display_Item = "Assembly"; // [Assembly, Part A Only, Part B Only, Fit Test]

/* [Main Dimensions] */

/* [Print Clearance] */

/* [Advanced] */

/* [Hidden] */
$fn = 96;

module main() {
    // display selector
}

main();

## Render Checks

Every OpenSCAD revision must be checked before presenting it.

When possible, create:
.scad file
.stl export
.png preview image

Use OpenSCAD when available:

openscad -o preview.png --imgsize=1600,1200 model_v2.scad
openscad -o model_v2.stl model_v2.scad

Do not claim a true OpenSCAD render unless OpenSCAD actually produced it.

If OpenSCAD is unavailable, state that and create a simple preview diagram instead.

## STL Reference

When given an STL, inspect it as reference geometry.

Use tools such as:
Python/trimesh
admesh
MeshLab
Blender
FreeCAD

Recreate the part as editable OpenSCAD primitives.

Do not use STL-to-polyhedron conversion as the final model unless explicitly requested.

## FDM Print Rules

Design for PETG/FDM printing.

Use:
wall thickness around 2–3 mm when possible
minimum wall around 1.2 mm
clearance around 0.20–0.35 mm
moving clearance around 0.30–0.50 mm
chamfers on sharp bottom edges
no zero-thickness faces
no floating geometry
no non-manifold geometry

## Fiber Box Rules

For the fiber splice box project:
keep parts parametric
create preview image for every SCAD revision
use dropdowns for display/export modes
keep separate modes for assembly, box, lid, tray, hinge test, clamp, SC holder, and fit tests
do not remove working features unless explicitly requested
always create the next _vN.scad file

## Final Response

When finished, report:
new filename
changes made
render result
STL export result
preview image location
known limitations
