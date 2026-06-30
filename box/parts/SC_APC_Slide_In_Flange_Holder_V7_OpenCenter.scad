/*
  SC/APC Simplex Coupler Holder - V7 Open-Center Corrected Geometry

  What V7 fixes:
  - Removes the center/back wall that was protruding into the mock connector path.
  - The holder no longer has any plastic crossing the center connector body opening.
  - The mock coupler and holder now use the same flange/body reference dimensions.
  - The only captured areas are the two outside flange ears.
  - One long keeper plate spans both couplers with 3 screw points: left, center, right.

  Intended coupler style:
  - SC/APC female-to-female simplex coupler with rectangular side flange/ears.
  - Coupler drops down from above.
  - Flange ears slide into side channels.
  - Keeper plate screws down over the tops of both flange ears.
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

/* [SC/APC coupler dimensions] */
SC_Flange_W = 22.0;         // total flange width across both ears
SC_Flange_H = 17.0;         // flange height top-to-bottom
SC_Flange_T = 2.1;          // flange thickness along plug direction
SC_Body_W = 9.3;            // central connector body width
SC_Body_H = 13.0;           // central connector body height
SC_Body_Depth_Y = 28.0;     // central connector body length through holder

SC_Body_Clear_W = 10.8;     // open center width in holder
SC_Body_Clear_H = 14.2;     // visual/debug clearance, not used as a wall
SC_Clearance = 0.35;

/* [Holder layout] */
Holder_Count = 2;
Holder_Pitch = 30.0;
Base_Thickness = 3.0;
Base_Depth_Y = 28.0;
Base_Margin_X = 5.0;
Base_End_Extra_X = 7.0;
Base_Boss_Margin_X = 2.5;

Bottom_Stop_H = 2.2;        // ledge below flange, not in center body path
Rail_Depth_Y = 10.0;        // depth of capture channels
Rail_Outer_Wall_X = 2.0;    // outside wall beyond flange ears
Rail_Lip_Y = 2.4;           // front/back lip thickness around flange slot
Carrier_Top_Relief_Z = 0.35;

/* [Long screw-down keeper plate] */
Keeper_Thickness = 2.6;
Keeper_Depth_Y = 12.0;
Keeper_End_Overhang_X = 6.0;
Keeper_Flange_Clearance_Z = 0.15;
Keeper_Screw_Dia = 3.2;
Keeper_Screw_Head_Dia = 6.4;
Keeper_Screw_Head_Depth = 1.3;
Keeper_End_Screw_Inset_X = 7.5;
Screw_Boss_Dia = 8.5;
Screw_Pilot_Dia = 2.4;

/* [Optional base mounting holes] */
Add_Base_Mount_Holes = true;
Base_Mount_Screw_Dia = 3.2;
Base_Mount_Hole_Offset_X = 9.0;
Base_Mount_Hole_Offset_Y = 7.0;

/* [Mock display] */
Mock_Color = "LimeGreen";
Mock_Alpha = 0.55;

// ---------- Derived dimensions ----------
count_active = Show_Two_Holders ? Holder_Count : 1;

flange_ear_w = (SC_Flange_W - SC_Body_Clear_W) / 2;
slot_y = SC_Flange_T + SC_Clearance;
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
    // Stop only under the flange ear channel. This avoids any center obstruction.
    body_edge = SC_Body_Clear_W/2;
    ear_center_x = side * (body_edge + flange_ear_w/2);
    translate([ear_center_x, 0, Base_Thickness + Bottom_Stop_H/2])
        cube([flange_ear_w + SC_Clearance + 0.5, Rail_Depth_Y, Bottom_Stop_H], center=true);
}

module side_capture_rail(side=1) {
    // Captures ONLY one flange ear. The center body opening remains completely clear.
    body_edge = SC_Body_Clear_W/2;

    rail_center_x = side * (body_edge + rail_block_w/2 - SC_Clearance/2);
    slot_center_x = side * (body_edge + flange_ear_w/2);
    slot_w_x = flange_ear_w + SC_Clearance + 0.40;

    difference() {
        translate([rail_center_x, 0, Base_Thickness + rail_h/2])
            cube([rail_block_w, Rail_Depth_Y, rail_h], center=true);

        // Ear slot. Open at the top. Does not cross the center connector body.
        translate([slot_center_x, 0, flange_bottom_z + (rail_top_z - flange_bottom_z)/2])
            cube([slot_w_x, slot_y, rail_top_z - flange_bottom_z + 1.6], center=true);

        // Large center-side relief, guaranteeing no inside wall protrudes into the body path.
        translate([side * (body_edge/2), 0, Base_Thickness + rail_h/2])
            cube([body_edge + SC_Clearance + 1.0, Rail_Depth_Y + 1.0, rail_h + 1.0], center=true);

        // Top lead-in.
        translate([slot_center_x, 0, rail_top_z - 0.4])
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
    // Mock is intentionally simple and dimensionally direct:
    // green thin rectangle = flange/ears
    // green long center box = connector body passing through holder
    color(Mock_Color, Mock_Alpha) {
        translate([0,0,flange_bottom_z + SC_Flange_H/2])
            cube([SC_Flange_W, SC_Flange_T, SC_Flange_H], center=true);

        translate([0,0,flange_bottom_z + SC_Flange_H/2])
            cube([SC_Body_W, SC_Body_Depth_Y, SC_Body_H], center=true);

        // small collars for visual orientation only
        translate([0, SC_Flange_T/2 + 0.75, flange_bottom_z + SC_Flange_H/2])
            cube([SC_Body_W + 1.0, 1.5, SC_Body_H + 1.0], center=true);
        translate([0, -SC_Flange_T/2 - 0.75, flange_bottom_z + SC_Flange_H/2])
            cube([SC_Body_W + 1.0, 1.5, SC_Body_H + 1.0], center=true);
    }

    color("DarkGreen", 0.85)
    for (sx=[-1,1])
        translate([sx*(SC_Flange_W/2-3.8), -SC_Flange_T/2-0.06, flange_bottom_z + SC_Flange_H/2])
            rotate([90,0,0]) z_cylinder(d=2.4, h=0.5);
}

module clearance_ghost() {
    color("Orange", 0.22) {
        translate([0,0,flange_bottom_z + SC_Flange_H/2])
            cube([SC_Flange_W + SC_Clearance, SC_Flange_T + SC_Clearance, SC_Flange_H + SC_Clearance], center=true);
        translate([0,0,flange_bottom_z + SC_Flange_H/2])
            cube([SC_Body_Clear_W, SC_Body_Depth_Y + 1.0, SC_Body_Clear_H], center=true);
    }
}

module long_keeper_plate(count=count_active) {
    array_w_local = (count-1)*Holder_Pitch + single_w;
    keeper_w_local = array_w_local + 2*Base_Margin_X + 2*Keeper_End_Overhang_X;
    left_x = -keeper_w_local/2 + Keeper_End_Screw_Inset_X;
    mid_x = 0;
    right_x = keeper_w_local/2 - Keeper_End_Screw_Inset_X;

    difference() {
        cube([keeper_w_local, Keeper_Depth_Y, Keeper_Thickness], center=true);

        for (x=[left_x, mid_x, right_x]) {
            translate([x, 0, -Keeper_Thickness/2-0.1])
                z_cylinder(d=Keeper_Screw_Dia, h=Keeper_Thickness+0.3);
            translate([x, 0, Keeper_Thickness/2-Keeper_Screw_Head_Depth])
                z_cylinder(d=Keeper_Screw_Head_Dia, h=Keeper_Screw_Head_Depth+0.2);
        }

        // Relief for connector body only. Ear zones stay solid so the keeper retains the flanges.
        for (i=[0:count-1]) {
            x0 = (i-(count-1)/2)*Holder_Pitch;
            translate([x0, 0, -Keeper_Thickness/2 + 0.45])
                cube([SC_Body_Clear_W + 1.2, Keeper_Depth_Y+0.4, 1.1], center=true);
        }
    }
}

module long_keeper_screw_bosses(count=count_active) {
    array_w_local = (count-1)*Holder_Pitch + single_w;
    keeper_w_local = array_w_local + 2*Base_Margin_X + 2*Keeper_End_Overhang_X;
    left_x = -keeper_w_local/2 + Keeper_End_Screw_Inset_X;
    mid_x = 0;
    right_x = keeper_w_local/2 - Keeper_End_Screw_Inset_X;

    for (x=[left_x, mid_x, right_x])
        translate([x, 0, Base_Thickness + boss_h/2])
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
