// 1/4-20 bolt, 1 inch long, with a 6 mm thick nut.
// Units: millimeters.

$fn = 96;

inch = 25.4;
bolt_major_diameter = 0.25 * inch;      // 1/4 inch
bolt_length = 1 * inch;                 // 1 inch
threads_per_inch = 20;
thread_pitch = inch / threads_per_inch; // 20 TPI
nut_thickness = 6;

head_diameter = 11;
head_height = 4;
nut_width_across_flats = 11;
clearance = 0.25;
thread_depth = 0.55;

module hex_prism(width_across_flats, height) {
    cylinder(h = height, r = width_across_flats / sqrt(3), $fn = 6);
}

module threaded_rod(major_diameter, length, pitch, depth) {
    union() {
        cylinder(h = length, d = major_diameter - depth);

        linear_extrude(height = length, twist = -360 * length / pitch, slices = ceil(length / pitch * 24))
            translate([major_diameter / 2 - depth / 2, 0, 0])
                circle(d = depth, $fn = 12);
    }
}

module quarter_20_bolt() {
    union() {
        translate([0, 0, -head_height])
            hex_prism(head_diameter, head_height);

        threaded_rod(bolt_major_diameter, bolt_length, thread_pitch, thread_depth);
    }
}

module quarter_20_nut() {
    difference() {
        hex_prism(nut_width_across_flats, nut_thickness);

        translate([0, 0, -0.1])
            cylinder(h = nut_thickness + 0.2, d = bolt_major_diameter + clearance);
    }
}

quarter_20_bolt();

translate([18, 0, 0])
    quarter_20_nut();
