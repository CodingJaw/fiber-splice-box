// Version: v7
// Basic configurable rod/bolt and nut test model using BOSL2 threads.

include <BOSL2/std.scad>
include <BOSL2/threading.scad>

/* [View] */
view_part = "bolt and nut"; // [bolt and nut, bolt only, nut only, thread sample, assembled fit check, thread interference check, base hole interference check]
show_section_cut = "no"; // [no, yes]
layout_spacing = 48; // [30:1:80]
thread_resolution = 96; // [32:8:160]

/* [Size/Threads] */
shaft_size = 23; // [20:0.5:30]
thread_preset = "medium"; // [fine, medium, coarse, coarser, custom]
thread_pitch_choice = "2.0 mm"; // [1.0 mm, 1.5 mm, 2.0 mm, 2.5 mm, 3.0 mm, 3.5 mm, 4.0 mm]
thread_depth = 0.75; // [0.2:0.05:2.5]
thread_fit = "auto by preset"; // [auto by preset, tight, normal, loose, extra loose, custom]
thread_clearance = 0.75; // [0:0.05:1.8]
thread_handedness = "right hand"; // [right hand, left hand]

/* [Nut] */
nut_outer_shape = "hex"; // [square, hex, circular]
nut_height = 10; // [5:0.5:30]
nut_width = 34; // [24:0.5:50]
base_plate = "enabled"; // [enabled, disabled]
base_plate_thickness = 4; // [1:0.5:16]
base_plate_center_hole = "enabled"; // [enabled, disabled]
base_plate_hole_mode = "custom hole"; // [custom hole, shaft pass-through]
base_plate_hole_d = 6.5; // [2:0.1:20]
base_plate_countersink = "none"; // [none, square nut, hex nut, round]
countersink_side = "top"; // [top, bottom]
countersink_width = 12; // [4:0.5:30]
countersink_depth = 3; // [0.5:0.5:12]

/* [Bolt] */
bolt_head_shape = "hex"; // [square, hex, circular]
bolt_head_height = 8; // [4:0.5:24]
bolt_head_width = 34; // [24:0.5:50]
rod_thread_length = 28; // [8:0.5:80]
bolt_end_pocket = "disabled"; // [enabled, disabled]
bolt_end_pocket_shape = "hex nut"; // [square nut, hex nut, round]
bolt_end_pocket_width = 12; // [4:0.5:30]
bolt_end_pocket_depth = 3; // [0.5:0.5:12]

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

auto_thread_clearance =
    thread_preset == "fine" ? 0.35 :
    thread_preset == "medium" ? 0.50 :
    thread_preset == "coarse" ? 0.75 :
    thread_preset == "coarser" ? 1.10 :
    thread_clearance;

active_clearance =
    thread_fit == "tight" ? 0.35 :
    thread_fit == "normal" ? 0.50 :
    thread_fit == "loose" ? 0.85 :
    thread_fit == "extra loose" ? 1.30 :
    thread_fit == "custom" ? thread_clearance :
    auto_thread_clearance;

// BOSL2 internal threads use $slop where total diameter clearance is 4*$slop.
internal_thread_slop = active_clearance / 4;
active_base_plate_hole_d = base_plate_hole_mode == "shaft pass-through" ? shaft_size + active_clearance : base_plate_hole_d;

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

module internal_thread_cutter(length=nut_height + 0.5) {
    $fn = thread_resolution;
    translate([0, 0, -0.01])
        threaded_rod(
            d=[thread_minor_d, thread_mid_d, shaft_size],
            pitch=active_pitch,
            l=length,
            internal=true,
            left_handed=left_handed_thread,
            bevel=true,
            blunt_start=false,
            anchor=BOTTOM,
            $slop=internal_thread_slop
        );
}

module countersink_shape(shape, width, depth) {
    if (shape == "square nut") {
        outer_shape("square", width, depth);
    } else if (shape == "hex nut") {
        outer_shape("hex", width, depth);
    } else if (shape == "round") {
        outer_shape("circular", width, depth);
    }
}

module base_plate_body() {
    if (base_plate == "enabled")
        translate([0, 0, -base_plate_thickness])
            outer_shape(nut_outer_shape, nut_width, base_plate_thickness);
}

limited_countersink_depth = min(countersink_depth, base_plate_thickness);

module base_plate_hole_cuts() {
    if (base_plate_center_hole == "enabled")
        translate([0, 0, -base_plate_thickness - 0.5])
            cylinder(d=active_base_plate_hole_d, h=base_plate_thickness + 1, $fn=thread_resolution);

    if (base_plate_countersink != "none") {
        countersink_z = countersink_side == "top" ? -limited_countersink_depth : -base_plate_thickness - 0.01;
        translate([0, 0, countersink_z])
            countersink_shape(base_plate_countersink, countersink_width, limited_countersink_depth + 0.01);
    }
}

module base_plate_with_hole_and_countersink() {
    if (base_plate == "enabled")
        difference() {
            base_plate_body();
            base_plate_hole_cuts();
        }
}

module threaded_nut_body() {
    difference() {
        outer_shape(nut_outer_shape, nut_width, nut_height);
        internal_thread_cutter();
    }
}

module nut() {
    difference() {
        union() {
            base_plate_with_hole_and_countersink();
            threaded_nut_body();
        }

        if (show_section_cut == "yes")
            translate([-nut_width, 0, -base_plate_thickness - 2])
                cube([nut_width * 2, nut_width, nut_height + base_plate_thickness + 4]);
    }
}

limited_bolt_end_pocket_depth = min(bolt_end_pocket_depth, rod_thread_length);

module bolt_end_pocket_cut() {
    if (bolt_end_pocket == "enabled")
        translate([0, 0, -0.01])
            countersink_shape(bolt_end_pocket_shape, bolt_end_pocket_width, limited_bolt_end_pocket_depth + 0.01);
}

module bolt() {
    difference() {
        union() {
            external_thread(rod_thread_length);
            translate([0, 0, rod_thread_length])
                outer_shape(bolt_head_shape, bolt_head_width, bolt_head_height);
        }

        bolt_end_pocket_cut();
    }
}


module assembled_fit_check() {
    // Visual check: bolt is coaxial with the nut.  Use F5 preview with transparency,
    // or enable section cut to inspect whether the threaded shaft reaches the base plate.
    color([0.8, 0.8, 0.8, 0.55]) nut();
    color([0.1, 0.35, 1.0, 0.55]) external_thread(nut_height + base_plate_thickness);
}

module fit_check_marker(label_z=0) {
    // Small green marker keeps F6 from producing an empty export when no interference exists.
    color([0, 0.8, 0, 1])
        translate([shaft_size, 0, label_z])
            cylinder(d=3, h=1, $fn=24);
}

module thread_interference_check() {
    // Red geometry means the generated male thread intersects the generated female thread.
    // If you only see the small green marker, the SCAD thread geometry has clearance.
    fit_check_marker(nut_height / 2);
    color([1, 0, 0, 1])
        intersection() {
            threaded_nut_body();
            external_thread(nut_height);
        }
}

module base_hole_interference_check() {
    // Red geometry means the threaded shaft is colliding with the base plate hole.
    // If using a base plate and the bolt must pass through it, set base_plate_hole_mode to shaft pass-through.
    // If you only see the small green marker, the base hole is large enough for the threaded shaft.
    fit_check_marker(-base_plate_thickness / 2);
    color([1, 0, 0, 1])
        intersection() {
            base_plate_with_hole_and_countersink();
            translate([0, 0, -base_plate_thickness])
                external_thread(base_plate_thickness);
        }
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
} else if (view_part == "assembled fit check") {
    assembled_fit_check();
} else if (view_part == "thread interference check") {
    thread_interference_check();
} else if (view_part == "base hole interference check") {
    base_hole_interference_check();
} else {
    translate([-layout_spacing / 2, 0, 0]) bolt();
    translate([layout_spacing / 2, 0, 0]) nut();
}
