// Parametric small hinge, version 2.
//
// Units are millimeters.  Change `show_part` to render the whole hinge or one
// part at a time for export/printing.

$fn = 96;

// Part selector:
//   "assembly", "exploded", "left_hinge", "right_hinge",
//   "left_leaf", "right_leaf", "left_barrels", "right_barrel", "pin"
show_part = "assembly";
exploded_spacing = 18;

// Left hinge leaf parameters.
left_hinge_width = 17.5;
left_hinge_length = 42;
left_hinge_thickness = 3.5;

// Right hinge leaf parameters.
right_hinge_width = 17.5;
right_hinge_length = 42;
right_hinge_thickness = 3.5;

// Barrel parameters shared by both hinge leaves.
barrel_width = 12.6;        // Outside barrel diameter across X.
barrel_length = 42;         // Total hinge barrel span along Y.
barrel_thickness = 12.6;    // Outside barrel diameter across Z.
barrel_clearance = 0.35;    // Extra radial clearance around the pin hole.
barrel_gap = 1.0;           // Axial gap between neighboring barrel knuckles.

// Hinge pin parameters.
pin_width = 2.4;            // Pin diameter across X.
pin_thickness = 2.4;        // Pin diameter across Z.
pin_length = barrel_length + 4;
pin_overhang = (pin_length - barrel_length) / 2;
pin_clearance = 0.15;       // Extra clearance to subtract from barrel holes.

// Small overlap to avoid coincident faces in boolean operations.
epsilon = 0.01;

module elliptical_cylinder_y(length, width, thickness) {
    rotate([-90, 0, 0])
        scale([width, thickness, 1])
            cylinder(h = length, d = 1, center = false);
}

module hinge_pin(length = pin_length, width = pin_width, thickness = pin_thickness) {
    translate([0, -pin_overhang, 0])
        elliptical_cylinder_y(length, width, thickness);
}

module barrel_knuckle(y_start, length) {
    difference() {
        translate([0, y_start, 0])
            elliptical_cylinder_y(length, barrel_width, barrel_thickness);

        translate([0, y_start - epsilon, 0])
            elliptical_cylinder_y(
                length + 2 * epsilon,
                pin_width + 2 * (pin_clearance + barrel_clearance),
                pin_thickness + 2 * (pin_clearance + barrel_clearance)
            );
    }
}

module left_leaf() {
    translate([-left_hinge_width, 0, -left_hinge_thickness / 2])
        cube([left_hinge_width, left_hinge_length, left_hinge_thickness], center = false);
}

module right_leaf() {
    translate([0, 0, -right_hinge_thickness / 2])
        cube([right_hinge_width, right_hinge_length, right_hinge_thickness], center = false);
}

module left_barrels() {
    knuckle_length = (barrel_length - 2 * barrel_gap) / 3;

    barrel_knuckle(0, knuckle_length);
    barrel_knuckle(2 * knuckle_length + 2 * barrel_gap, knuckle_length);
}

module right_barrel() {
    knuckle_length = (barrel_length - 2 * barrel_gap) / 3;

    barrel_knuckle(knuckle_length + barrel_gap, knuckle_length);
}

module left_hinge() {
    union() {
        left_leaf();
        left_barrels();
    }
}

module right_hinge() {
    union() {
        right_leaf();
        right_barrel();
    }
}

module hinge_assembly(show_pin = true) {
    left_hinge();
    right_hinge();

    if (show_pin) {
        hinge_pin();
    }
}

module hinge_exploded() {
    translate([-exploded_spacing, 0, 0])
        left_hinge();

    translate([exploded_spacing, 0, 0])
        right_hinge();

    translate([0, 0, exploded_spacing])
        hinge_pin();
}

if (show_part == "exploded") {
    hinge_exploded();
} else if (show_part == "left_hinge") {
    left_hinge();
} else if (show_part == "right_hinge") {
    right_hinge();
} else if (show_part == "left_leaf") {
    left_leaf();
} else if (show_part == "right_leaf") {
    right_leaf();
} else if (show_part == "left_barrels") {
    left_barrels();
} else if (show_part == "right_barrel") {
    right_barrel();
} else if (show_part == "pin") {
    hinge_pin();
} else {
    hinge_assembly();
}
