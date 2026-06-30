/*
  SC/APC Simplex Coupler Holder - V5 Fixed Long Keeper

  Purpose:
  - Standalone test holder for two SC/APC female-to-female simplex flange adapters/couplers.
  - The connector flange ears slide down vertically into side capture rails.
  - A single long screw-down keeper plate spans BOTH connectors.
  - Three keeper screws: left end, center, right end.

  V5 corrections from V4:
  - Uses ONE continuous base plate sized wide enough to fully support the screw columns/bosses.
  - Screw bosses are height-matched to the underside of the keeper plate.
  - Side carrier rails stop slightly below the keeper plate so they do not hold the keeper up.
  - Keeper underside is positioned close to the top of the SC flange ears to actually retain them.
  - Keeper plate underside relief is only over the center coupler bodies, not the flange ears.

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
Base_Depth_Y = 24.0;
Base_Margin_X = 5.0;
// Extra base extension beyond the holder array. The final base also auto-expands to cover screw bosses.
Base_End_Extra_X = 7.0;
// Extra margin around screw boss footprint on the base.
Base_Boss_Margin_X = 2.5;

Bottom_Stop_H = 2.2;
Rail_W = 5.0;
Rail_Depth_Y = 8.0;

// V5: rails are intentionally slightly lower than the keeper underside.
// This prevents the rail/carrier top from stopping the keeper plate from closing down.
Carrier_Top_Relief_Z = 0.25;

// How far each flange ear slides into each side rail.
Groove_Depth_X = 3.2;
// Front/back lip thickness around the flange slot. Larger = stronger, smaller = looser.
Groove_Lip_Y = 2.3;
Back_Spine_Thickness_Y = 3.0;
Back_Spine_H = 18.0;

/* [Long screw-down keeper plate] */
Keeper_Thickness = 2.6;
Keeper_Depth_Y = 12.0;
Keeper_End_Overhang_X = 6.0;

// V5: this is the actual gap between the top of the flange ear and underside of keeper.
// Lower value = tighter hold. Increase slightly if your couplers are hard to install.
Keeper_Flange_Clearance_Z = 0.20;

Keeper_Screw_Dia = 3.2;       // M3 clearance through keeper plate
Keeper_Screw_Head_Dia = 6.4;  // counterbore/countersink preview
Keeper_Screw_Head_Depth = 1.3;

// Three screw points: left end, center, right end.
Keeper_End_Screw_Inset_X = 7.5;
Screw_Boss_Dia = 8.5;
Screw_Pilot_Dia = 2.4;        // pilot into plastic boss for M3 self-tapping or heat-set adjustment

/* [Mounting holes in base, optional] */
Add_Base_Mount_Holes = true;
Base_Mount_Screw_Dia = 3.2;
Base_Mount_Hole_Offset_X = 9.0;
Base_Mount_Hole_Offset_Y = 6.5;

/* [Mock adapter, preview only] */
Mock_Body_W = 9.3;
Mock_Body_H = 13.0;
Mock_Body_Depth_Y = 28.0;
Mock_Flange_T = 2.0;
Mock_Color = "LimeGreen";

// Derived dimensions
count_active = Show_Two_Holders ? Holder_Count : 1;
single_w = SC_Body_Clear_W + 2*Rail_W + 2*Groove_Depth_X;
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
slot_y = SC_Flange_T + SC_Clearance;
boss_h = keeper_underside_z - Base_Thickness;

module base_mount_hole_positions() {
    for (sx=[-1,1], sy=[-1,1]) {
        translate([sx*(base_w/2-Base_Mount_Hole_Offset_X), sy*(Base_Depth_Y/2-Base_Mount_Hole_Offset_Y), -0.2])
            children();
    }
}

module common_base_plate() {
    difference() {
        translate([0,0,Base_Thickness/2])
            cube([base_w, Base_Depth_Y, Base_Thickness], center=true);
        if (Add_Base_Mount_Holes) {
            base_mount_hole_positions()
                cylinder(d=Base_Mount_Screw_Dia, h=Base_Thickness+0.5);
        }
    }
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
            flange_bottom_z + (rail_top_z - flange_bottom_z)/2
        ])
            cube([Groove_Depth_X + 0.15, slot_y, rail_top_z - flange_bottom_z + 0.8], center=true);

        // Small lead-in at top of groove to make insertion easier.
        translate([
            inner_x + side*(Groove_Depth_X/2),
            0,
            rail_top_z - 0.55
        ])
            rotate([0,45*side,0]) cube([Groove_Depth_X*1.4, slot_y+0.4, 2.0], center=true);
    }
}

module rear_spine() {
    // Low rear spine ties the two rails together while leaving the coupler body area open.
    spine_h = min(Back_Spine_H, rail_h);
    translate([0, Rail_Depth_Y/2 - Back_Spine_Thickness_Y/2, Base_Thickness + spine_h/2])
    difference() {
        cube([single_w, Back_Spine_Thickness_Y, spine_h], center=true);
        // Center body clearance cutout through the spine.
        translate([0,0,Bottom_Stop_H + SC_Body_Clear_H/2])
            cube([SC_Body_Clear_W + SC_Clearance, Back_Spine_Thickness_Y+0.4, SC_Body_Clear_H + SC_Clearance], center=true);
    }
}

module single_holder_without_base(show_mock=true) {
    // Bottom stop ledge under the flange/body area.
    translate([0, 0, Base_Thickness + Bottom_Stop_H/2])
        cube([single_w, Rail_Depth_Y, Bottom_Stop_H], center=true);

    side_capture_rail(-1);
    side_capture_rail(1);
    rear_spine();
    if (show_mock) mock_sc_coupler();
}

module mock_sc_coupler() {
    color(Mock_Color, 0.55) {
        // central body through front/back
        translate([0,0,flange_bottom_z + SC_Flange_H/2])
            cube([Mock_Body_W, Mock_Body_Depth_Y, Mock_Body_H], center=true);
        // flange plate/ears
        translate([0,0,flange_bottom_z + SC_Flange_H/2])
            cube([SC_Flange_W, Mock_Flange_T, SC_Flange_H], center=true);
        // screw hole visual marks on flange
        color("DarkGreen", 0.7)
        for (sx=[-1,1])
            translate([sx*(SC_Flange_W/2-3.8), -Mock_Flange_T/2-0.05, flange_bottom_z + SC_Flange_H/2])
                rotate([90,0,0]) cylinder(d=2.5, h=0.5);
    }
}

module long_keeper_plate(count=count_active) {
    // Recalculate to support custom count if this module is reused.
    array_w_local = (count-1)*Holder_Pitch + single_w;
    keeper_w_local = array_w_local + 2*Base_Margin_X + 2*Keeper_End_Overhang_X;
    left_x = -keeper_w_local/2 + Keeper_End_Screw_Inset_X;
    mid_x = 0;
    right_x = keeper_w_local/2 - Keeper_End_Screw_Inset_X;

    difference() {
        cube([keeper_w_local, Keeper_Depth_Y, Keeper_Thickness], center=true);

        // Three screw clearance holes with shallow head recesses.
        for (x=[left_x, mid_x, right_x]) {
            translate([x, 0, -Keeper_Thickness/2-0.1])
                cylinder(d=Keeper_Screw_Dia, h=Keeper_Thickness+0.3);
            translate([x, 0, Keeper_Thickness/2-Keeper_Screw_Head_Depth])
                cylinder(d=Keeper_Screw_Head_Dia, h=Keeper_Screw_Head_Depth+0.2);
        }

        // Underside relief at each coupler BODY only.
        // It does not remove material above the flange ears, so the keeper can retain the coupler.
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
    count = count_active;

    common_base_plate();

    for (i=[0:count-1]) {
        translate([(i-(count-1)/2)*Holder_Pitch, 0, 0])
            single_holder_without_base(Show_Mock_Couplers);
    }

    long_keeper_screw_bosses(count);

    if (Show_Long_Keeper_Installed) {
        translate([0,0,keeper_underside_z + Keeper_Thickness/2])
            long_keeper_plate(count);
    }

    if (Show_Long_Keeper_Separate) {
        translate([0, -Base_Depth_Y - 16, Keeper_Thickness/2])
            long_keeper_plate(count);
    }
}

holder_array();
