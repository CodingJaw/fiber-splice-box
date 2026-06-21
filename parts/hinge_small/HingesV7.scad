// Small hinge, version 7.
//
// Procedural OpenSCAD recreation of the hinge set from:
//   Hinge_small_L.stl
//   Hinge_small_R.stl
//   Hinge_small_Sp.stl
//   Hinge_small_Cap.stl
//   Hinges_small_v2.blend1
//
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

/* [Common Barrel and Pin] */

barrel_diameter = 13.72;
barrel_total_length = 35;
barrel_bore_diameter = 6.7;
barrel_clearance_gap = 0.7;

/* [Left Hinge Object] */

left_leaf_width = 35;
left_leaf_length = 42;
left_leaf_thickness = 3.5;
left_leaf_corner_radius = 7.5;
left_leaf_y_start = -42;
left_mount_hole_y = -35;
left_outer_barrel_length = 7.5;

/* [Right Hinge Object] */

right_leaf_width = 35;
right_leaf_length = 42;
right_leaf_thickness = 3.5;
right_leaf_corner_radius = 7.5;
right_leaf_y_start = 0;
right_mount_hole_y = 35;
right_center_barrel_length = 19.5;

/* [Spacer Object] */

spacer_shaft_diameter = 12.6;
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

module leaf_plate(y_start, width, length, thickness, radius, hole_y) {
    difference() {
        translate([0, y_start, -barrel_diameter / 2])
            linear_extrude(height = thickness)
                rounded_leaf_2d(width, length, radius);

        countersunk_mounting_hole(-mount_hole_spacing / 2, hole_y, thickness);
        countersunk_mounting_hole(mount_hole_spacing / 2, hole_y, thickness);
    }
}

module barrel_segment(x_start, length) {
    translate([x_start, 0, 0])
        rotate([0, 90, 0])
            difference() {
                cylinder(h = length, d = barrel_diameter);
                translate([0, 0, -epsilon])
                    cylinder(h = length + 2 * epsilon, d = barrel_bore_diameter);
            }
}

module left_hinge_object() {
    translate([0, -assembled_gap / 2, 0])
        union() {
            leaf_plate(
                left_leaf_y_start,
                left_leaf_width,
                left_leaf_length,
                left_leaf_thickness,
                left_leaf_corner_radius,
                left_mount_hole_y
            );
            barrel_segment(-barrel_total_length / 2, left_outer_barrel_length);
            barrel_segment(barrel_total_length / 2 - left_outer_barrel_length, left_outer_barrel_length);
        }
}

module right_hinge_object() {
    translate([0, assembled_gap / 2, 0])
        union() {
            leaf_plate(
                right_leaf_y_start,
                right_leaf_width,
                right_leaf_length,
                right_leaf_thickness,
                right_leaf_corner_radius,
                right_mount_hole_y
            );
            barrel_segment(-right_center_barrel_length / 2, right_center_barrel_length);
        }
}

module spacer_object() {
    translate([spacer_x_start, 0, 0])
        rotate([0, 90, 0])
            difference() {
                union() {
                    cylinder(h = spacer_shaft_length, d = spacer_shaft_diameter);
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
