// Support_Cam_PI_IR_Cut_CR6_v3.scad
// Connected parametric CR-6 Pi IR-cut camera support brackets.
//
// v3 is rebuilt as assembled parts: each side starts from one continuous
// footprint, then overlaps the upright tower and ribs into that footprint so the
// exported model is a connected printable bracket.  The original STLs were used
// only for measurements and bounding-box checks; no STL is imported here.

/* [Bracket Selection] */
bracket = "Right"; // [Right, Left, Both]

/* [Core Dimensions] */
base_z = 3;
base_thickness = 12;
left_base_z = 0;
tower_height = 82;
tower_width = 24;
tower_depth = 22;
tower_hole_diameter = 4.2;
camera_hole_diameter = 5.2;
brace_width = 5;
$fn = 64;

/* [Preview] */
both_spacing = 20; // [0:1:120]
preview_colors = true;

module maybe_color(name) {
    if (preview_colors && name == "Right") color("lightsteelblue") children();
    else if (preview_colors && name == "Left") color("palegreen") children();
    else children();
}

module extruded_footprint(points, z0, height) {
    translate([0, 0, z0])
        linear_extrude(height = height)
            polygon(points = points);
}

module through_z_hole(xy, z0, height, diameter) {
    translate([xy[0], xy[1], z0 - 0.5])
        cylinder(h = height + 1, d = diameter);
}

module tower_with_hole(origin, height, hole_y, hole_z) {
    difference() {
        translate(origin) cube([tower_width, tower_depth, height]);
        translate([origin[0] + tower_width / 2, hole_y, hole_z])
            rotate([90, 0, 0])
                cylinder(h = tower_depth + 3, d = tower_hole_diameter, center = true);
    }
}

module diagonal_strut(a, b, size = brace_width) {
    hull() {
        translate(a) cube([size, size, size], center = true);
        translate(b) cube([size, size, size], center = true);
    }
}

module right_base() {
    // One continuous top-view footprint: clamp lobe -> lower arm -> camera tab -> tower pad.
    difference() {
        union() {
            extruded_footprint([
                [-27, -13], [-23, -23], [-8, -20], [15, -18],
                [53, -18], [53, 23], [27, 23], [27, -6],
                [-3, -6], [-12, -2], [-22, -3]
            ], base_z, base_thickness);
            translate([-17, -13, base_z]) cylinder(h = base_thickness, d = 20);
        }
        through_z_hole([39.5, 8], base_z, base_thickness, camera_hole_diameter);
    }
}

module right_bracket_raw() {
    union() {
        right_base();

        // Tower overlaps the base footprint from z=3 upward, making one assembled solid.
        tower_with_hole([-9, -22, base_z], tower_height, -11, 76);

        // Connected triangular/diagonal braces from tower into the base and camera tab.
        diagonal_strut([12, -18, 18], [35, -6, 18], brace_width);
        diagonal_strut([12, -2, 22], [35, 20, 22], brace_width);
        diagonal_strut([15, -20, 18], [15, -4, 70], brace_width);
        diagonal_strut([-7, -20, 18], [13, -4, 70], brace_width);
    }
}

module left_base() {
    // One continuous top-view footprint: tower pad -> diagonal arm -> camera tab.
    difference() {
        extruded_footprint([
            [-18, 8], [-9, -1], [33, 40], [82, 40],
            [82, 60], [50, 60], [48, 56], [28, 56],
            [-13, 18]
        ], left_base_z, base_thickness);
        through_z_hole([64, 51], left_base_z, base_thickness, camera_hole_diameter);
    }
}

module left_bracket_raw() {
    union() {
        left_base();

        // Tower overlaps the diagonal base pad, keeping the left bracket assembled.
        tower_with_hole([-17, 2, left_base_z], tower_height, 13, 73);

        // Connected ribs tying the tower to the diagonal arm and camera tab.
        diagonal_strut([6, 4, 15], [30, 42, 15], brace_width);
        diagonal_strut([6, 22, 15], [50, 56, 15], brace_width);
        diagonal_strut([6, 4, 18], [6, 22, 70], brace_width);
        diagonal_strut([-15, 4, 18], [5, 22, 70], brace_width);
    }
}

module right_bracket() { maybe_color("Right") right_bracket_raw(); }
module left_bracket() { maybe_color("Left") left_bracket_raw(); }

module selected_bracket() {
    if (bracket == "Right") right_bracket();
    else if (bracket == "Left") left_bracket();
    else if (bracket == "Both") {
        translate([-65 - both_spacing / 2, 0, 0]) right_bracket();
        translate([35 + both_spacing / 2, 0, 0]) left_bracket();
    } else echo(str("Unknown bracket option: ", bracket));
}

selected_bracket();
