// Support_Cam_PI_IR_Cut_CR6_v1.scad
// OpenSCAD Customizer wrapper for the original CR-6 Pi IR-cut camera brackets.
//
// This file recreates the two existing STL outputs in this directory by
// selecting which source bracket to import.  Use OpenSCAD's Customizer to pick
// the left bracket, the right bracket, or show both for comparison.

/* [Bracket Selection] */
// Which bracket should be generated?
bracket = "Right"; // [Right, Left, Both]

/* [Preview] */
// Space between the two parts when bracket is set to "Both".
both_spacing = 15; // [0:1:100]

// Apply preview colors in OpenSCAD. Disable before exporting if you prefer a plain model.
preview_colors = true;

/* [Placement] */
// Move the selected output after import.
output_translate = [0, 0, 0];

// Rotate the selected output after import.
output_rotate = [0, 0, 0];

/* [Source STL Files] */
right_stl = "Support_Cam_PI_IR_Cut_CR6_Right-3.stl";
left_stl = "Support_Cam_PI_IR_Cut_CR6_left.stl";

module maybe_color(name) {
    if (preview_colors) {
        if (name == "Right") {
            color("lightsteelblue") children();
        } else if (name == "Left") {
            color("palegreen") children();
        } else {
            children();
        }
    } else {
        children();
    }
}

module right_bracket() {
    maybe_color("Right") import(right_stl, convexity = 10);
}

module left_bracket() {
    maybe_color("Left") import(left_stl, convexity = 10);
}

module selected_bracket() {
    if (bracket == "Right") {
        right_bracket();
    } else if (bracket == "Left") {
        left_bracket();
    } else if (bracket == "Both") {
        translate([-(79.722 + both_spacing) / 2, 0, 0]) right_bracket();
        translate([(99.400 + both_spacing) / 2, 0, 0]) left_bracket();
    } else {
        echo(str("Unknown bracket option: ", bracket));
    }
}

translate(output_translate)
    rotate(output_rotate)
        selected_bracket();
