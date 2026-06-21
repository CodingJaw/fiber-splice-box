// Small hinge, version 12.
//
// Procedural OpenSCAD recreation of the hinge set from:
//   Hinge_small_L.stl
//   Hinge_small_R.stl
//   Hinge_small_Sp.stl
//   Hinge_small_Cap.stl
//   Hinges_small_v2.blend1
//
// V12 returns to V10 relief behavior and adds right-relief outer overcut to remove leftover side material.
// The defaults are sized to match the original STL bounding boxes while
// exposing grouped Customizer controls for each object and common settings.

$fn = 96;

/* [View] */

view = "assembled"; // [assembled: Assembled view, printable_exploded: Printable exploded view, left_hinge: Left hinge only, right_hinge: Right hinge only, spacer: Spacer only, cap: Pin cap only]
printable_exploded_spacing = 14;
assembled_gap = 0;

/* [Common Mounting Holes] */

mount_hole_spacing = 20;
mount_hole_diameter = 4.2;
countersink_diameter = 9.5;
countersink_depth = 1.4;

/* [Barrels - Common] */

barrel_outer_diameter = 13.72;
barrel_total_length = 35;
barrel_bore_diameter = 6.7;
barrel_center_y = 0;
barrel_center_z = 0;
barrel_bore_cuts_supports = true; // [true: Keep the inside barrel hole clear through supports, false: Only cut the cylinder barrel]
barrel_clearance_gap = 0.7;

/* [Barrels - Left Hinge Supports] */

left_outer_barrel_length = 7.5;
left_support_enabled = true;
left_support_depth = 7.2;
left_support_height = 4.2;
left_support_y_overlap = 1.0;

/* [Barrels - Left Hinge Base Relief] */

left_base_relief_enabled = true;
left_base_relief_depth = 7.0;
left_base_relief_corner_radius = 5.0;
left_base_relief_square_amount = 0.35;

/* [Barrels - Right Hinge Supports] */

right_center_barrel_length = 19.5;
right_support_enabled = true;
right_support_depth = 7.2;
right_support_height = 4.2;
right_support_y_overlap = 1.0;

/* [Barrels - Right Hinge Base Relief] */

right_base_relief_enabled = true;
right_base_relief_depth = 7.0;
right_base_relief_corner_radius = 5.0;
right_base_relief_square_amount = 0.35;
right_base_relief_outer_overcut = 6.0;

/* [Left Hinge Object] */

left_leaf_width = 35;
left_leaf_length = 42;
left_leaf_thickness = 3.5;
left_leaf_corner_radius = 7.5;
left_leaf_y_start = -42;
left_mount_hole_y = -35;

/* [Right Hinge Object] */

right_leaf_width = 35;
right_leaf_length = 42;
right_leaf_thickness = 3.5;
right_leaf_corner_radius = 7.5;
right_leaf_y_start = 0;
right_mount_hole_y = 35;

/* [Spacer Object] */

spacer_auto_fit_to_bore = true;
spacer_barrel_clearance = 0.4;
spacer_shaft_diameter = 6.3;
spacer_shaft_length = 35.65;
spacer_x_start = -17.85;
spacer_head_diameter = 12.6;
spacer_head_thickness = 2.45;
spacer_screw_hole_diameter = 2.6;
spacer_screw_hole_depth = 6;

/* [Cap Object] */

cap_diameter = 12.6;
cap_length = 2.5;
cap_x_start = -22.58;
cap_socket_diameter = 3.0;
cap_socket_depth = 1.1;
cap_pin_end_gap = 0;

/* [Hidden] */

epsilon = 0.02;

function fitted_spacer_shaft_diameter() =
    spacer_auto_fit_to_bore
        ? min(spacer_shaft_diameter, max(0.1, barrel_bore_diameter - spacer_barrel_clearance))
        : spacer_shaft_diameter;


module rounded_leaf_2d(width, length, radius) {
    hull() {
        translate([-width / 2 + radius, radius])
            circle(r = radius);
        translate([width / 2 - radius, radius])
            circle(r = radius);
        translate([-width / 2 + radius, length - radius])
            circle(r = radius);
        translate([width / 2 - radius, length - radius])
            circle(r = radius);
    }
}

module countersunk_mounting_hole(x, y, thickness) {
    translate([x, y, -thickness - epsilon])
        cylinder(h = thickness + 2 * epsilon, d = mount_hole_diameter);

    translate([x, y, -thickness / 2 - epsilon])
        cylinder(h = countersink_depth + epsilon, d1 = countersink_diameter, d2 = mount_hole_diameter);
}

module base_leaf_blank(y_start, width, length, thickness, radius) {
    translate([0, y_start, -barrel_outer_diameter / 2])
        linear_extrude(height = thickness)
            rounded_leaf_2d(width, length, radius);
}

module base_relief_2d(length, depth, side, corner_radius, square_amount) {
    effective_radius = max(0, min(corner_radius * (1 - square_amount), min(length, depth) / 2));

    if (effective_radius <= 0.01) {
        translate([0, side < 0 ? -depth : 0])
            square([length, depth]);
    } else if (side < 0) {
        hull() {
            square([length, 0.01]);
            translate([effective_radius, -depth + effective_radius])
                circle(r = effective_radius);
            translate([length - effective_radius, -depth + effective_radius])
                circle(r = effective_radius);
        }
    } else {
        hull() {
            translate([0, -0.01])
                square([length, 0.01]);
            translate([effective_radius, depth - effective_radius])
                circle(r = effective_radius);
            translate([length - effective_radius, depth - effective_radius])
                circle(r = effective_radius);
        }
    }
}

module base_relief_cut(x_start, side, length, depth, corner_radius, square_amount, thickness) {
    translate([x_start, barrel_center_y, -barrel_outer_diameter / 2 - epsilon])
        linear_extrude(height = thickness + 2 * epsilon)
            base_relief_2d(length, depth, side, corner_radius, square_amount);
}

module mounting_holes_for_leaf(hole_y, thickness) {
    countersunk_mounting_hole(-mount_hole_spacing / 2, hole_y, thickness);
    countersunk_mounting_hole(mount_hole_spacing / 2, hole_y, thickness);
}

module barrel_bore(length) {
    rotate([0, 90, 0])
        translate([0, 0, -epsilon])
            cylinder(h = length + 2 * epsilon, d = barrel_bore_diameter);
}

module barrel_cylinder(length) {
    difference() {
        rotate([0, 90, 0])
            cylinder(h = length, d = barrel_outer_diameter);
        barrel_bore(length);
    }
}

module barrel_support_web(length, side, support_depth, support_height, y_overlap) {
    y_inner = side < 0 ? barrel_center_y - y_overlap : barrel_center_y + y_overlap;
    y_outer = side < 0 ? barrel_center_y - support_depth : barrel_center_y + support_depth;
    z_bottom = barrel_center_z - barrel_outer_diameter / 2;

    translate([0, min(y_inner, y_outer), z_bottom])
        cube([length, abs(y_outer - y_inner), support_height]);
}

module barrel_segment(x_start, length, support_enabled = false, support_side = -1, support_depth = 7.2, support_height = 4.2, support_y_overlap = 1.0) {
    translate([x_start, 0, 0])
        if (support_enabled && barrel_bore_cuts_supports) {
            difference() {
                union() {
                    translate([0, barrel_center_y, barrel_center_z])
                        rotate([0, 90, 0])
                            cylinder(h = length, d = barrel_outer_diameter);
                    barrel_support_web(length, support_side, support_depth, support_height, support_y_overlap);
                }
                translate([0, barrel_center_y, barrel_center_z])
                    barrel_bore(length);
            }
        } else if (support_enabled) {
            union() {
                translate([0, barrel_center_y, barrel_center_z])
                    barrel_cylinder(length);
                barrel_support_web(length, support_side, support_depth, support_height, support_y_overlap);
            }
        } else {
            translate([0, barrel_center_y, barrel_center_z])
                barrel_cylinder(length);
        }
}

module left_hinge_object() {
    translate([0, -assembled_gap / 2, 0])
        union() {
            difference() {
                base_leaf_blank(left_leaf_y_start, left_leaf_width, left_leaf_length, left_leaf_thickness, left_leaf_corner_radius);
                mounting_holes_for_leaf(left_mount_hole_y, left_leaf_thickness);
                if (left_base_relief_enabled) {
                    base_relief_cut(-right_center_barrel_length / 2, -1, right_center_barrel_length, left_base_relief_depth, left_base_relief_corner_radius, left_base_relief_square_amount, left_leaf_thickness);
                }
            }
            barrel_segment(-barrel_total_length / 2, left_outer_barrel_length, left_support_enabled, -1, left_support_depth, left_support_height, left_support_y_overlap);
            barrel_segment(barrel_total_length / 2 - left_outer_barrel_length, left_outer_barrel_length, left_support_enabled, -1, left_support_depth, left_support_height, left_support_y_overlap);
        }
}

module right_hinge_object() {
    translate([0, assembled_gap / 2, 0])
        union() {
            difference() {
                base_leaf_blank(right_leaf_y_start, right_leaf_width, right_leaf_length, right_leaf_thickness, right_leaf_corner_radius);
                mounting_holes_for_leaf(right_mount_hole_y, right_leaf_thickness);
                if (right_base_relief_enabled) {
                    base_relief_cut(-barrel_total_length / 2 - right_base_relief_outer_overcut, 1, left_outer_barrel_length + right_base_relief_outer_overcut, right_base_relief_depth, right_base_relief_corner_radius, right_base_relief_square_amount, right_leaf_thickness);
                    base_relief_cut(barrel_total_length / 2 - left_outer_barrel_length, 1, left_outer_barrel_length + right_base_relief_outer_overcut, right_base_relief_depth, right_base_relief_corner_radius, right_base_relief_square_amount, right_leaf_thickness);
                }
            }
            barrel_segment(-right_center_barrel_length / 2, right_center_barrel_length, right_support_enabled, 1, right_support_depth, right_support_height, right_support_y_overlap);
        }
}

module spacer_object() {
    translate([spacer_x_start, 0, 0])
        rotate([0, 90, 0])
            difference() {
                union() {
                    cylinder(h = spacer_shaft_length, d = fitted_spacer_shaft_diameter());
                    translate([0, 0, spacer_shaft_length])
                        cylinder(h = spacer_head_thickness, d = spacer_head_diameter);
                }

                translate([0, 0, -epsilon])
                    cylinder(h = spacer_screw_hole_depth + epsilon, d = spacer_screw_hole_diameter);
            }
}

module cap_object() {
    translate([cap_x_start - cap_pin_end_gap, 0, 0])
        rotate([0, 90, 0])
            difference() {
                cylinder(h = cap_length, d = cap_diameter);
                translate([0, 0, cap_length - cap_socket_depth])
                    cylinder(h = cap_socket_depth + epsilon, d = cap_socket_diameter);
            }
}

module assembled_view() {
    left_hinge_object();
    right_hinge_object();
    spacer_object();
    cap_object();
}

module printable_exploded_view() {
    translate([0, -printable_exploded_spacing, 0])
        left_hinge_object();
    translate([0, printable_exploded_spacing, 0])
        right_hinge_object();
    translate([barrel_total_length + printable_exploded_spacing, 0, 0])
        spacer_object();
    translate([-barrel_total_length - printable_exploded_spacing, 0, 0])
        cap_object();
}

if (view == "printable_exploded") {
    printable_exploded_view();
} else if (view == "left_hinge") {
    left_hinge_object();
} else if (view == "right_hinge") {
    right_hinge_object();
} else if (view == "spacer") {
    spacer_object();
} else if (view == "cap") {
    cap_object();
} else {
    assembled_view();
}
