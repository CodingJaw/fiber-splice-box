/*
    Current Tray/Box Hinge - Standalone Extract
    -------------------------------------------
    This is the hinge style used with the current box:
      - Tray side uses the outer hinge barrels/ears.
      - Box side uses the inner blue V2 wedge barrels.
      - Hinge uses 1.75 mm filament/pin pieces through 2.20 mm holes.

    This is NOT the later opposed split-cylinder test hinge.

    Coordinate system:
      X = hinge / pin axis
      Y = tray depth direction
      Z = height

    Use module tray_side_hinge_ears_only() to attach the tray-side hinge to a tray.
    Use module box_side_v2_wedge_hinge_only() for the matching box-side hinge.
*/

$fn = 72;

// -------------------------
// VIEW / EXPORT CONTROL
// -------------------------
part = "preview"; // [preview, tray_hinge, box_hinge, pins, print_layout]

// -------------------------
// HINGE SETTINGS - CURRENT MATCHING SET
// -------------------------
hinge_layout = "tray_outer"; // [tray_outer, tray_inner]
// tray_outer: tray owns outer barrels; box side owns inner barrels. This is current.

filament_pin_d = 1.75;
pin_hole_d = 2.20;
knuckle_od = 6.5;
barrel_len = 10.0;
side_gap = 0.70;
center_access_gap = 15.0;

// Tray reference size from current imported tray setup.
actual_tray_w = 63.0;
tray_h = 8.0;
rear_edge_y = -actual_tray_w/2;

// Tray-side hinge placement.
barrel_edge_gap = 3.0;
solid_overlap = 1.50;
ear_anchor_h = 4.9;
ear_anchor_y = 1.5;
ear_flatten_back = true;
ear_flat_y_t = 2.0;
ear_flat_z = 6.0;

// Box-side V2 wedge profile.
wedge_anchor_y_t = 1.5;
wedge_anchor_z_h = 18.0;
wedge_wall_overlap = 0.55;
rear_hinge_clearance = 0.7;
bracket_direction = "behind"; // current reference orientation

// Optional preview tray edge plate.
show_preview_tray_edge = true;
preview_tray_l = 110.0;
preview_edge_plate_t = 1.2;

// -------------------------
// DERIVED GEOMETRY
// -------------------------
r = knuckle_od/2;
axis_y = rear_edge_y - barrel_edge_gap - r;
axis_z = tray_h/2;

barrel_back_y  = axis_y - r;
box_wall_inner_face_y = barrel_back_y - rear_hinge_clearance;
wedge_anchor_z_center = wedge_anchor_z_h/2;

hinge_span = 4*barrel_len + 2*side_gap + center_access_gap;

function barrel_x(i) =
    let(start = -hinge_span/2)
    i == 0 ? start + barrel_len/2 :
    i == 1 ? start + barrel_len + side_gap + barrel_len/2 :
    i == 2 ? start + 2*barrel_len + side_gap + center_access_gap + barrel_len/2 :
             start + 3*barrel_len + 2*side_gap + center_access_gap + barrel_len/2;

function tray_owns_barrel(i) =
    hinge_layout == "tray_outer" ? (i == 0 || i == 3) : (i == 1 || i == 2);

function wall_owns_barrel(i) = !tray_owns_barrel(i);

left_pin_len  = 2*barrel_len + side_gap + 2.0;
right_pin_len = 2*barrel_len + side_gap + 2.0;
left_pin_x  = (barrel_x(0) + barrel_x(1))/2;
right_pin_x = (barrel_x(2) + barrel_x(3))/2;

// -------------------------
// HELPERS
// -------------------------
module cyl_x(len, d, center=true) {
    rotate([0,90,0]) cylinder(h=len, d=d, center=center);
}

module pin_bore_cut(extra=20) {
    translate([0, axis_y, axis_z])
        cyl_x(hinge_span + extra, pin_hole_d, center=true);
}

// -------------------------
// TRAY-SIDE HINGE EARS
// -------------------------
module tray_hinge_ear(i) {
    x = barrel_x(i);
    union() {
        hull() {
            // Hinge barrel.
            translate([x, axis_y, axis_z])
                cyl_x(barrel_len, knuckle_od, center=true);

            // Small anchor bridge back to tray edge.
            translate([x, rear_edge_y + ear_anchor_y/2 - solid_overlap, axis_z])
                cube([barrel_len, ear_anchor_y + 2*solid_overlap, ear_anchor_h], center=true);

            // Flattened back pad against tray wall/edge.
            if (ear_flatten_back)
                translate([x, rear_edge_y - solid_overlap, axis_z])
                    cube([barrel_len, ear_flat_y_t, ear_flat_z], center=true);
        }

        translate([x, rear_edge_y + ear_anchor_y/2 - solid_overlap, axis_z])
            cube([barrel_len, ear_anchor_y + 2*solid_overlap, ear_anchor_h], center=true);

        if (ear_flatten_back)
            translate([x, rear_edge_y - solid_overlap, axis_z])
                cube([barrel_len, ear_flat_y_t, ear_flat_z], center=true);
    }
}

module tray_side_hinge_ears_only() {
    difference() {
        union() {
            for (i=[0:3])
                if (tray_owns_barrel(i))
                    tray_hinge_ear(i);
        }
        pin_bore_cut();
    }
}

// Optional tray edge preview only, useful for lining up before merging into real tray.
module tray_side_hinge_with_edge_preview() {
    difference() {
        union() {
            if (show_preview_tray_edge)
                translate([0, rear_edge_y + preview_edge_plate_t/2, axis_z])
                    cube([preview_tray_l, preview_edge_plate_t, tray_h], center=true);
            tray_side_hinge_ears_only();
        }
        pin_bore_cut();
    }
}

// -------------------------
// BOX-SIDE BLUE V2 WEDGE HINGE
// -------------------------
module v2_wedge_barrel_segment(i) {
    x = barrel_x(i);

    module solid_shape() {
        hull() {
            // Tall narrow anchor side.
            translate([x,
                       bracket_direction == "behind"
                           ? box_wall_inner_face_y - wedge_wall_overlap/2
                           : box_wall_inner_face_y + wedge_wall_overlap/2,
                       wedge_anchor_z_center])
                cube([barrel_len,
                      wedge_anchor_y_t + wedge_wall_overlap,
                      wedge_anchor_z_h], center=true);

            // Rounded hinge/barrel nose.
            translate([x, axis_y, axis_z])
                cyl_x(barrel_len, knuckle_od, center=true);
        }
    }

    difference() {
        solid_shape();
        translate([x, axis_y, axis_z])
            cyl_x(barrel_len + 3.0, pin_hole_d, center=true);
    }
}

module box_side_v2_wedge_hinge_only() {
    union() {
        for (i=[0:3])
            if (wall_owns_barrel(i))
                v2_wedge_barrel_segment(i);
    }
}

// -------------------------
// PIN VISUALS
// -------------------------
module filament_pins_visual() {
    translate([left_pin_x, axis_y, axis_z])
        cyl_x(left_pin_len, filament_pin_d, center=true);
    translate([right_pin_x, axis_y, axis_z])
        cyl_x(right_pin_len, filament_pin_d, center=true);
}

// -------------------------
// OUTPUTS
// -------------------------
module preview_assembled() {
    color("orange") tray_side_hinge_with_edge_preview();
    color("royalblue") box_side_v2_wedge_hinge_only();
    color("silver") filament_pins_visual();
}

module print_layout() {
    color("orange") translate([0, 30, 0]) tray_side_hinge_with_edge_preview();
    color("royalblue") translate([0, -30, 0]) box_side_v2_wedge_hinge_only();
    color("silver") translate([0, -60, 0]) filament_pins_visual();
}

if (part == "tray_hinge") {
    color("orange") tray_side_hinge_ears_only();
} else if (part == "box_hinge") {
    color("royalblue") box_side_v2_wedge_hinge_only();
} else if (part == "pins") {
    color("silver") filament_pins_visual();
} else if (part == "print_layout") {
    print_layout();
} else {
    preview_assembled();
}
