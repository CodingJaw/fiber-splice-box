// v1-20: 6 mm thick nut for a 1/4-20 bolt.
// Units: millimeters. The nut bottom face sits flat on the build plate at Z=0.

$fn = 96;

inch = 25.4;
bolt_major_diameter = 0.25 * inch;      // 1/4 inch nominal major diameter
threads_per_inch = 20;
thread_pitch = inch / threads_per_inch; // 20 TPI = 1.27 mm pitch

nut_thickness = 6;
nut_width_across_flats = 11;
clearance = 0.25;
nut_thread_clearance = 0.20;

// 1/4-20 UNC external minor diameter is about 0.1887-0.1959 in.
// The cutter is enlarged slightly so printed bolt and nut parts can fit.
bolt_minor_diameter = 4.90;
thread_segments_per_turn = 48;
thread_angular_segments = 96;

function frac(x) = x - floor(x);
function tri_wave(x) = 1 - abs(2 * frac(x) - 1);
function thread_radius(major_diameter, minor_diameter, pitch, z, angle) =
    minor_diameter / 2 + ((major_diameter - minor_diameter) / 2) * tri_wave((z / pitch) - (angle / 360));
function thread_vertex_index(z_step, angle_step, angular_segments) =
    z_step * angular_segments + angle_step;

module hex_prism(width_across_flats, height) {
    cylinder(h = height, r = width_across_flats / sqrt(3), $fn = 6);
}

module unc_thread_solid(major_diameter, minor_diameter, length, pitch) {
    z_steps = ceil(length / pitch * thread_segments_per_turn);
    angular_segments = thread_angular_segments;
    bottom_center = (z_steps + 1) * angular_segments;
    top_center = bottom_center + 1;

    vertices = concat(
        [
            for (z_step = [0:z_steps])
                for (angle_step = [0:angular_segments - 1])
                    let(
                        z = length * z_step / z_steps,
                        angle = 360 * angle_step / angular_segments,
                        radius = thread_radius(major_diameter, minor_diameter, pitch, z, angle)
                    )
                    [radius * cos(angle), radius * sin(angle), z]
        ],
        [[0, 0, 0], [0, 0, length]]
    );

    outer_faces = [
        for (z_step = [0:z_steps - 1])
            for (angle_step = [0:angular_segments - 1])
                [
                    thread_vertex_index(z_step, angle_step, angular_segments),
                    thread_vertex_index(z_step, (angle_step + 1) % angular_segments, angular_segments),
                    thread_vertex_index(z_step + 1, (angle_step + 1) % angular_segments, angular_segments),
                    thread_vertex_index(z_step + 1, angle_step, angular_segments)
                ]
    ];

    bottom_faces = [
        for (angle_step = [0:angular_segments - 1])
            [
                bottom_center,
                thread_vertex_index(0, (angle_step + 1) % angular_segments, angular_segments),
                thread_vertex_index(0, angle_step, angular_segments)
            ]
    ];

    top_faces = [
        for (angle_step = [0:angular_segments - 1])
            [
                top_center,
                thread_vertex_index(z_steps, angle_step, angular_segments),
                thread_vertex_index(z_steps, (angle_step + 1) % angular_segments, angular_segments)
            ]
    ];

    polyhedron(points = vertices, faces = concat(outer_faces, bottom_faces, top_faces), convexity = 10);
}

module threaded_hole_cutter(major_diameter, minor_diameter, length, pitch) {
    translate([0, 0, -pitch])
        unc_thread_solid(major_diameter, minor_diameter, length + 2 * pitch, pitch);
}

module quarter_20_nut() {
    difference() {
        hex_prism(nut_width_across_flats, nut_thickness);

        threaded_hole_cutter(
            bolt_major_diameter + clearance,
            bolt_minor_diameter + clearance + nut_thread_clearance,
            nut_thickness,
            thread_pitch
        );
    }
}

quarter_20_nut();
