// Version: v1
// Basic configurable rod/bolt and nut test model using BOSL2 threads.

include <BOSL2/std.scad>
include <BOSL2/threading.scad>

/* [View] */
view_part = "bolt and nut"; // [bolt and nut, bolt only, nut only, thread sample]
show_section_cut = "no"; // [no, yes]
layout_spacing = 48; // [30:1:80]
thread_resolution = 96; // [32:8:160]

/* [Size/Threads] */
shaft_size = 23; // [20:0.5:30]
thread_preset = "medium"; // [fine, medium, coarse, coarser, custom]
thread_pitch_choice = "2.0 mm"; // [1.0 mm, 1.5 mm, 2.0 mm, 2.5 mm, 3.0 mm, 3.5 mm, 4.0 mm]
thread_depth = 0.75; // [0.2:0.05:2.5]
thread_clearance = 0.25; // [0:0.05:1.5]
thread_handedness = "right hand"; // [right hand, left hand]

/* [Nut] */
nut_outer_shape = "hex"; // [square, hex, circular]
nut_height = 10; // [5:0.5:30]
nut_width = 34; // [24:0.5:50]

/* [Bolt] */
bolt_head_shape = "hex"; // [square, hex, circular]
bolt_head_height = 8; // [4:0.5:24]
bolt_head_width = 34; // [24:0.5:50]
rod_thread_length = 28; // [8:0.5:80]

pitch_from_choice =
    thread_pitch_choice == "1.0 mm" ? 1.0 :
    thread_pitch_choice == "1.5 mm" ? 1.5 :
    thread_pitch_choice == "2.0 mm" ? 2.0 :
    thread_pitch_choice == "2.5 mm" ? 2.5 :
    thread_pitch_choice == "3.0 mm" ? 3.0 :
    thread_pitch_choice == "3.5 mm" ? 3.5 :
    4.0;

preset_pitch =
    thread_preset == "fine" ? 1.0 :
    thread_preset == "medium" ? 1.5 :
    thread_preset == "coarse" ? 2.5 :
    thread_preset == "coarser" ? 3.5 :
    pitch_from_choice;

preset_depth =
    thread_preset == "fine" ? 0.45 :
    thread_preset == "medium" ? 0.70 :
    thread_preset == "coarse" ? 0.95 :
    thread_preset == "coarser" ? 1.20 :
    thread_depth;

active_pitch = preset_pitch;
active_depth = preset_depth;
thread_minor_d = shaft_size - 2 * active_depth;
thread_mid_d = shaft_size - active_depth;
left_handed_thread = thread_handedness == "left hand";

module outer_shape(shape, width, height) {
    if (shape == "square") {
        translate([0, 0, height / 2])
            cube([width, width, height], center=true);
    } else if (shape == "hex") {
        cylinder(d=width, h=height, $fn=6);
    } else {
        cylinder(d=width, h=height, $fn=thread_resolution);
    }
}

module external_thread(length=rod_thread_length) {
    $fn = thread_resolution;
    threaded_rod(
        d=[thread_minor_d, thread_mid_d, shaft_size],
        pitch=active_pitch,
        l=length,
        left_handed=left_handed_thread,
        bevel=true,
        blunt_start=false,
        anchor=BOTTOM
    );
}

module internal_thread_cutter(length=nut_height + 2) {
    $fn = thread_resolution;
    translate([0, 0, -1])
        threaded_rod(
            d=[thread_minor_d + thread_clearance, thread_mid_d + thread_clearance, shaft_size + thread_clearance],
            pitch=active_pitch,
            l=length,
            internal=true,
            left_handed=left_handed_thread,
            bevel=true,
            blunt_start=false,
            anchor=BOTTOM
        );
}

module nut() {
    difference() {
        outer_shape(nut_outer_shape, nut_width, nut_height);
        internal_thread_cutter();

        if (show_section_cut == "yes")
            translate([-nut_width, 0, -2]) cube([nut_width * 2, nut_width, nut_height + 4]);
    }
}

module bolt() {
    external_thread(rod_thread_length);
    translate([0, 0, rod_thread_length])
        outer_shape(bolt_head_shape, bolt_head_width, bolt_head_height);
}

module thread_sample() {
    external_thread(rod_thread_length);
    translate([layout_spacing, 0, 0])
        difference() {
            cylinder(d=shaft_size + 8, h=rod_thread_length, $fn=thread_resolution);
            translate([0, 0, -1]) internal_thread_cutter(rod_thread_length + 2);
        }
}

if (view_part == "bolt only") {
    bolt();
} else if (view_part == "nut only") {
    nut();
} else if (view_part == "thread sample") {
    thread_sample();
} else {
    translate([-layout_spacing / 2, 0, 0]) bolt();
    translate([layout_spacing / 2, 0, 0]) nut();
}
