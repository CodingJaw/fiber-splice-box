/*
    Dual SC Connector Holder
    Uses the corrected SC connector mock as the markup / reference part.

    Units: mm

    Design idea:
    - Two SC connector adapters sit side-by-side.
    - Each connector body drops into a close-fit channel.
    - The side-only flange drops into a wider center pocket.
    - A removable top plate clamps the connectors down.
    - Plate can be screwed down with M3 screws.

    OpenSCAD modes:
      part = "assembly";  // preview everything
      part = "base";      // print holder base
      part = "plate";     // print top retaining plate
      part = "mock";      // show only one SC connector mock
*/

$fn = 64;

// -----------------------------
// Select output
// -----------------------------
part = "assembly";   // "assembly", "base", "plate", "mock"
show_mocks = true;
exploded_preview = true;

// -----------------------------
// SC connector dimensions
// -----------------------------
sc_l = 27.5;              // connector length, X
sc_w = 12.8;              // main body width, Y
sc_h = 9.3;               // main body height, Z

flange_total_w = 14.8;    // total width across side flanges, Y
flange_t = 2.5;           // flange thickness along X
side_flange_each = (flange_total_w - sc_w) / 2;

// -----------------------------
// Fit clearances
// Tight PETG starting point for CR-6 SE / Orca
// Increase by 0.1-0.2 if your printer over-extrudes.
// -----------------------------
body_clearance_y = 0.25;
body_clearance_x = 0.60;
body_clearance_z = 0.25;

flange_clearance_y = 0.30;
flange_clearance_x = 0.35;

// A small pressure rib under the lid helps stop vertical rattle.
// Set to 0 if the lid is too tight.
lid_press_rib_drop = 0.10;

// -----------------------------
// Holder dimensions
// -----------------------------
bottom_thick = 2.4;
side_wall = 2.4;
center_wall = 3.0;
end_wall = 2.6;

slot_l = sc_l + body_clearance_x;
slot_w = sc_w + body_clearance_y;
slot_h = sc_h + body_clearance_z;

flange_pocket_l = flange_t + flange_clearance_x;
flange_pocket_w = flange_total_w + flange_clearance_y;

base_l = slot_l + 2 * end_wall;
base_w = 2 * side_wall + 2 * flange_pocket_w + center_wall;
base_h = bottom_thick + slot_h;

plate_t = 2.2;
plate_l = base_l;
plate_w = base_w;

// Screw layout
screw_d = 3.2;          // M3 clearance in lid
base_pilot_d = 2.65;    // M3 self-tap pilot in printed base; use 4.2-4.6 for heat inserts
screw_head_d = 6.2;     // shallow counterbore/countersink visual clearance
screw_head_depth = 1.0;
screw_edge_x = 4.8;
screw_edge_y = 4.8;

// Connector slot Y centers
slot1_y = side_wall + flange_pocket_w / 2;
slot2_y = side_wall + flange_pocket_w + center_wall + flange_pocket_w / 2;
slot_y_centers = [slot1_y, slot2_y];

slot_x0 = end_wall;
flange_x_center = slot_x0 + slot_l / 2;
flange_x0 = flange_x_center - flange_pocket_l / 2;

// -----------------------------
// Utility modules
// -----------------------------
module rounded_cube(size=[10,10,10], r=1.0) {
    // 2D rounded rectangle extruded upward
    linear_extrude(height=size[2])
        offset(r=r)
            offset(delta=-r)
                square([size[0], size[1]], center=false);
}

module screw_positions() {
    for (x = [screw_edge_x, base_l - screw_edge_x])
        for (y = [screw_edge_y, base_w - screw_edge_y])
            translate([x, y, 0]) children();
}

// -----------------------------
// Corrected SC connector mock
// -----------------------------
module sc_connector_mock(show_front_detail=true) {
    difference() {
        union() {
            // Main body, centered on Y/Z at origin, X starts at 0
            translate([0, -sc_w/2, -sc_h/2])
                cube([sc_l, sc_w, sc_h]);

            // Side-only flange centered along connector length
            translate([sc_l/2 - flange_t/2, -flange_total_w/2, -sc_h/2])
                cube([flange_t, side_flange_each, sc_h]);

            translate([sc_l/2 - flange_t/2, sc_w/2, -sc_h/2])
                cube([flange_t, side_flange_each, sc_h]);
        }

        if (show_front_detail) {
            // Front visual recess and round center detail only
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
// Holder base
// -----------------------------
module holder_base() {
    difference() {
        // Main base block with mild outside corner radius
        rounded_cube([base_l, base_w, base_h], r=1.0);

        // Connector body channels and side-flange pockets
        for (yc = slot_y_centers) {
            // Main body close-fit channel, open at top
            translate([slot_x0, yc - slot_w/2, bottom_thick])
                cube([slot_l, slot_w, slot_h + 0.20]);

            // Center flange pocket; wider only where the side flanges are
            translate([flange_x0, yc - flange_pocket_w/2, bottom_thick - 0.01])
                cube([flange_pocket_l, flange_pocket_w, slot_h + 0.30]);

            // Small finger relief at each end to help lift connector out
            translate([slot_x0 + 1.0, yc, bottom_thick + slot_h - 1.2])
                rotate([0,90,0])
                    cylinder(d=4.0, h=3.0);

            translate([slot_x0 + slot_l - 4.0, yc, bottom_thick + slot_h - 1.2])
                rotate([0,90,0])
                    cylinder(d=4.0, h=3.0);
        }

        // Screw pilot holes in the base
        screw_positions()
            translate([0,0,bottom_thick])
                cylinder(d=base_pilot_d, h=base_h + 1.0);
    }
}

// -----------------------------
// Removable top retaining plate
// -----------------------------
module top_plate() {
    difference() {
        union() {
            rounded_cube([plate_l, plate_w, plate_t], r=1.0);

            // Two shallow underside ribs that sit over the connector body area.
            // These are intentionally narrow so they do not interfere with side flanges.
            for (yc = slot_y_centers) {
                translate([slot_x0 + 1.0, yc - (slot_w - 1.0)/2, -lid_press_rib_drop])
                    cube([slot_l - 2.0, slot_w - 1.0, lid_press_rib_drop]);
            }
        }

        // M3 clearance holes
        screw_positions()
            translate([0,0,-0.5])
                cylinder(d=screw_d, h=plate_t + 1.2);

        // Shallow screw head pockets
        screw_positions()
            translate([0,0,plate_t - screw_head_depth])
                cylinder(d=screw_head_d, h=screw_head_depth + 0.2);
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
                translate([slot_x0 + body_clearance_x/2, yc, bottom_thick + sc_h/2])
                    sc_connector_mock(show_front_detail=true);
        }
    }

    plate_z = exploded_preview ? base_h + 7 : base_h;
    translate([0,0,plate_z])
        top_plate();
}

// -----------------------------
// Output selector
// -----------------------------
if (part == "base") {
    holder_base();
} else if (part == "plate") {
    top_plate();
} else if (part == "mock") {
    sc_connector_mock(show_front_detail=true);
} else {
    assembly_preview();
}
