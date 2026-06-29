// Version: v2
// Combined fit model for:
//   - obj_2_Action mount_threaded_3blade.stl (outer thread)
//   - obj_6_Action mount 2.3 (1).stl (inner thread receiver)
// Uses BOSL2 threaded_rod() for the adjustable male-thread gauge and female-thread cutter.

include <BOSL2/std.scad>
include <BOSL2/threading.scad>

/* [View] */
part_to_show = "assembled pair"; // [assembled pair, obj2 outer threaded part, obj6 corrected inner threaded part, thread gauges]
show_imported_meshes = "yes"; // [yes, no]
show_thread_gauges = "yes"; // [yes, no]
obj6_section_cut = "no"; // [no, yes]

/* [Thread Fit] */
thread_standard = "TPI"; // [TPI, Metric pitch]
thread_tpi = 20; // [8:1:40]
metric_pitch = 1.25; // [0.5:0.05:3]
thread_major_d = 23.0; // [18:0.1:28]
thread_depth = 0.72; // [0.2:0.01:1.5]
fit_slop = 0.15; // [0:0.01:0.8]
thread_clearance = 0.20; // [0:0.01:1.2]
thread_starts = 1; // [1:1:4]
thread_handedness = "right hand"; // [right hand, left hand]
lead_in_style = "default"; // [default, cut, smooth]
thread_bevel = "yes"; // [yes, no]
thread_fn = 96; // [32:8:160]

/* [Obj6 Receiver Correction] */
obj6_receiver_height = 10.0; // [6:0.1:16]
obj6_outer_fit_d = 24.0; // [20:0.1:32]
obj6_bottom_z = 0.0; // [-5:0.1:5]
inner_thread_extra_length = 1.0; // [0:0.1:5]
outer_body_mode = "round fitted body"; // [round fitted body, trim to custom diameter, keep original mesh]

/* [Assembly Alignment] */
obj2_z = 0.0; // [-20:0.1:20]
obj6_z = 13.0; // [-10:0.1:35]
obj6_rotation = 0; // [0:1:359]
assembly_gap = 0.25; // [0:0.01:3]

// Source STLs are kept in this same directory.
/* [Hidden] */
obj2_stl = "obj_2_Action mount_threaded_3blade.stl";
obj6_stl = "obj_6_Action mount 2.3 (1).stl";

// Bounding-box centers from the source meshes. Z is intentionally not centered.
obj2_xy_center = [175.623993, -142.200012];
obj6_xy_center = [445.536437, 131.265518];

INCH = 25.4;
thread_pitch = thread_standard == "TPI" ? INCH / thread_tpi : metric_pitch;
left_handed_thread = thread_handedness == "left hand";
bevel_threads = thread_bevel == "yes";
thread_profile = [
    thread_major_d - 2 * thread_depth,
    thread_major_d - thread_depth,
    thread_major_d
];
internal_thread_profile = [
    thread_major_d - 2 * thread_depth + fit_slop,
    thread_major_d - thread_depth + fit_slop + thread_clearance / 2,
    thread_major_d + fit_slop + thread_clearance
];

module obj2_imported() {
    translate([-obj2_xy_center[0], -obj2_xy_center[1], obj2_z])
        import(obj2_stl, convexity=10);
}

module obj6_imported() {
    rotate([0, 0, obj6_rotation])
        translate([-obj6_xy_center[0], -obj6_xy_center[1], obj6_z + assembly_gap])
            import(obj6_stl, convexity=10);
}

module outer_thread_gauge(length=23) {
    $fn = thread_fn;
    threaded_rod(
        d=thread_profile,
        pitch=thread_pitch,
        l=length,
        starts=thread_starts,
        left_handed=left_handed_thread,
        bevel=bevel_threads,
        blunt_start=true,
        lead_in_shape=lead_in_style,
        anchor=BOTTOM
    );
}

module inner_thread_cutter(length=obj6_receiver_height + 2 * inner_thread_extra_length) {
    $fn = thread_fn;
    translate([0, 0, obj6_z + obj6_bottom_z - inner_thread_extra_length + assembly_gap])
        threaded_rod(
            d=internal_thread_profile,
            pitch=thread_pitch,
            l=length,
            starts=thread_starts,
            internal=true,
            left_handed=left_handed_thread,
            bevel=bevel_threads,
            blunt_start=true,
            lead_in_shape=lead_in_style,
            anchor=BOTTOM
        );
}

module obj6_outer_trim_mask() {
    translate([0, 0, obj6_z + obj6_bottom_z - 0.05 + assembly_gap])
        cylinder(d=obj6_outer_fit_d, h=obj6_receiver_height + 0.1, $fn=thread_fn);
}

module obj6_corrected_receiver() {
    difference() {
        if (outer_body_mode == "round fitted body" || outer_body_mode == "trim to custom diameter") {
            intersection() {
                obj6_imported();
                obj6_outer_trim_mask();
            }
        } else {
            obj6_imported();
        }

        inner_thread_cutter();

        if (obj6_section_cut == "yes")
            translate([-50, 0, -20]) cube([100, 60, 80]);
    }
}

module assembled_pair() {
    if (show_imported_meshes == "yes") {
        obj2_imported();
        obj6_corrected_receiver();
    }

    if (show_thread_gauges == "yes") {
        color([0.1, 0.4, 1.0, 0.35]) translate([0, 0, obj2_z]) outer_thread_gauge(23);
        color([1.0, 0.25, 0.1, 0.30]) inner_thread_cutter();
    }
}

if (part_to_show == "obj2 outer threaded part") {
    obj2_imported();
    if (show_thread_gauges == "yes") color([0.1, 0.4, 1.0, 0.35]) translate([0, 0, obj2_z]) outer_thread_gauge(23);
} else if (part_to_show == "obj6 corrected inner threaded part") {
    obj6_corrected_receiver();
} else if (part_to_show == "thread gauges") {
    color([0.1, 0.4, 1.0, 0.35]) translate([0, 0, obj2_z]) outer_thread_gauge(23);
    color([1.0, 0.25, 0.1, 0.30]) inner_thread_cutter();
} else {
    assembled_pair();
}
