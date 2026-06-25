// Support_Cam_PI_IR_Cut_CR6_v2.scad
// Parametric CR-6 Pi IR-cut camera support brackets.
//
// v2 intentionally does not import or reuse the STL meshes.  The original STL
// files were only measured to set the default dimensions and to validate the
// generated bounding boxes.  Choose Left, Right, or Both in OpenSCAD Customizer.

/* [Bracket Selection] */
bracket = "Right"; // [Right, Left, Both]

/* [General Dimensions] */
base_height = 12;
base_thickness_z = 12;
arm_width = 14;
plate_thickness = 7;
tower_height = 70;
tower_width = 24;
tower_depth = 22;
rib_thickness = 3;
corner_radius = 2;
$fn = 48;

/* [Mounting Holes] */
camera_hole_diameter = 5.2;
tower_hole_diameter = 4.2;
hole_clearance_z = 0.2;

/* [Preview] */
both_spacing = 18; // [0:1:100]
preview_colors = true;

module maybe_color(name) {
    if (preview_colors && name == "Right") color("lightsteelblue") children();
    else if (preview_colors && name == "Left") color("palegreen") children();
    else children();
}

module rounded_box(size, radius = 1) {
    hull() {
        for (x = [radius, size[0] - radius])
            for (y = [radius, size[1] - radius])
                translate([x, y, 0]) cylinder(h = size[2], r = radius);
    }
}

module bar_between(a, b, width, height) {
    hull() {
        translate([a[0], a[1], 0]) cylinder(h = height, d = width);
        translate([b[0], b[1], 0]) cylinder(h = height, d = width);
    }
}

module vertical_tower(pos, size, hole_y, hole_z) {
    difference() {
        translate(pos) rounded_box(size, corner_radius);
        translate([pos[0] + size[0] / 2, hole_y, hole_z])
            rotate([90, 0, 0])
                cylinder(h = size[1] + 2, d = tower_hole_diameter, center = true);
    }

    // Small cap ribs on the outside face keep this parametric and printable without STL mesh reuse.
    translate([pos[0] + size[0] - 0.4, pos[1] + 2, pos[2] + 6])
        cube([rib_thickness, size[1] - 4, 3]);
    translate([pos[0] + size[0] - 0.4, pos[1] + 2, pos[2] + size[2] - 9])
        cube([rib_thickness, size[1] - 4, 3]);
}

module camera_plate(pos, size, hole_xy) {
    difference() {
        translate(pos) rounded_box(size, corner_radius);
        translate([hole_xy[0], hole_xy[1], pos[2] - hole_clearance_z])
            cylinder(h = size[2] + hole_clearance_z * 2, d = camera_hole_diameter);
    }
}

module right_bracket_raw() {
    difference() {
        union() {
            // Long lower arm and the rounded clamp lobe visible on the right STL.
            translate([-22, -18, 3]) rounded_box([75, 12, base_thickness_z], corner_radius);
            translate([-17, -13, 3]) cylinder(h = base_thickness_z, d = 20);
            translate([-25, -18, 3]) rotate([0, 0, -25]) rounded_box([14, 10, base_thickness_z], corner_radius);

            // Upright printer-side tower.
            vertical_tower([-9, -22, 15], [24, tower_depth, tower_height], -11, 73);

            // Camera mounting tab.
            camera_plate([27, -7, 15], [25, 30, plate_thickness], [39.5, 8]);

            // Low upper brace between tower and camera tab.
            hull() {
                translate([5, -17, 18]) cube([8, 4, 4]);
                translate([32, -7, 18]) cube([8, 4, 4]);
            }
        }
    }
}

module left_bracket_raw() {
    union() {
        // Diagonal arm and horizontal camera tab measured from the left STL top view.
        translate([0, 0, 0]) bar_between([-8, 8], [30, 43], arm_width, base_thickness_z);
        translate([24, 41, 0]) rounded_box([58, 15, base_thickness_z], corner_radius);

        // Printer-side tower and end block.
        vertical_tower([-17, 2, 12], [24, tower_depth, tower_height], 13, 73);
        translate([-11, 3, 0]) rotate([0, 0, 45]) rounded_box([12, 12, base_thickness_z], corner_radius);

        // Camera hole in the horizontal tab.
        difference() {
            translate([50, 42, 0]) rounded_box([31, 18, plate_thickness], corner_radius);
            translate([64, 51, -hole_clearance_z])
                cylinder(h = plate_thickness + hole_clearance_z * 2, d = camera_hole_diameter);
        }
    }
}

module right_bracket() { maybe_color("Right") right_bracket_raw(); }
module left_bracket() { maybe_color("Left") left_bracket_raw(); }

module selected_bracket() {
    if (bracket == "Right") right_bracket();
    else if (bracket == "Left") left_bracket();
    else if (bracket == "Both") {
        translate([-60 - both_spacing / 2, 0, 0]) right_bracket();
        translate([35 + both_spacing / 2, 0, 0]) left_bracket();
    } else echo(str("Unknown bracket option: ", bracket));
}

selected_bracket();
