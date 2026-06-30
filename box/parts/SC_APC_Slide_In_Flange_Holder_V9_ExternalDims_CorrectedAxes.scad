/*
  SC/APC Simplex Coupler Holder - V9 External-Dimension Fit / Corrected Axes

  This version changes the SC/APC dimensions to be treated as external coupler
  measurements, not desired hole sizes.

  Important axis correction:
  - W = X direction, left/right across the connector face.
  - H = Z direction, vertical height of the connector face.
  - Depth Y = front/back plug direction.

  The clearances are then applied to the holder openings.

  Default dimensions are based on the measurements/settings provided:
  - flange external: 15.0 W x 9.3 H x 2.9 T
  - body external:   12.8 W x 9.3 H x 27.5 Y
  - body clearance:  13.6 W x 10.1 H

  Design intent:
  - Coupler drops down from above.
  - Side flange lips slide into left/right capture rails.
  - Center connector body path is open.
  - Long keeper plate screws down over both connector positions.
  - Screw posts are placed at ends and between connectors only, never on a
    connector centerline.
*/

$fn = 48;

/* [Preview] */
Show_Two_Holders = true;
Show_Mock_Couplers = true;
Show_Long_Keeper_Installed = true;
Show_Long_Keeper_Separate = true;
Show_Clearance_Ghost = false;
Explode_Keeper_Z = 0;       // set to 8-15 to visually lift the installed keeper
Explode_Mock_Y = 0;         // set to -20 or 20 to move mock couplers for inspection

/* [SC/APC coupler external dimensions] */
SC_Flange_W = 15.0;         // external flange width, X direction
SC_Flange_H = 9.3;          // external flange height, Z direction
SC_Flange_T = 2.9;          // external flange thickness, Y direction
SC_Body_W = 12.8;           // external connector body width, X direction
SC_Body_H = 9.3;            // external connector body height, Z direction
SC_Body_Depth_Y = 27.5;     // external connector body length, Y direction

/* [Holder clearances] */
SC_Body_Clear_W = 13.6;     // actual center opening width in holder
SC_Body_Clear_H = 10.1;     // actual center opening height in holder
SC_Clearance = 0.40;        // general print clearance for flange slots
Min_Flange_Ear_W = 0.8;     // prevents rails from disappearing on small flange lips

/* [Holder layout] */
Holder_Count = 2;
Holder_Pitch = 24.0;
Base_Thickness = 3.0;
Base_Depth_Y = 28.0;
Base_Margin_X = 5.0;
Base_End_Extra_X = 7.0;
Base_Boss_Margin_X = 2.5;

Bottom_Stop_H = 1.7;        // small lower ledge under flange lips only
Rail_Depth_Y = 10.0;        // front/back depth of the flange capture rails
Rail_Outer_Wall_X = 2.2;    // wall outside the flange lip
Rail_Lip_Y = 2.3;           // front/back wall thickness around flange slot
Carrier_Top_Relief_Z = 0.35;

/* [Long screw-down keeper plate] */
Keeper_Thickness = 2.6;
Keeper_Depth_Y = 12.0;
Keeper_End_Overhang_X = 6.0;
Keeper_Flange_Clearance_Z = 0.10;
Keeper_Screw_Dia = 3.2;
Keeper_Screw_Head_Dia = 6.4;
Keeper_Screw_Head_Depth = 1.3;
Keeper_End_Screw_Inset_X = 7.5;
Screw_Boss_Dia = 8.5;
Screw_Pilot_Dia = 2.4;

/* [Optional base mounting holes] */
Add_Base_Mount_Holes = true;
Base_Mount_Screw_Dia = 3.2;
Base_Mount_Hole_Offset_X = 8.0;
Base_Mount_Hole_Offset_Y = 7.0;

/* [Mock display] */
Mock_Color = "LimeGreen";
Mock_Alpha = 0.55;

// ---------- Derived dimensions ----------
count_active = Show_Two_Holders ? Holder_Count : 1;

// Physical flange lip width per side, based on external dimensions.
flange_ear_w_raw = (SC_Flange_W - SC_Body_W) / 2;
flange_ear_w = max(flange_ear_w_raw, Min_Flange_Ear_W);

slot_y = SC_Flange_T + SC_Clearance;
slot_w_x = flange_ear_w + SC_Clearance;
rail_block_w = flange_ear_w + Rail_Outer_Wall_X + SC_Clearance;
single_w = SC_Flange_W + 2*Rail_Outer_Wall_X + 2*SC_Clearance;

holder_array_w = (count_active-1)*Holder_Pitch + single_w;
base_nominal_w = holder_array_w + 2*Base_Margin_X + 2*Base_End_Extra_X;
keeper_w = holder_array_w + 2*Base_Margin_X + 2*Keeper_End_Overhang_X;
keeper_left_screw_x = -keeper_w/2 + Keeper_End_Screw_Inset_X;
keeper_right_screw_x = keeper_w/2 - Keeper_End_Screw_Inset_X;
screw_boss_span_w = (keeper_right_screw_x - keeper_left_screw_x) + Screw_Boss_Dia + 2*Base_Boss_Margin_X;
base_w = max(base_nominal_w, screw_boss_span_w);

flange_bottom_z = Base_Thickness + Bottom_Stop_H;
flange_top_z = flange_bottom_z + SC_Flange_H;
keeper_underside_z = flange_top_z + Keeper_Flange_Clearance_Z;
rail_top_z = keeper_underside_z - Carrier_Top_Relief_Z;
rail_h = rail_top_z - Base_Thickness;
boss_h = keeper_underside_z - Base_Thickness;

// ---------- Utility modules ----------
module z_cylinder(d, h, center=false) {
    cylinder(d=d, h=h, center=center);
}

module base_mount_hole_positions() {
    for (sx=[-1,1], sy=[-1,1])
        translate([sx*(base_w/2-Base_Mount_Hole_Offset_X), sy*(Base_Depth_Y/2-Base_Mount_Hole_Offset_Y), -0.2])
            children();
}

module common_base_plate() {
    difference() {
        translate([0,0,Base_Thickness/2])
            cube([base_w, Base_Depth_Y, Base_Thickness], center=true);

        if (Add_Base_Mount_Holes)
            base_mount_hole_positions()
                z_cylinder(d=Base_Mount_Screw_Dia, h=Base_Thickness+0.5);
    }
}

module bottom_ear_stop(side=1) {
    // Stop only below the side flange lip. It does not cross the center body opening.
    ear_center_x = side * (SC_Body_W/2 + flange_ear_w/2);
    translate([ear_center_x, 0, Base_Thickness + Bottom_Stop_H/2])
        cube([flange_ear_w + SC_Clearance, Rail_Depth_Y, Bottom_Stop_H], center=true);
}

module side_capture_rail(side=1) {
    // Captures only one flange lip/ear. Center path is relieved clear.
    ear_center_x = side * (SC_Body_W/2 + flange_ear_w/2);
    rail_center_x = side * (SC_Body_W/2 + rail_block_w/2 - SC_Clearance/2);

    difference() {
        // Outer rail body.
        translate([rail_center_x, 0, Base_Thickness + rail_h/2])
            cube([rail_block_w, Rail_Depth_Y, rail_h], center=true);

        // Vertical slide slot for the flange lip.
        translate([ear_center_x, 0, flange_bottom_z + (rail_top_z - flange_bottom_z)/2])
            cube([slot_w_x, slot_y, rail_top_z - flange_bottom_z + 1.6], center=true);

        // Center-body relief. This uses the holder clearance opening, not the external body width.
        translate([side * (SC_Body_Clear_W/4), 0, Base_Thickness + rail_h/2])
            cube([SC_Body_Clear_W/2 + SC_Clearance + 1.0, Rail_Depth_Y + 1.0, rail_h + 1.0], center=true);

        // Top lead-in for easier drop-in.
        translate([ear_center_x, 0, rail_top_z - 0.4])
            cube([slot_w_x + 0.8, slot_y + 1.0, 1.4], center=true);
    }
}

module single_holder_without_base(show_mock=true) {
    bottom_ear_stop(-1);
    bottom_ear_stop(1);
    side_capture_rail(-1);
    side_capture_rail(1);

    if (Show_Clearance_Ghost) clearance_ghost();
    if (show_mock) translate([0, Explode_Mock_Y, 0]) mock_sc_coupler();
}

module mock_sc_coupler() {
    // External-dimension simplified mock. The mock and the holder use the same axis convention.
    zc = flange_bottom_z + SC_Flange_H/2;

    color(Mock_Color, Mock_Alpha) {
        // Connector body.
        translate([0, 0, zc])
            cube([SC_Body_W, SC_Body_Depth_Y, SC_Body_H], center=true);

        // Thin flange plate/lips.
        translate([0, 0, zc])
            cube([SC_Flange_W, SC_Flange_T, SC_Flange_H], center=true);

        // Visual front/back face collars.
        translate([0, SC_Body_Depth_Y/2 - 1.1, zc])
            cube([SC_Body_W, 2.2, SC_Body_H], center=true);
        translate([0, -SC_Body_Depth_Y/2 + 1.1, zc])
            cube([SC_Body_W, 2.2, SC_Body_H], center=true);
    }

    // Optical bore marks for visual checking only.
    color("DarkGreen", 0.85)
    for (yy=[-1,1])
        translate([0, yy*(SC_Body_Depth_Y/2+0.04), zc])
            rotate([90,0,0]) z_cylinder(d=4.0, h=0.35);
}

module clearance_ghost() {
    color("Orange", 0.22) {
        translate([0,0,flange_bottom_z + SC_Flange_H/2])
            cube([SC_Flange_W + SC_Clearance, SC_Flange_T + SC_Clearance, SC_Flange_H + SC_Clearance], center=true);
        translate([0,0,flange_bottom_z + SC_Body_Clear_H/2])
            cube([SC_Body_Clear_W, SC_Body_Depth_Y + 1.0, SC_Body_Clear_H], center=true);
    }
}

module screw_positions(count=count_active) {
    array_w_local = (count-1)*Holder_Pitch + single_w;
    keeper_w_local = array_w_local + 2*Base_Margin_X + 2*Keeper_End_Overhang_X;
    left_x = -keeper_w_local/2 + Keeper_End_Screw_Inset_X;
    right_x = keeper_w_local/2 - Keeper_End_Screw_Inset_X;

    // End screws outside the connector positions.
    for (x=[left_x, right_x])
        translate([x,0,0]) children();

    // Intermediate screws only in gaps between adjacent connectors.
    if (count > 1)
        for (i=[0:count-2]) {
            x_gap = ((i-(count-1)/2)*Holder_Pitch + ((i+1)-(count-1)/2)*Holder_Pitch)/2;
            translate([x_gap,0,0]) children();
        }
}

module long_keeper_plate(count=count_active) {
    array_w_local = (count-1)*Holder_Pitch + single_w;
    keeper_w_local = array_w_local + 2*Base_Margin_X + 2*Keeper_End_Overhang_X;

    difference() {
        cube([keeper_w_local, Keeper_Depth_Y, Keeper_Thickness], center=true);

        screw_positions(count) {
            translate([0, 0, -Keeper_Thickness/2-0.1])
                z_cylinder(d=Keeper_Screw_Dia, h=Keeper_Thickness+0.3);
            translate([0, 0, Keeper_Thickness/2-Keeper_Screw_Head_Depth])
                z_cylinder(d=Keeper_Screw_Head_Dia, h=Keeper_Screw_Head_Depth+0.2);
        }

        // Shallow relief over connector center only. It does not remove the ear-retaining areas.
        for (i=[0:count-1]) {
            x0 = (i-(count-1)/2)*Holder_Pitch;
            translate([x0, 0, -Keeper_Thickness/2 + 0.45])
                cube([SC_Body_Clear_W + 0.8, Keeper_Depth_Y+0.4, 1.0], center=true);
        }
    }
}

module long_keeper_screw_bosses(count=count_active) {
    screw_positions(count)
        translate([0, 0, Base_Thickness + boss_h/2])
            difference() {
                z_cylinder(d=Screw_Boss_Dia, h=boss_h, center=true);
                translate([0,0,-boss_h/2-0.1])
                    z_cylinder(d=Screw_Pilot_Dia, h=boss_h+0.4);
            }
}

module holder_array() {
    count = count_active;

    common_base_plate();

    for (i=[0:count-1])
        translate([(i-(count-1)/2)*Holder_Pitch, 0, 0])
            single_holder_without_base(Show_Mock_Couplers);

    long_keeper_screw_bosses(count);

    if (Show_Long_Keeper_Installed)
        translate([0,0,keeper_underside_z + Keeper_Thickness/2 + Explode_Keeper_Z])
            long_keeper_plate(count);

    if (Show_Long_Keeper_Separate)
        translate([0, -Base_Depth_Y - 16, Keeper_Thickness/2])
            long_keeper_plate(count);
}

holder_array();
