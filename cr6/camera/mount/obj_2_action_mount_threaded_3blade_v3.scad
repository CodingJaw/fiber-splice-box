// Version: v3
// Source STL: obj_2_Action mount_threaded_3blade.stl
// Replaces the lower outside threaded section with configurable BOSL2 threads or a smooth barrel.

include <BOSL2/std.scad>
include <BOSL2/threading.scad>

/* [View] */
part_to_show = "replacement applied"; // [replacement applied, original centered STL, replacement thread only, upper body only]
show_cut_plane_preview = "no"; // [no, yes]

/* [Thread Preset] */
thread_surface = "threaded"; // [threaded, smooth]
thread_preset = "Printed 23mm x 20TPI"; // [Custom, Printed 20mm x 2.0, Printed 22mm x 2.0, Printed 23mm x 20TPI, Printed 23mm x 2.0, Printed 24mm x 2.0, Printed 25mm x 2.0, Printed 26mm x 2.0, Printed 28mm x 2.0, Printed 30mm x 3.0, M20x2.5, M22x2.5, M24x3, M24x2, M25x2, M26x2, M27x2, M28x2, M30x3.5, 1/4-20 UNC, 1/4-28 UNF, M6x1, M8x1.25, M10x1.5, M12x1.75]
thread_units = "TPI"; // [TPI, Metric pitch mm]

/* [Custom Thread Settings] */
custom_major_d = 23.0; // [16:0.1:32]
custom_tpi = 20; // [8:1:40]
custom_pitch_mm = 1.25; // [0.5:0.05:4]
custom_thread_depth = 0.72; // [0.2:0.01:2.4]
thread_length = 6.0; // [2:0.1:14]
thread_starts = 1; // [1:1:4]
thread_handedness = "right hand"; // [right hand, left hand]
thread_lead_in = "default"; // [default, cut, smooth]
thread_bevel = "yes"; // [yes, no]
thread_resolution = 96; // [32:8:160]

/* [Thread Location] */
replace_from_z = 0.0; // [-2:0.1:4]
remove_existing_threads_above_z = 6.0; // [2:0.1:12]
replacement_overlap = 0.15; // [0:0.01:1]

/* [Fit Tuning] */
major_d_adjust = 0.0; // [-1:0.01:1]
depth_adjust = 0.0; // [-0.5:0.01:0.5]
pitch_adjust = 0.0; // [-0.25:0.01:0.25]

/* [Hidden] */
source_stl = "obj_2_Action mount_threaded_3blade.stl";
xy_center = [175.623993, -142.200012];
model_height = 23;
INCH_MM = 25.4;

preset_major_d =
    thread_preset == "Printed 20mm x 2.0" ? 20.0 :
    thread_preset == "Printed 22mm x 2.0" ? 22.0 :
    thread_preset == "Printed 23mm x 20TPI" ? 23.0 :
    thread_preset == "Printed 23mm x 2.0" ? 23.0 :
    thread_preset == "Printed 24mm x 2.0" ? 24.0 :
    thread_preset == "Printed 25mm x 2.0" ? 25.0 :
    thread_preset == "Printed 26mm x 2.0" ? 26.0 :
    thread_preset == "Printed 28mm x 2.0" ? 28.0 :
    thread_preset == "Printed 30mm x 3.0" ? 30.0 :
    thread_preset == "M20x2.5" ? 20.0 :
    thread_preset == "M22x2.5" ? 22.0 :
    thread_preset == "M24x3" ? 24.0 :
    thread_preset == "M24x2" ? 24.0 :
    thread_preset == "M25x2" ? 25.0 :
    thread_preset == "M26x2" ? 26.0 :
    thread_preset == "M27x2" ? 27.0 :
    thread_preset == "M28x2" ? 28.0 :
    thread_preset == "M30x3.5" ? 30.0 :
    thread_preset == "1/4-20 UNC" ? 6.35 :
    thread_preset == "1/4-28 UNF" ? 6.35 :
    thread_preset == "M6x1" ? 6.0 :
    thread_preset == "M8x1.25" ? 8.0 :
    thread_preset == "M10x1.5" ? 10.0 :
    thread_preset == "M12x1.75" ? 12.0 :
    custom_major_d;

preset_pitch =
    thread_preset == "Printed 20mm x 2.0" ? 2.0 :
    thread_preset == "Printed 22mm x 2.0" ? 2.0 :
    thread_preset == "Printed 23mm x 20TPI" ? INCH_MM / 20 :
    thread_preset == "Printed 23mm x 2.0" ? 2.0 :
    thread_preset == "Printed 24mm x 2.0" ? 2.0 :
    thread_preset == "Printed 25mm x 2.0" ? 2.0 :
    thread_preset == "Printed 26mm x 2.0" ? 2.0 :
    thread_preset == "Printed 28mm x 2.0" ? 2.0 :
    thread_preset == "Printed 30mm x 3.0" ? 3.0 :
    thread_preset == "M20x2.5" ? 2.5 :
    thread_preset == "M22x2.5" ? 2.5 :
    thread_preset == "M24x3" ? 3.0 :
    thread_preset == "M24x2" ? 2.0 :
    thread_preset == "M25x2" ? 2.0 :
    thread_preset == "M26x2" ? 2.0 :
    thread_preset == "M27x2" ? 2.0 :
    thread_preset == "M28x2" ? 2.0 :
    thread_preset == "M30x3.5" ? 3.5 :
    thread_preset == "1/4-20 UNC" ? INCH_MM / 20 :
    thread_preset == "1/4-28 UNF" ? INCH_MM / 28 :
    thread_preset == "M6x1" ? 1.0 :
    thread_preset == "M8x1.25" ? 1.25 :
    thread_preset == "M10x1.5" ? 1.5 :
    thread_preset == "M12x1.75" ? 1.75 :
    (thread_units == "TPI" ? INCH_MM / custom_tpi : custom_pitch_mm);

printed_preset =
    thread_preset == "Printed 20mm x 2.0" ||
    thread_preset == "Printed 22mm x 2.0" ||
    thread_preset == "Printed 23mm x 20TPI" ||
    thread_preset == "Printed 23mm x 2.0" ||
    thread_preset == "Printed 24mm x 2.0" ||
    thread_preset == "Printed 25mm x 2.0" ||
    thread_preset == "Printed 26mm x 2.0" ||
    thread_preset == "Printed 28mm x 2.0" ||
    thread_preset == "Printed 30mm x 3.0";

preset_depth =
    thread_preset == "Custom" ? custom_thread_depth :
    printed_preset ? min(0.95, cos(30) * 5 / 8 * preset_pitch) :
    cos(30) * 5 / 8 * preset_pitch;

thread_major_d = preset_major_d + major_d_adjust;
thread_pitch = preset_pitch + pitch_adjust;
thread_depth = preset_depth + depth_adjust;
thread_minor_d = thread_major_d - 2 * thread_depth;
thread_mid_d = thread_major_d - thread_depth;
left_handed_thread = thread_handedness == "left hand";
bevel_threads = thread_bevel == "yes";

module original_centered_stl() {
    translate([-xy_center[0], -xy_center[1], 0])
        import(source_stl, convexity=10);
}

module upper_body_without_original_threads() {
    intersection() {
        original_centered_stl();
        translate([-50, -50, remove_existing_threads_above_z - replacement_overlap])
            cube([100, 100, model_height - remove_existing_threads_above_z + replacement_overlap + 1]);
    }
}

module replacement_surface() {
    translate([0, 0, replace_from_z]) {
        if (thread_surface == "smooth") {
            cylinder(d=thread_major_d, h=thread_length, $fn=thread_resolution);
        } else {
            $fn = thread_resolution;
            threaded_rod(
                d=[thread_minor_d, thread_mid_d, thread_major_d],
                pitch=thread_pitch,
                l=thread_length,
                starts=thread_starts,
                left_handed=left_handed_thread,
                bevel=bevel_threads,
                blunt_start=false,
                lead_in_shape=thread_lead_in,
                anchor=BOTTOM
            );
        }
    }
}

module replacement_applied() {
    union() {
        upper_body_without_original_threads();
        replacement_surface();
    }

    if (show_cut_plane_preview == "yes") {
        color([1, 0, 0, 0.25])
            translate([-14, -14, remove_existing_threads_above_z])
                cube([28, 28, 0.05]);
    }
}

if (part_to_show == "original centered STL") {
    original_centered_stl();
} else if (part_to_show == "replacement thread only") {
    replacement_surface();
} else if (part_to_show == "upper body only") {
    upper_body_without_original_threads();
} else {
    replacement_applied();
}
