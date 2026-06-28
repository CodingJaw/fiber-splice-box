// 1/4-20 UNC bolt and matching nut using BOSL2.
// Units: millimeters. Requires BOSL2 in your OpenSCAD library path.

include <BOSL2/std.scad>
include <BOSL2/threading.scad>

/* [Part selector] */
show_bolt = true;
show_nut = true;
part_spacing = 18;

/* [Bolt dimensions] */
// Threaded shaft length in inches. Set to 1 for a 1 inch long bolt.
bolt_length_inches = 1; // [0.25:0.125:6]

/* [Print fit] */
// Increase for looser FDM thread fit; decrease for tighter fit.
$slop = 0.15;

/* [Detail] */
$fn = 96;

IN = 25.4;
quarter_20_major_diameter = 1/4 * IN;
quarter_20_tpi = 20;
quarter_20_pitch = IN / quarter_20_tpi;
bolt_thread_length = bolt_length_inches * IN;

// Common 1/4 in hex bolt/nut dimensions, rounded for printing.
bolt_head_width = 11;
bolt_head_height = 4;
nut_width = 11;
nut_thickness = 6;

module quarter_20_bolt() {
    union() {
        // Hex head sits on the build plate.
        cylinder(h = bolt_head_height, d = 2 * bolt_head_width / sqrt(3), $fn = 6);

        translate([0, 0, bolt_head_height])
            threaded_rod(
                d = quarter_20_major_diameter,
                l = bolt_thread_length,
                pitch = quarter_20_pitch,
                anchor = BOTTOM,
                bevel = true
            );
    }
}

module quarter_20_nut() {
    threaded_nut(
        nutwidth = nut_width,
        id = quarter_20_major_diameter,
        h = nut_thickness,
        pitch = quarter_20_pitch,
        shape = "hex",
        anchor = BOTTOM,
        bevel = true,
        ibevel = true
    );
}

module selected_parts() {
    if (show_bolt) {
        quarter_20_bolt();
    }

    if (show_nut) {
        translate([show_bolt ? part_spacing : 0, 0, 0])
            quarter_20_nut();
    }
}

selected_parts();
