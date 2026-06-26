// Combined front plate and full GoPro two-blade mount, modeled with editable CSG primitives.
// Created as v2 to use the full gopro_mount_2blade_v1.scad proportions, not the thin two-blade variant.
// The model intentionally does not import STL files or reuse mesh polyhedra.

$fn = 96;

plate_size = [39, 39, 2.0];
plate_corner_radius = 1.0;
mounting_hole_diameter = 5.2;
mounting_hole_x_offset = 12.5;
mounting_hole_y_offset = 0;

mount_width = 15.0;
mount_depth = 15.0;
mount_height = 25.0;
// Full two-blade mount proportions: 5.5 + 4.0 + 5.5 = 15mm total depth, matching gopro_mount_2blade_v1.scad rather than the thin version.
ear_thickness = 5.5;
ear_gap = 4.0;
ear_radius = mount_width / 2;
pivot_hole_diameter = 5.2;
pivot_hole_z = 17.5;
base_height = 8.0;
fillet_radius = 1.2;

module rounded_square_2d(size, radius) {
    offset(r = radius)
        square([size[0] - 2 * radius, size[1] - 2 * radius], center = true);
}

module rounded_plate() {
    linear_extrude(height = plate_size[2])
        rounded_square_2d([plate_size[0], plate_size[1]], plate_corner_radius);
}

module front_plate() {
    difference() {
        rounded_plate();
        for (x = [-mounting_hole_x_offset, mounting_hole_x_offset]) {
            translate([x, mounting_hole_y_offset, -0.2])
                cylinder(h = plate_size[2] + 0.4, d = mounting_hole_diameter);
        }
    }
}

module ear_profile_2d() {
    // A GoPro-style upright: flat lower stem with a semicircular top.
    hull() {
        translate([0, base_height])
            square([mount_width, 0.01], center = true);
        translate([0, mount_height - ear_radius])
            circle(r = ear_radius);
    }
    translate([0, base_height / 2])
        square([mount_width, base_height], center = true);
}

module gopro_ear(y_offset) {
    translate([0, y_offset - ear_thickness / 2, plate_size[2] - 0.05])
        rotate([90, 0, 0])
            linear_extrude(height = ear_thickness)
                difference() {
                    ear_profile_2d();
                    translate([0, pivot_hole_z])
                        circle(d = pivot_hole_diameter);
                }
}

module saddle_base() {
    translate([0, 0, plate_size[2] + base_height / 2 - 0.05])
        hull() {
            translate([0, -mount_depth / 2 + fillet_radius, 0])
                cube([mount_width, fillet_radius * 2, base_height + 0.1], center = true);
            translate([0, mount_depth / 2 - fillet_radius, 0])
                cube([mount_width, fillet_radius * 2, base_height + 0.1], center = true);
        }
}

module gopro_two_blade_mount() {
    union() {
        saddle_base();
        for (y = [-(ear_gap / 2 + ear_thickness / 2), ear_gap / 2 + ear_thickness / 2])
            gopro_ear(y);
    }
}

module front_plate_gopro_mount_v2() {
    union() {
        front_plate();
        gopro_two_blade_mount();
    }
}

front_plate_gopro_mount_v2();
