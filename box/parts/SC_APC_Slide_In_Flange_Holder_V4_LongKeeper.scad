/*
  SC/APC Simplex Coupler Holder - V4 Long Screw-Down Keeper

  Purpose:
  - Standalone test holder for two SC/APC female-to-female simplex flange adapters/couplers.
  - The connector flange ears slide down vertically into side capture rails.
  - A single long keeper plate spans BOTH connectors.
  - The keeper plate has THREE screw points: left end, center, and right end.
  - This avoids pushing the connector through a thick printed hole.

  Coordinate idea:
  - Coupler plugs face front/back along the Y axis.
  - Coupler flange/ears sit in the X-Z plane.
  - Coupler slides down along Z into the side grooves.
*/

$fn = 48;

/* [Preview] */
Show_Two_Holders = true;
Show_Mock_Couplers = true;
Show_Long_Keeper_Installed = true;
Show_Long_Keeper_Separate = true;

/* [SC coupler / flange fit] */
// Overall flange width across the two ears. Measure your adapter across the flange ears.
SC_Flange_W = 22.0;
// Flange height from bottom to top of flange face.
SC_Flange_H = 17.0;
// Thickness of the flat flange/ears along the plug direction. Add clearance below.
SC_Flange_T = 2.1;
// Width of the rectangular center body area to leave clear.
SC_Body_Clear_W = 10.8;
// Height of the rectangular center body area to leave clear.
SC_Body_Clear_H = 13.8;
// Extra clearance added to capture grooves.
SC_Clearance = 0.35;

/* [Holder geometry] */
Holder_Count = 2;
Holder_Pitch = 30.0;
Base_Thickness = 3.0;
Base_Depth_Y = 22.0;
Base_Margin_X = 5.0;
Bottom_Stop_H = 2.2;
Rail_W = 5.0;
Rail_Depth_Y = 8.0;

// V4 change: keep this small so the keeper plate actually captures the flange.
// Larger values allow more vertical play before the plate stops the connector.
Rail_Extra_H = 0.9;

// How far each flange ear slides into each side rail.
Groove_Depth_X = 3.2;
// Front/back lip thickness around the flange slot. Larger = stronger, smaller = looser.
Groove_Lip_Y = 2.3;
Back_Spine_Thickness_Y = 3.0;
Back_Spine_H = 19.0;

/* [Long screw-down keeper plate] */
Keeper_Thickness = 2.6;
Keeper_Depth_Y = 11.5;
Keeper_End_Overhang_X = 6.0;
Keeper_Clearance_Z = 0.25;
Keeper_Screw_Dia = 3.2;       // M3 clearance through keeper plate
Keeper_Screw_Head_Dia = 6.4;  // counterbore/countersink preview
Keeper_Screw_Head_Depth = 1.3;

// Three screw points: left end, center, right end.
Keeper_End_Screw_Inset_X = 7.5;
Screw_Boss_Dia = 8.0;
Screw_Boss_H_Extra = 0.0;
Screw_Pilot_Dia = 2.4;        // pilot into plastic boss for M3 self-tapping or heat-set adjustment

/* [Mounting holes in base, optional] */
Add_Base_Mount_Holes = true;
Base_Mount_Screw_Dia = 3.2;
Base_Mount_Hole_Offset_X = 8.0;
Base_Mount_Hole_Offset_Y = 6.0;

/* [Mock adapter, preview only] */
Mock_Body_W = 9.3;
Mock_Body_H = 13.0;
Mock_Body_Depth_Y = 28.0;
Mock_Flange_T = 2.0;
Mock_Color = "LimeGreen";

rail_h = Bottom_Stop_H + SC_Flange_H + SC_Clearance + Rail_Extra_H;
slot_y = SC_Flange_T + SC_Clearance;
single_w = SC_Body_Clear_W + 2*Rail_W + 2*Groove_Depth_X;
base_w = single_w + 2*Base_Margin_X;

module screw_hole_z(d=3.2, h=20, head_d=6, head_depth=1.2) {
    translate([0,0,-0.1]) cylinder(d=d, h=h+0.2);
    translate([0,0,h-head_depth]) cylinder(d=head_d, h=head_depth+0.3);
}

module side_capture_rail(side=1) {
    // side = +1 right rail, -1 left rail
    inner_x = side * (SC_Body_Clear_W/2);
    rail_x = side * (SC_Body_Clear_W/2 + Rail_W/2);

    difference() {
        translate([rail_x, 0, Base_Thickness + rail_h/2])
            cube([Rail_W, Rail_Depth_Y, rail_h], center=true);

        // Vertical flange groove opening toward center.
        // Captures the ear between front/back lips and allows slide-in from top.
        translate([
            inner_x + side*(Groove_Depth_X/2),
            0,
            Base_Thickness + Bottom_Stop_H + (rail_h-Bottom_Stop_H)/2
        ])
            cube([Groove_Depth_X + 0.15, slot_y, rail_h-Bottom_Stop_H+1.0], center=true);

        // Small lead-in at top of groove to make insertion easier.
        translate([
            inner_x + side*(Groove_Depth_X/2),
            0,
            Base_Thickness + rail_h - 0.65
        ])
            rotate([0,45*side,0]) cube([Groove_Depth_X*1.4, slot_y+0.4, 2.0], center=true);
    }
}

module rear_spine() {
    // Low rear spine ties the two rails together while leaving the coupler body area open.
    translate([0, Rail_Depth_Y/2 - Back_Spine_Thickness_Y/2, Base_Thickness + Back_Spine_H/2])
    difference() {
        cube([single_w, Back_Spine_Thickness_Y, Back_Spine_H], center=true);
        // Center body clearance cutout through the spine.
        translate([0,0,Bottom_Stop_H + SC_Body_Clear_H/2])
            cube([SC_Body_Clear_W + SC_Clearance, Back_Spine_Thickness_Y+0.4, SC_Body_Clear_H + SC_Clearance], center=true);
    }
}

module base_plate() {
    difference() {
        translate([0,0,Base_Thickness/2])
            cube([base_w, Base_Depth_Y, Base_Thickness], center=true);
        if (Add_Base_Mount_Holes) {
            for (sx=[-1,1], sy=[-1,1]) {
                translate([sx*(base_w/2-Base_Mount_Hole_Offset_X), sy*(Base_Depth_Y/2-Base_Mount_Hole_Offset_Y), -0.2])
                    cylinder(d=Base_Mount_Screw_Dia, h=Base_Thickness+0.5);
            }
        }
    }
}

module single_holder(show_mock=true) {
    base_plate();
    side_capture_rail(-1);
    side_capture_rail(1);
    rear_spine();
    if (show_mock) mock_sc_coupler();
}

module mock_sc_coupler() {
    color(Mock_Color, 0.55) {
        // central body through front/back
        translate([0,0,Base_Thickness + Bottom_Stop_H + SC_Flange_H/2])
            cube([Mock_Body_W, Mock_Body_Depth_Y, Mock_Body_H], center=true);
        // flange plate/ears
        translate([0,0,Base_Thickness + Bottom_Stop_H + SC_Flange_H/2])
            cube([SC_Flange_W, Mock_Flange_T, SC_Flange_H], center=true);
        // screw hole visual marks on flange
        color("DarkGreen", 0.7)
        for (sx=[-1,1])
            translate([sx*(SC_Flange_W/2-3.8), -Mock_Flange_T/2-0.05, Base_Thickness + Bottom_Stop_H + SC_Flange_H/2])
                rotate([90,0,0]) cylinder(d=2.5, h=0.5);
    }
}

module long_keeper_plate(count=2) {
    array_w = (count-1)*Holder_Pitch + base_w;
    keeper_w = array_w + 2*Keeper_End_Overhang_X;
    left_x = -keeper_w/2 + Keeper_End_Screw_Inset_X;
    mid_x = 0;
    right_x = keeper_w/2 - Keeper_End_Screw_Inset_X;

    difference() {
        cube([keeper_w, Keeper_Depth_Y, Keeper_Thickness], center=true);

        // Three screw clearance holes with shallow head recesses.
        for (x=[left_x, mid_x, right_x]) {
            translate([x, 0, -Keeper_Thickness/2-0.1])
                cylinder(d=Keeper_Screw_Dia, h=Keeper_Thickness+0.3);
            translate([x, 0, Keeper_Thickness/2-Keeper_Screw_Head_Depth])
                cylinder(d=Keeper_Screw_Head_Dia, h=Keeper_Screw_Head_Depth+0.2);
        }

        // Shallow underside relief at each coupler body location.
        // This keeps the bar from pressing on the plastic SC body while still holding the flange ears down.
        for (i=[0:count-1]) {
            x0 = (i-(count-1)/2)*Holder_Pitch;
            translate([x0, 0, -Keeper_Thickness/2 + 0.45])
                cube([SC_Body_Clear_W + 1.0, Keeper_Depth_Y+0.4, 1.1], center=true);
        }
    }
}

module long_keeper_screw_bosses(count=2) {
    array_w = (count-1)*Holder_Pitch + base_w;
    keeper_w = array_w + 2*Keeper_End_Overhang_X;
    left_x = -keeper_w/2 + Keeper_End_Screw_Inset_X;
    mid_x = 0;
    right_x = keeper_w/2 - Keeper_End_Screw_Inset_X;
    boss_h = rail_h + Screw_Boss_H_Extra;

    for (x=[left_x, mid_x, right_x]) {
        translate([x, 0, Base_Thickness + boss_h/2])
        difference() {
            cylinder(d=Screw_Boss_Dia, h=boss_h, center=true);
            translate([0,0,-boss_h/2-0.1])
                cylinder(d=Screw_Pilot_Dia, h=boss_h+0.4);
        }
    }
}

module holder_array() {
    count = Show_Two_Holders ? Holder_Count : 1;

    for (i=[0:count-1]) {
        translate([(i-(count-1)/2)*Holder_Pitch, 0, 0])
            single_holder(Show_Mock_Couplers);
    }

    long_keeper_screw_bosses(count);

    if (Show_Long_Keeper_Installed) {
        translate([0,0,Base_Thickness + rail_h + Keeper_Thickness/2 + Keeper_Clearance_Z])
            long_keeper_plate(count);
    }

    if (Show_Long_Keeper_Separate) {
        translate([0, -Base_Depth_Y - 16, Keeper_Thickness/2])
            long_keeper_plate(count);
    }
}

holder_array();
