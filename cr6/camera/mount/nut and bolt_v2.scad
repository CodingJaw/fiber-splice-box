// Version: v2
// Minimal 28mm coarse-thread nut and bolt test print using BOSL2 matched thread primitives.

include <BOSL2/std.scad>
include <BOSL2/threading.scad>

/* [View] */
view_part = "print pair"; // [print pair, bolt only, nut only, assembled check]
layout_spacing = 48; // [36:1:80]
thread_resolution = 96; // [48:8:160]

/* [Threads] */
thread_diameter = 28; // [28:1:28]
thread_pitch = "coarse 3.0mm"; // [medium 2.0mm, coarse 3.0mm, extra coarse 3.5mm]
thread_fit = "very loose"; // [loose, very loose, extra loose, extreme]
thread_depth_style = "shallow"; // [standard, shallow, extra shallow]
thread_start = "easy lead-in"; // [easy lead-in, full thread]
bolt_diameter_trim = 0.20; // [0:0.05:1.0]
nut_diameter_extra = 0.00; // [0:0.05:1.0]
thread_handedness = "right hand"; // [right hand, left hand]

/* [Bolt] */
bolt_thread_length = 16; // [8:0.5:30]
bolt_head_shape = "hex"; // [hex, square]
bolt_head_width = 38; // [32:0.5:46]
bolt_head_height = 6; // [4:0.5:12]

/* [Nut] */
nut_shape = "hex"; // [hex, square]
nut_width = 38; // [32:0.5:46]
nut_height = 10; // [6:0.5:18]

active_pitch =
    thread_pitch == "medium 2.0mm" ? 2.0 :
    thread_pitch == "extra coarse 3.5mm" ? 3.5 :
    3.0;

standard_thread_depth = cos(30) * 5 / 8 * active_pitch;
active_thread_depth =
    thread_depth_style == "standard" ? standard_thread_depth :
    thread_depth_style == "extra shallow" ? standard_thread_depth * 0.55 :
    standard_thread_depth * 0.75;

bolt_major_d = thread_diameter - bolt_diameter_trim;
nut_major_d = thread_diameter + nut_diameter_extra;
bolt_thread_profile = [bolt_major_d - 2 * active_thread_depth, bolt_major_d - active_thread_depth, bolt_major_d];
nut_thread_profile = [nut_major_d - 2 * active_thread_depth, nut_major_d - active_thread_depth, nut_major_d];

// BOSL2 $slop adds 4*$slop diameter clearance to internal threads.
active_slop =
    thread_fit == "loose" ? 0.35 :
    thread_fit == "extra loose" ? 0.55 :
    thread_fit == "extreme" ? 0.75 :
    0.45;

use_easy_lead_in = thread_start == "easy lead-in";
left_handed_thread = thread_handedness == "left hand";

module head_shape(shape, width, height) {
    if (shape == "square") {
        translate([0, 0, height / 2])
            cube([width, width, height], center=true);
    } else {
        cylinder(d=width, h=height, $fn=6);
    }
}

module bolt_thread(length=bolt_thread_length) {
    $fn = thread_resolution;
    threaded_rod(
        d=bolt_thread_profile,
        pitch=active_pitch,
        l=length,
        left_handed=left_handed_thread,
        bevel=true,
        blunt_start=use_easy_lead_in,
        anchor=BOTTOM
    );
}

module bolt() {
    bolt_thread(bolt_thread_length);
    translate([0, 0, bolt_thread_length])
        head_shape(bolt_head_shape, bolt_head_width, bolt_head_height);
}

module nut() {
    $fn = thread_resolution;
    threaded_nut(
        nutwidth=nut_width,
        id=nut_thread_profile,
        h=nut_height,
        pitch=active_pitch,
        shape=nut_shape,
        left_handed=left_handed_thread,
        bevel=true,
        ibevel=true,
        blunt_start=use_easy_lead_in,
        anchor=BOTTOM,
        $slop=active_slop
    );
}

module assembled_check() {
    color([0.8, 0.8, 0.8, 0.55]) nut();
    color([0.1, 0.35, 1.0, 0.55]) bolt_thread(nut_height);
}

if (view_part == "bolt only") {
    bolt();
} else if (view_part == "nut only") {
    nut();
} else if (view_part == "assembled check") {
    assembled_check();
} else {
    translate([-layout_spacing / 2, 0, 0]) bolt();
    translate([layout_spacing / 2, 0, 0]) nut();
}
