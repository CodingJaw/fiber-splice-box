// Parametric CR6 front base plate rebuilt in editable OpenSCAD.
// Dropdown-only options for hole pattern and plate thickness.

/* [Plate Options] */
plate_hole_mode = 2; // [0:Left diagonal, 1:Right diagonal, 2:All four holes]
base_plate_thickness = 2.0; // [1.5:1.5mm, 2.0:2.0mm, 2.5:2.5mm, 3.0:3.0mm, 4.0:4.0mm]

plate_size = [39.01, 39.0];
plate_corner_radius = 1.0;
mounting_hole_diameter = 5.0;

left_diagonal_holes = [[10.440278, -10.586206], [-9.738590, 9.834044]];
right_diagonal_holes = [[-10.440278, -10.586206], [9.738590, 9.834044]];
all_holes = concat(left_diagonal_holes, right_diagonal_holes);

function selected_holes(mode) = mode == 2 ? all_holes : mode == 1 ? right_diagonal_holes : left_diagonal_holes;

module rounded_square(size, radius) {
    offset(r = radius)
        square([size[0] - 2 * radius, size[1] - 2 * radius], center = true);
}

module front_plate_base_v1(hole_mode = plate_hole_mode, thickness = base_plate_thickness) {
    difference() {
        linear_extrude(height = thickness)
            rounded_square(plate_size, plate_corner_radius);

        for (hole = selected_holes(hole_mode)) {
            translate([hole[0], hole[1], -0.1])
                cylinder(d = mounting_hole_diameter, h = thickness + 0.2, $fn = 64);
        }
    }
}

front_plate_base_v1();
