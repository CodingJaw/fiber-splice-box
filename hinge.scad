// Parametric mirrored hinge for the fiber splice box.
// Dimensions are in millimeters.

$fn = 72;

leaf_size = 20;          // Each hinge leaf is 20 mm x 20 mm.
leaf_thickness = 6;      // Leaf and barrel outside diameter are 6 mm thick.
barrel_diameter = 6;
pin_diameter = 2.4;
barrel_gap = 1;

module leaf(side = -1) {
    // side -1 = left leaf, side 1 = mirrored right leaf.
    x0 = side < 0 ? -leaf_size : 0;

    translate([x0, 0, 0])
        cube([leaf_size, leaf_size, leaf_thickness], center = false);
}

module barrel_segment(y_start, y_len) {
    // Barrel axis follows the 20 mm edge of each leaf.
    translate([0, y_start, leaf_thickness / 2])
        rotate([-90, 0, 0])
            difference() {
                cylinder(h = y_len, d = barrel_diameter);
                translate([0, 0, -0.1])
                    cylinder(h = y_len + 0.2, d = pin_diameter);
            }
}

module left_leaf_with_barrels() {
    leaf(-1);

    // Outer knuckles on the described side.
    barrel_segment(0, 7 - barrel_gap / 2);
    barrel_segment(13 + barrel_gap / 2, 7 - barrel_gap / 2);
}

module right_leaf_with_barrels() {
    mirror([1, 0, 0])
        leaf(-1);

    // Mirrored side with the barrel shifted into the open center gap.
    barrel_segment(7 + barrel_gap / 2, 6 - barrel_gap);
}

module hinge() {
    left_leaf_with_barrels();
    right_leaf_with_barrels();
}

hinge();
