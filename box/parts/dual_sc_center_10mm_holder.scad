/*
    Dual SC Connector Center-Flange Holder - 10 mm Clamp Version

    Purpose:
    - Holds two SC connector adapters using the centered side flange.
    - Holder body and lid only cover the center 10 mm of the SC adapters.
    - Both ends of each SC adapter remain exposed.
    - Lid is removable and secured by two screws.
    - Screw posts are built into the holder body and line up with the lid holes.

    Orientation:
      X = SC connector length / front-to-back
      Y = side-to-side across the pair of connectors
      Z = vertical

    Workflow:
      1. Remove lid.
      2. Drop/slide SC connector bodies into the narrow grooves.
      3. The centered side flanges sit in the wider center pockets.
      4. Install lid with two screws.

    Print notes:
    - PETG on CR-6 SE: start with the clearances below.
    - If too tight, increase body_clearance_y/z and flange_clearance_y/x by 0.10 mm.
    - If loose, reduce clearances by 0.05-0.10 mm.
*/

$fn = 72;

// -----------------------------
// Select output
// -----------------------------
part = "assembly";        // "assembly", "base", "lid", "mock"
show_mocks = true;
exploded_preview = true;

// -----------------------------
// SC connector dimensions
// -----------------------------
sc_l = 27.5;              // full SC adapter length, X
sc_w = 12.8;              // main body width, Y
sc_h = 9.3;               // main body height, Z

flange_total_w = 14.8;    // total width across side flanges, Y
flange_t = 2.5;           // flange thickness along X
side_flange_each = (flange_total_w - sc_w) / 2;

// -----------------------------
// Holder clamp dimensions
// -----------------------------
holder_l = 10.0;          // only the center 10 mm is covered
bottom_thick = 2.4;
lid_t = 2.2;

// close-fit clearances
body_clearance_y = 0.25;
body_clearance_z = 0.25;
flange_clearance_y = 0.30;
flange_clearance_x = 0.35;

// groove/pocket sizes
slot_w = sc_w + body_clearance_y;
slot_h = sc_h + body_clearance_z;
flange_pocket_w = flange_total_w + flange_clearance_y;
flange_pocket_l = flange_t + flange_clearance_x;

// walls and spacing
side_wall = 2.2;
center_wall = 3.0;
post_zone_w = 8.5;        // side zone for screw post at each outer end
post_d = 6.5;             // printed screw post diameter

base_l = holder_l;
base_h = bottom_thick + slot_h;
base_w = post_zone_w * 2 + side_wall * 2 + flange_pocket_w * 2 + center_wall;

// channel positions
usable_y0 = post_zone_w + side_wall;
slot1_y = usable_y0 + flange_pocket_w / 2;
slot2_y = usable_y0 + flange_pocket_w + center_wall + flange_pocket_w / 2;
slot_y_centers = [slot1_y, slot2_y];

// flange pocket centered in the 10 mm holder
flange_x0 = base_l / 2 - flange_pocket_l / 2;

// screw posts: two screws at left/right side ends of the lid
// This keeps the lid only 10 mm long while still giving proper screw spacing.
screw_d = 3.2;            // M3 lid clearance
pilot_d = 2.65;           // M3 self-tapping pilot in printed post
head_d = 6.2;             // screw head pocket diameter
head_depth = 1.0;
screw_x = base_l / 2;
screw1_y = post_zone_w / 2;
screw2_y = base_w - post_zone_w / 2;

// small underside ribs on lid to remove vertical rattle
lid_press_rib_drop = 0.12;
lid_rib_w = sc_w - 1.0;

// -----------------------------
// Utility modules
// -----------------------------
module rounded_rect_2d(size=[10,10], r=1) {
    offset(r=r)
        offset(delta=-r)
            square(size, center=false);
}

module rounded_cube(size=[10,10,10], r=1) {
    linear_extrude(height=size[2])
        rounded_rect_2d([size[0], size[1]], r);
}

module screw_locations() {
    for (y = [screw1_y, screw2_y])
        translate([screw_x, y, 0]) children();
}

// -----------------------------
// Corrected SC connector mock
// -----------------------------
module sc_connector_mock(show_front_detail=true) {
    difference() {
        union() {
            // Main body, centered on Y/Z, X starts at 0
            translate([0, -sc_w/2, -sc_h/2])
                cube([sc_l, sc_w, sc_h]);

            // Side-only flange centered along connector length
            translate([sc_l/2 - flange_t/2, -flange_total_w/2, -sc_h/2])
                cube([flange_t, side_flange_each, sc_h]);

            translate([sc_l/2 - flange_t/2, sc_w/2, -sc_h/2])
                cube([flange_t, side_flange_each, sc_h]);
        }

        if (show_front_detail) {
            front_inner_square = 6.4;
            front_opening_d = 3.2;
            recess_depth = 0.45;

            translate([-0.02, -front_inner_square/2, -front_inner_square/2])
                cube([recess_depth + 0.04, front_inner_square, front_inner_square]);

            translate([-0.04, 0, 0])
                rotate([0,90,0])
                    cylinder(d=front_opening_d, h=recess_depth + 0.08);
        }
    }
}

// -----------------------------
// Base with 10 mm center clamp and matching screw posts
// -----------------------------
module holder_base() {
    difference() {
        union() {
            // Main 10 mm holder body
            rounded_cube([base_l, base_w, base_h], r=0.8);

            // Reinforced screw posts in the body
            screw_locations()
                cylinder(d=post_d, h=base_h);
        }

        // Connector grooves and centered flange pockets
        for (yc = slot_y_centers) {
            // Narrow main body groove, open through both X ends and open at top
            translate([-0.10, yc - slot_w/2, bottom_thick])
                cube([base_l + 0.20, slot_w, slot_h + 0.30]);

            // Wider side-flange pocket only at the center of the 10 mm holder
            translate([flange_x0, yc - flange_pocket_w/2, bottom_thick - 0.02])
                cube([flange_pocket_l, flange_pocket_w, slot_h + 0.35]);
        }

        // Screw pilot holes in the body posts
        screw_locations()
            translate([0,0,bottom_thick])
                cylinder(d=pilot_d, h=base_h + 0.50);
    }
}

// -----------------------------
// Removable lid, only 10 mm long, with two screw holes
// -----------------------------
module top_lid() {
    difference() {
        union() {
            rounded_cube([base_l, base_w, lid_t], r=0.8);

            // Pressure ribs above each SC connector body.
            // They are narrower than the SC body so they do not hit the side flanges.
            for (yc = slot_y_centers) {
                translate([0.60, yc - lid_rib_w/2, -lid_press_rib_drop])
                    cube([base_l - 1.20, lid_rib_w, lid_press_rib_drop]);
            }
        }

        // M3 screw clearance holes
        screw_locations()
            translate([0,0,-0.50])
                cylinder(d=screw_d, h=lid_t + 1.20);

        // Screw head pockets
        screw_locations()
            translate([0,0,lid_t - head_depth])
                cylinder(d=head_d, h=head_depth + 0.20);
    }
}

// -----------------------------
// Assembly preview
// -----------------------------
module assembly_preview() {
    holder_base();

    if (show_mocks) {
        for (yc = slot_y_centers) {
            color("gray", 0.55)
                translate([base_l/2 - sc_l/2, yc, bottom_thick + sc_h/2])
                    sc_connector_mock(show_front_detail=true);
        }
    }

    lid_z = exploded_preview ? base_h + 6 : base_h;
    translate([0,0,lid_z])
        top_lid();
}

// -----------------------------
// Output selector
// -----------------------------
if (part == "base") {
    holder_base();
} else if (part == "lid") {
    top_lid();
} else if (part == "mock") {
    sc_connector_mock(show_front_detail=true);
} else {
    assembly_preview();
}
