// Small hinge, version 5.
//
// Fully procedural OpenSCAD model based on measurements from the original V1
// STL files.  Unlike V3/V4, this file does not import STL geometry, so every
// displayed dimension is adjustable in the OpenSCAD Customizer.

$fn = 96;

/* [View] */

show_part = "assembly"; // [assembly: Assembly, exploded: Exploded, left_hinge: Left hinge, right_hinge: Right hinge, spacer: Spacer pin, cap: End cap]
exploded_spacing = 28;

/* [Left Hinge] */

left_leaf_width = 35;
left_leaf_length = 42;
left_leaf_thickness = 3.5;
left_leaf_rounding = 7.5;
left_leaf_y = -42;
left_hinge_gap_offset = 0;

/* [Right Hinge] */

right_leaf_width = 35;
right_leaf_length = 42;
right_leaf_thickness = 3.5;
right_leaf_rounding = 7.5;
right_leaf_y = 0;
right_hinge_gap_offset = 0;

/* [Hinge Gap] */

hinge_gap = 0;
barrel_gap = 0.7;

/* [Mounting Holes] */

hole_spacing = 20;
hole_diameter = 4.2;
countersink_diameter = 9.5;
countersink_depth = 1.4;
left_hole_y = -35;
right_hole_y = 35;

/* [Barrels] */

barrel_diameter = 13.72;
barrel_length = 35;
barrel_center_y = 0;
barrel_center_z = 0;
barrel_bore_diameter = 6.7;
left_outer_barrel_length = 7.5;
right_center_barrel_length = 19.5;

/* [Spacer Pin] */

spacer_diameter = 12.6;
spacer_length = 38.1;
spacer_tip_diameter = 10.0;
spacer_tip_length = 7.8;
spacer_head_diameter = 12.6;
spacer_head_length = 2.45;
spacer_x_start = -17.85;

/* [Pin Cap] */

cap_diameter = 12.6;
cap_length = 2.5;
cap_socket_diameter = 3.0;
cap_socket_depth = 1.1;
pin_end_gap = 0;
cap_x_start = -22.58;

/* [Hidden] */

epsilon = 0.02;

module rounded_leaf_2d(width, length, rounding) {
    hull() {
        translate([-width / 2 + rounding, rounding])
            circle(r = rounding);
        translate([width / 2 - rounding, rounding])
            circle(r = rounding);
        translate([-width / 2 + rounding, length - rounding])
            circle(r = rounding);
        translate([width / 2 - rounding, length - rounding])
            circle(r = rounding);
    }
}

module mounting_hole(x, y, thickness) {
    translate([x, y, -thickness - epsilon])
        cylinder(h = thickness + 2 * epsilon, d = hole_diameter);

    translate([x, y, -thickness / 2 - epsilon])
        cylinder(h = countersink_depth + epsilon, d1 = countersink_diameter, d2 = hole_diameter);
}

module leaf_plate(y_start, width, length, thickness, rounding, hole_y) {
    difference() {
        translate([0, y_start, -barrel_diameter / 2])
            linear_extrude(height = thickness)
                rounded_leaf_2d(width, length, rounding);

        mounting_hole(-hole_spacing / 2, hole_y, thickness);
        mounting_hole(hole_spacing / 2, hole_y, thickness);
    }
}

module barrel_segment(x_start, length) {
    translate([x_start, barrel_center_y, barrel_center_z])
        rotate([0, 90, 0])
            difference() {
                cylinder(h = length, d = barrel_diameter);
                translate([0, 0, -epsilon])
                    cylinder(h = length + 2 * epsilon, d = barrel_bore_diameter);
            }
}

module left_barrels() {
    barrel_segment(-barrel_length / 2, left_outer_barrel_length);
    barrel_segment(barrel_length / 2 - left_outer_barrel_length, left_outer_barrel_length);
}

module right_barrel() {
    barrel_segment(-right_center_barrel_length / 2, right_center_barrel_length);
}

module left_hinge() {
    translate([0, -(hinge_gap / 2 + left_hinge_gap_offset), 0])
        union() {
            leaf_plate(left_leaf_y, left_leaf_width, left_leaf_length, left_leaf_thickness, left_leaf_rounding, left_hole_y);
            left_barrels();
        }
}

module right_hinge() {
    translate([0, hinge_gap / 2 + right_hinge_gap_offset, 0])
        union() {
            leaf_plate(right_leaf_y, right_leaf_width, right_leaf_length, right_leaf_thickness, right_leaf_rounding, right_hole_y);
            right_barrel();
        }
}

module spacer() {
    translate([spacer_x_start, 0, 0])
        rotate([0, 90, 0])
            union() {
                cylinder(h = spacer_length - spacer_head_length, d = spacer_diameter);
                translate([0, 0, spacer_length - spacer_head_length])
                    cylinder(h = spacer_head_length, d = spacer_head_diameter);
                cylinder(h = spacer_tip_length, d = spacer_tip_diameter);
            }
}

module cap() {
    translate([cap_x_start - pin_end_gap, 0, 0])
        rotate([0, 90, 0])
            difference() {
                cylinder(h = cap_length, d = cap_diameter);
                translate([0, 0, cap_length - cap_socket_depth])
                    cylinder(h = cap_socket_depth + epsilon, d = cap_socket_diameter);
            }
}

module hinge_assembly() {
    left_hinge();
    right_hinge();
    spacer();
    cap();
}

module hinge_exploded() {
    translate([0, -exploded_spacing, 0])
        left_hinge();
    translate([0, exploded_spacing, 0])
        right_hinge();
    translate([0, 0, exploded_spacing])
        spacer();
    translate([0, 0, -exploded_spacing])
        cap();
}

if (show_part == "exploded") {
    hinge_exploded();
} else if (show_part == "left_hinge") {
    left_hinge();
} else if (show_part == "right_hinge") {
    right_hinge();
} else if (show_part == "spacer") {
    spacer();
} else if (show_part == "cap") {
    cap();
} else {
    hinge_assembly();
}
