// Version: v1
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
thread_fit = "loose"; // [normal, loose, extra loose]
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

// BOSL2 $slop adds 4*$slop diameter clearance to internal threads.
active_slop =
    thread_fit == "normal" ? 0.18 :
    thread_fit == "extra loose" ? 0.35 :
    0.25;

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
        d=thread_diameter,
        pitch=active_pitch,
        l=length,
        left_handed=left_handed_thread,
        bevel=true,
        blunt_start=false,
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
        id=thread_diameter,
        h=nut_height,
        pitch=active_pitch,
        shape=nut_shape,
        left_handed=left_handed_thread,
        bevel=true,
        ibevel=true,
        blunt_start=false,
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
