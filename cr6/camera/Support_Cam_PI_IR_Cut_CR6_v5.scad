// Support_Cam_PI_IR_Cut_CR6_v5.scad
// Left CR-6 Pi IR-cut camera support bracket, rebuilt parametrically.
//
// This attempt intentionally focuses on the LEFT bracket only.  It does not
// import the STL.  v5 refines the lower printer foot and camera mounting hole
// from measured source-STL vertices while keeping the model parametric.

/* [Left Bracket Dimensions] */
base_z = 0;
base_thickness = 12;
diagonal_arm_width = 18;
diagonal_arm_start = [0, 16];
diagonal_arm_end = [34, 46];
camera_tab_origin = [30, 40, 0];
camera_tab_size = [52, 20, 12];
camera_hole_xy = [64.8, 50.412];
camera_hole_diameter = 4.05;
lower_foot_points = [[-8.407, 22.229], [-17.6, 13.036], [-3.458, -1.106], [5.735, 8.086]];

/* [Tower] */
tower_origin = [-17.6, 2, 12];
tower_bottom_size = [24.6, 22];
tower_top_size = [15, 14];
tower_height = 70;
tower_hole_y = 13;
tower_hole_z = 73;
tower_hole_diameter = 4.2;

/* [Preview] */
preview_color = true;
$fn = 72;

module maybe_color() {
    if (preview_color) color("palegreen") children();
    else children();
}

module bar_between(a, b, width, height) {
    hull() {
        translate([a[0], a[1], base_z]) cylinder(h = height, d = width);
        translate([b[0], b[1], base_z]) cylinder(h = height, d = width);
    }
}

module rounded_rect(size, radius = 1.5) {
    hull() {
        for (x = [radius, size[0] - radius])
            for (y = [radius, size[1] - radius])
                translate([x, y, 0]) cylinder(h = size[2], r = radius);
    }
}

module tapered_tower(origin, bottom_size, top_size, height) {
    bx = bottom_size[0];
    by = bottom_size[1];
    tx = top_size[0];
    ty = top_size[1];
    ox = (bx - tx) / 2;
    oy = (by - ty) / 2;

    translate(origin)
        polyhedron(
            points = [
                [0, 0, 0], [bx, 0, 0], [bx, by, 0], [0, by, 0],
                [ox, oy, height], [ox + tx, oy, height], [ox + tx, oy + ty, height], [ox, oy + ty, height]
            ],
            faces = [
                [0, 1, 2, 3], [4, 7, 6, 5],
                [0, 4, 5, 1], [1, 5, 6, 2],
                [2, 6, 7, 3], [3, 7, 4, 0]
            ]
        );
}

module tower_with_hole() {
    difference() {
        tapered_tower(tower_origin, tower_bottom_size, tower_top_size, tower_height);
        translate([tower_origin[0] + tower_bottom_size[0] / 2, tower_hole_y, tower_hole_z])
            rotate([90, 0, 0])
                cylinder(h = tower_bottom_size[1] + 4, d = tower_hole_diameter, center = true);
    }
}

module camera_tab() {
    difference() {
        translate(camera_tab_origin) rounded_rect(camera_tab_size, 1.5);
        translate([camera_hole_xy[0], camera_hole_xy[1], camera_tab_origin[2] - 0.5])
            cylinder(h = camera_tab_size[2] + 1, d = camera_hole_diameter);
    }
}

module lower_foot() {
    translate([0, 0, base_z])
        linear_extrude(height = base_thickness)
            polygon(points = lower_foot_points);
}


module left_bracket() {
    maybe_color()
        union() {
            // Continuous lower assembly: measured lower foot, diagonal arm, camera tab, and tower pad overlap.
            lower_foot();
            bar_between(diagonal_arm_start, diagonal_arm_end, diagonal_arm_width, base_thickness);
            camera_tab();
            translate([tower_origin[0], tower_origin[1], base_z])
                rounded_rect([tower_bottom_size[0], tower_bottom_size[1], base_thickness], 1.2);

            // The measured left STL has a tall tapered upright directly on the tower pad.
            tower_with_hole();
        }
}

left_bracket();
