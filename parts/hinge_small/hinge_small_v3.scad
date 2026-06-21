// Small hinge, version 3.
//
// V3 keeps the exact V1 STL part shapes by importing the shipped meshes, then
// adds parameters for part selection, sizing, fit clearance, and assembly gaps.
// Default values preserve the V1 STL dimensions and placement.

$fn = 96;

stl_dir = "./";

/* [View] */

// Select which v3 part or layout to render.
show_part = "assembly"; // [assembly: Assembly, exploded: Exploded, left_hinge: Left hinge, right_hinge: Right hinge, spacer: Spacer, cap: Cap]

exploded_spacing = 24;

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

// Left hinge parameters.
left_hinge_width = source_left_hinge_width;
left_hinge_length = source_left_hinge_length;
left_hinge_thickness = source_left_hinge_thickness;

// Right hinge parameters.
right_hinge_width = source_right_hinge_width;
right_hinge_length = source_right_hinge_length;
right_hinge_thickness = source_right_hinge_thickness;

// Barrel/spacer parameters.  In the V1 mesh, Hinge_small_Sp.stl is the long
// cylindrical spacer/pin part and Hinge_small_Cap.stl is the end cap.
barrel_width = source_barrel_width;
barrel_length = source_barrel_length;
barrel_thickness = source_barrel_thickness;
barrel_clearance = 0;
barrel_gap = 0;

// Hinge pin/cap parameters.
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

module hinge_small_v3_left_hinge() {
    scaled_import(
        "Hinge_small_L.stl",
        [source_left_hinge_width, source_left_hinge_length, source_left_hinge_thickness],
        [left_hinge_width, left_hinge_length, left_hinge_thickness]
    );
}

module hinge_small_v3_right_hinge() {
    scaled_import(
        "Hinge_small_R.stl",
        [source_right_hinge_width, source_right_hinge_length, source_right_hinge_thickness],
        [right_hinge_width, right_hinge_length, right_hinge_thickness]
    );
}

module hinge_small_v3_spacer() {
    translate([barrel_gap, 0, 0])
        scaled_import(
            "Hinge_small_Sp.stl",
            [source_barrel_length, source_barrel_width, source_barrel_thickness],
            [barrel_length, barrel_width, barrel_thickness],
            [0, barrel_clearance, barrel_clearance]
        );
}

module hinge_small_v3_cap() {
    translate([-pin_end_gap, 0, 0])
        scaled_import(
            "Hinge_small_Cap.stl",
            [source_cap_length, source_cap_width, source_cap_thickness],
            [pin_length, pin_width, pin_thickness],
            [0, pin_clearance, pin_clearance]
        );
}

module hinge_small_v3_assembly() {
    hinge_small_v3_left_hinge();
    hinge_small_v3_right_hinge();
    hinge_small_v3_spacer();
    hinge_small_v3_cap();
}

module hinge_small_v3_exploded() {
    translate([0, -exploded_spacing, 0])
        hinge_small_v3_left_hinge();

    translate([0, exploded_spacing, 0])
        hinge_small_v3_right_hinge();

    translate([exploded_spacing, 0, 0])
        hinge_small_v3_spacer();

    translate([-exploded_spacing, 0, 0])
        hinge_small_v3_cap();
}

if (show_part == "exploded") {
    hinge_small_v3_exploded();
} else if (show_part == "left_hinge") {
    hinge_small_v3_left_hinge();
} else if (show_part == "right_hinge") {
    hinge_small_v3_right_hinge();
} else if (show_part == "spacer") {
    hinge_small_v3_spacer();
} else if (show_part == "cap") {
    hinge_small_v3_cap();
} else {
    hinge_small_v3_assembly();
}
