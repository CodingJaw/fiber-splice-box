// Small hinge, version 4.
//
// V4 keeps the exact V1 STL part shapes by importing the shipped meshes, then
// organizes editable Customizer parameters into per-part sections.
// Default values preserve the V1 STL dimensions and placement.

$fn = 96;

stl_dir = "./";

/* [View] */

// Select which v4 part or layout to render.
show_part = "assembly"; // [assembly: Assembly, exploded: Exploded, left_hinge: Left hinge, right_hinge: Right hinge, spacer: Spacer, cap: Cap]

exploded_spacing = 24;

/* [Hidden] */

// Source V1 STL bounding-box dimensions.  Do not change these unless the STL
// files are regenerated.
source_left_hinge_width = 35.0;
source_left_hinge_length = 48.863;
source_left_hinge_thickness = 13.863;

source_right_hinge_width = 35.0;
source_right_hinge_length = 48.863;
source_right_hinge_thickness = 13.863;

source_barrel_width = 12.6;
source_barrel_length = 38.1;
source_barrel_thickness = 12.6;

source_cap_width = 12.6;
source_cap_length = 2.5;
source_cap_thickness = 12.6;

/* [Left Hinge] */

left_hinge_width = source_left_hinge_width;
left_hinge_length = source_left_hinge_length;
left_hinge_thickness = source_left_hinge_thickness;

// Opens the assembled hinge gap by moving the left hinge half away from center.
left_hinge_gap_offset = 0;

/* [Right Hinge] */

right_hinge_width = source_right_hinge_width;
right_hinge_length = source_right_hinge_length;
right_hinge_thickness = source_right_hinge_thickness;

// Opens the assembled hinge gap by moving the right hinge half away from center.
right_hinge_gap_offset = 0;

/* [Hinge Gap] */

// Adds shared clearance between the left and right hinge halves.
hinge_gap = 0;

/* [Barrel Spacer] */

// In the V1 mesh, Hinge_small_Sp.stl is the long cylindrical spacer/pin part.
spacer_diameter = source_barrel_width;
barrel_length = source_barrel_length;
barrel_clearance = 0;
barrel_gap = 0;

/* [Pin Cap] */

// In the V1 mesh, Hinge_small_Cap.stl is the end cap.
pin_width = source_cap_width;
pin_length = source_cap_length;
pin_thickness = source_cap_thickness;
pin_clearance = 0;
pin_end_gap = 0;

module scaled_import(file, source_size, target_size, clearance = [0, 0, 0]) {
    scale([
        (target_size[0] + clearance[0]) / source_size[0],
        (target_size[1] + clearance[1]) / source_size[1],
        (target_size[2] + clearance[2]) / source_size[2]
    ])
        import(str(stl_dir, file), convexity = 10);
}

module hinge_small_v4_left_hinge() {
    translate([0, -(hinge_gap / 2 + left_hinge_gap_offset), 0])
        scaled_import(
            "Hinge_small_L.stl",
            [source_left_hinge_width, source_left_hinge_length, source_left_hinge_thickness],
            [left_hinge_width, left_hinge_length, left_hinge_thickness]
        );
}

module hinge_small_v4_right_hinge() {
    translate([0, hinge_gap / 2 + right_hinge_gap_offset, 0])
        scaled_import(
            "Hinge_small_R.stl",
            [source_right_hinge_width, source_right_hinge_length, source_right_hinge_thickness],
            [right_hinge_width, right_hinge_length, right_hinge_thickness]
        );
}

module hinge_small_v4_spacer() {
    translate([barrel_gap, 0, 0])
        scaled_import(
            "Hinge_small_Sp.stl",
            [source_barrel_length, source_barrel_width, source_barrel_thickness],
            [barrel_length, spacer_diameter, spacer_diameter],
            [0, barrel_clearance, barrel_clearance]
        );
}

module hinge_small_v4_cap() {
    translate([-pin_end_gap, 0, 0])
        scaled_import(
            "Hinge_small_Cap.stl",
            [source_cap_length, source_cap_width, source_cap_thickness],
            [pin_length, pin_width, pin_thickness],
            [0, pin_clearance, pin_clearance]
        );
}

module hinge_small_v4_assembly() {
    hinge_small_v4_left_hinge();
    hinge_small_v4_right_hinge();
    hinge_small_v4_spacer();
    hinge_small_v4_cap();
}

module hinge_small_v4_exploded() {
    translate([0, -exploded_spacing, 0])
        hinge_small_v4_left_hinge();

    translate([0, exploded_spacing, 0])
        hinge_small_v4_right_hinge();

    translate([exploded_spacing, 0, 0])
        hinge_small_v4_spacer();

    translate([-exploded_spacing, 0, 0])
        hinge_small_v4_cap();
}

if (show_part == "exploded") {
    hinge_small_v4_exploded();
} else if (show_part == "left_hinge") {
    hinge_small_v4_left_hinge();
} else if (show_part == "right_hinge") {
    hinge_small_v4_right_hinge();
} else if (show_part == "spacer") {
    hinge_small_v4_spacer();
} else if (show_part == "cap") {
    hinge_small_v4_cap();
} else {
    hinge_small_v4_assembly();
}
