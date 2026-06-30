/*
  Fiber box recreation - first OpenSCAD pass
  Based on the two reference screenshots. Dimensions are approximate.
  Units: mm

  Suggested workflow:
  1) Open this in OpenSCAD.
  2) Press F5 Preview.
  3) Adjust the dimension variables below.
  4) Set SHOW = "assembly", "body", "lid", or "hardware" for export.
*/

$fn = 56;
SHOW = "assembly";     // "assembly", "body", "lid", "hardware"

// -------------------- main dimensions --------------------
body_len = 145;
body_w   = 78;
body_h   = 28;
wall     = 4;
corner_r = 8;

floor_th = 3;
lip_w    = 4;
lip_h    = 2.0;
gasket_w = 1.4;
gasket_h = 1.2;

lid_len  = 145;
lid_w    = 78;
lid_th   = 4;
lid_r    = 8;

screw_d        = 3.2;   // clearance for M3
screw_head_d   = 6.2;   // visual countersink/counterbore
screw_edge_x   = 9;
screw_edge_y   = 8;

explode_gap = 24;

// SC/front connector holder dimensions - adjust later
front_bay_h = 14;
front_bay_y = -body_w/2 - 7;
front_bay_w = 56;
front_bay_d = 15;

// -------------------- utility modules --------------------
module rounded_rect_2d(l, w, r) {
    offset(r=r)
        square([l - 2*r, w - 2*r], center=true);
}

module rounded_prism(l, w, h, r) {
    linear_extrude(height=h)
        rounded_rect_2d(l, w, r);
}

module hole_cyl(d, h=80) {
    cylinder(d=d, h=h, center=true);
}

module slot_rounded(l, w, h=20) {
    hull() {
        translate([-l/2 + w/2,0,0]) cylinder(d=w, h=h, center=true);
        translate([ l/2 - w/2,0,0]) cylinder(d=w, h=h, center=true);
    }
}

module screw_positions(l, w) {
    // 8 perimeter screws, matching the general layout in the screenshots
    for (x=[-l/2+screw_edge_x, l/2-screw_edge_x])
        for (y=[-w/2+screw_edge_y, w/2-screw_edge_y])
            translate([x,y,0]) children();
    for (x=[-l/2+40, 0, l/2-40]) {
        translate([x, -w/2+screw_edge_y,0]) children();
        translate([x,  w/2-screw_edge_y,0]) children();
    }
}

module small_standoff(x,y,h=8,d=8,hole=3.2) {
    translate([x,y,floor_th])
    difference() {
        rounded_prism(d,d,h,1.5);
        translate([0,0,h/2]) hole_cyl(hole, h+2);
    }
}

module rectangular_post(x,y,l=10,w=6,h=7) {
    translate([x,y,floor_th]) rounded_prism(l,w,h,1.2);
}

// -------------------- body --------------------
module body_shell() {
    difference() {
        union() {
            // outer box shell
            rounded_prism(body_len, body_w, body_h, corner_r);

            // raised top lip/gasket land
            translate([0,0,body_h])
                rounded_prism(body_len - 9, body_w - 9, lip_h, corner_r - 3);
        }

        // open inner cavity
        translate([0,0,floor_th])
            rounded_prism(body_len - 2*wall, body_w - 2*wall, body_h + lip_h + 2, corner_r - wall);

        // inner recessed top channel around lip
        translate([0,0,body_h + 0.4])
            rounded_prism(body_len - 2*(wall+lip_w), body_w - 2*(wall+lip_w), lip_h + 2, corner_r - wall - 2);

        // screw holes through rim
        screw_positions(body_len, body_w)
            translate([0,0,body_h/2]) hole_cyl(screw_d, body_h + 8);

        // front rectangular wiring/connector opening
        translate([0, -body_w/2 - 0.5, 12])
            cube([42, 10, 15], center=true);

        // side cable relief slot on right wall
        translate([body_len/2 - 1.5, 15, 15])
            rotate([90,0,0]) slot_rounded(28, 6, 8);
    }

    // interior posts/clips visible in the screenshot
    rectangular_post(-45, 23, 9, 6, 5);
    rectangular_post( 38, 24, 9, 6, 5);
    rectangular_post(-53,-14, 9, 6, 5);
    rectangular_post( 48,-17, 9, 6, 5);
    rectangular_post(  0,-26, 10, 6, 5);
    rectangular_post( 18,  3,  12, 7, 7);

    // center upright splice/clip-like bracket
    translate([22,0,floor_th])
    difference() {
        union() {
            rounded_prism(12,8,12,1.4);
            translate([0,0,12]) rotate([0,18,0]) rounded_prism(12,3,10,0.8);
        }
        translate([0,-4,7]) rotate([90,0,0]) hole_cyl(3.2, 10);
    }

    // small side mounting feet/tabs between lid and body
    for (x=[-48, 0, 48])
        translate([x, -body_w/2 - 9, 0])
            tab_with_slot();

    // front SC connector holder bay
    translate([0, front_bay_y, 0]) connector_holder();
}

module tab_with_slot() {
    difference() {
        rounded_prism(15,12,6,2.5);
        translate([0,0,3]) rotate([0,0,0]) slot_rounded(8,4,10);
    }
}

module connector_holder() {
    // Base shelf and front molded block, approximate to reference
    union() {
        translate([0,0,3]) rounded_prism(front_bay_w + 16, front_bay_d, 6, 2.5);
        translate([0,2,9]) rounded_prism(front_bay_w, 10, front_bay_h, 2);

        // side ears
        translate([-front_bay_w/2 - 7,0,5]) rounded_prism(8,13,10,2);
        translate([ front_bay_w/2 + 7,0,5]) rounded_prism(8,13,10,2);
    }

    // cutouts in visible holder block
    difference() {
        translate([0,-0.2,9.2]) rounded_prism(front_bay_w+0.1, 4.2, front_bay_h+0.1, 1);
        for (x=[-20,-10,10,20])
            translate([x,-2,9]) cube([3,8,10], center=true);
    }

    // circular front relief hole on shelf
    difference() {
        translate([0,-5,6.3]) cube([front_bay_w+14, 1, 0.1], center=true);
        translate([0,-5,6.3]) rotate([90,0,0]) hole_cyl(10, 3);
    }
}

// -------------------- lid --------------------
module lid_plate() {
    difference() {
        union() {
            rounded_prism(lid_len, lid_w, lid_th, lid_r);

            // raised/recessed gasket ribs on inside face
            translate([0,0,lid_th])
                rounded_prism(lid_len - 16, lid_w - 16, 1.0, lid_r - 5);
            translate([0,0,lid_th + 0.9])
                rounded_prism(lid_len - 22, lid_w - 22, 1.0, lid_r - 7);
        }

        // center recessed visual panel area
        translate([0,0,lid_th + 0.4])
            rounded_prism(lid_len - 27, lid_w - 27, 3, lid_r - 7);

        // screw holes and head pockets
        screw_positions(lid_len, lid_w) {
            translate([0,0,lid_th/2]) hole_cyl(screw_d, lid_th + 10);
            translate([0,0,lid_th + 0.15]) cylinder(d=screw_head_d, h=1.2, center=true);
        }

        // two front semicircular cable exits matching the screenshot's lid edge
        for (x=[-32, 32])
            translate([x, -lid_w/2, lid_th/2]) rotate([90,0,0]) cylinder(d=16, h=12, center=true);
    }

    // two raised U-channel towers near cable exits
    for (x=[-32,32])
        translate([x, -lid_w/2 + 7, lid_th])
            u_channel_tower();
}

module u_channel_tower() {
    difference() {
        rounded_prism(15,13,16,2);
        translate([0,-2,8]) rotate([90,0,0]) cylinder(d=11, h=18, center=true);
        translate([0,-6,8]) cube([12,16,18], center=true);
    }
}

// -------------------- loose hinge/clamp blocks --------------------
module clamp_hardware() {
    // long clamp with two screw holes
    translate([0,0,0])
    difference() {
        rounded_prism(18,42,8,3);
        translate([0,-13,4]) hole_cyl(3.2, 12);
        translate([0, 13,4]) hole_cyl(3.2, 12);
        translate([0,0,8]) rounded_prism(16,18,3,2);
    }

    // four smaller slotted tabs
    for (i=[0:3]) {
        x = (i < 2) ? -28 : 28;
        y = (i % 2 == 0) ? -28 : 28;
        translate([x,y,0]) tab_with_slot();
    }
}

// -------------------- layout/export selector --------------------
module assembly() {
    translate([0,0,0]) body_shell();
    translate([-body_len - explode_gap, 0, 0]) lid_plate();
    translate([-body_len/2 - explode_gap/2, 0, 0]) clamp_hardware();
}

if (SHOW == "body") {
    body_shell();
} else if (SHOW == "lid") {
    lid_plate();
} else if (SHOW == "hardware") {
    clamp_hardware();
} else {
    assembly();
}
