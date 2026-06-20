// 1/4-20 bolt, 1 inch long, with a 6 mm thick threaded nut.
// Units: millimeters.

$fn = 96;

inch = 25.4;
bolt_major_diameter = 0.25 * inch;      // 1/4 inch nominal major diameter
bolt_length = 1 * inch;                 // 1 inch threaded length
threads_per_inch = 20;
thread_pitch = inch / threads_per_inch; // 20 TPI = 1.27 mm pitch
nut_thickness = 6;

head_diameter = 11;
head_height = 4;
nut_width_across_flats = 11;
clearance = 0.25;

// UNC/UNF threads use a 60 degree profile. The theoretical external thread
// depth is approximately 0.6495 * pitch; this is rounded down slightly to keep
// the OpenSCAD model printable and avoid overly sharp roots.
thread_depth = 0.75;
thread_profile_width = thread_pitch * 0.52;

module hex_prism(width_across_flats, height) {
    cylinder(h = height, r = width_across_flats / sqrt(3), $fn = 6);
}

module thread_ridge(major_diameter, length, pitch, depth, profile_width) {
    root_radius = major_diameter / 2 - depth;
    crest_radius = major_diameter / 2;
    turns = length / pitch;

    // A triangular 60-degree-ish tooth profile is twisted into a helix, giving
    // a much more recognizable screw thread than a round bead wrapped around
    // the shank.
    linear_extrude(height = length, twist = -360 * turns, slices = ceil(turns * 32))
        polygon(points = [
            [root_radius, -profile_width / 2],
            [crest_radius, 0],
            [root_radius, profile_width / 2]
        ]);
}

module threaded_rod(major_diameter, length, pitch, depth, profile_width) {
    root_diameter = major_diameter - 2 * depth;

    union() {
        cylinder(h = length, d = root_diameter);
        thread_ridge(major_diameter, length, pitch, depth, profile_width);
    }
}

module threaded_hole_cutter(major_diameter, length, pitch, depth, profile_width) {
    // Extend the cutter past both faces so the nut has complete threads from
    // face to face and no thin caps left by coincident geometry.
    translate([0, 0, -pitch])
        threaded_rod(major_diameter, length + 2 * pitch, pitch, depth, profile_width);
}

module quarter_20_bolt() {
    union() {
        translate([0, 0, -head_height])
            hex_prism(head_diameter, head_height);

        threaded_rod(
            bolt_major_diameter,
            bolt_length,
            thread_pitch,
            thread_depth,
            thread_profile_width
        );
    }
}

module quarter_20_nut() {
    difference() {
        hex_prism(nut_width_across_flats, nut_thickness);

        threaded_hole_cutter(
            bolt_major_diameter + clearance,
            nut_thickness,
            thread_pitch,
            thread_depth * 0.85,
            thread_profile_width
        );
    }
}

quarter_20_bolt();

translate([18, 0, 0])
    quarter_20_nut();
