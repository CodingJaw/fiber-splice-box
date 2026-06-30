/*
  SC/APC Simplex Coupler Holder - V6 Corrected Mock + Corrected Ear Slots

  Purpose:
  - Standalone test holder for two SC/APC female-to-female simplex flange adapters/couplers.
  - The connector flange/ears slide DOWN into side capture rails.
  - A single long screw-down keeper plate spans BOTH connectors.
  - Three keeper screws: left end, center, right end.

  V6 corrections:
  - The mock coupler dimensions now directly drive from the same SC_* dimensions as the holder.
  - The side capture slots now match the actual flange ear zones instead of using a too-small groove.
  - The flange is modeled as one thin rectangular plate across the connector, with the side rails open toward the center.
  - Rail slots capture the flange by thickness front/back, while leaving the center body path clear.
  - Screw bosses are height-matched to the keeper underside.
  - Rail/carrier tops are lower than the keeper underside so the keeper plate can sit down.
*/

$fn = 48;

/* [Preview] */
Show_Two_Holders = true;
Show_Mock_Couplers = true;
Show_Long_Keeper_Installed = true;
Show_Long_Keeper_Separate = true;
Show_Clearance_Silhouette = false;

/* [SC/APC coupler measured dimensions] */
// Overall flange width across both ears.
SC_Flange_W = 22.0;
// Flange height from bottom edge to top edge.
SC_Flange_H = 17.0;
// Thickness of the flange plate/ears along plug direction.
SC_Flange_T = 2.1;

// Center body size. This is the rectangular plug body that must remain clear.
SC_Body_W = 9.3;
SC_Body_H = 13.0;
SC_Body_Depth_Y = 28.0;

// Holder center clearance window. Keep this slightly larger than SC_Body_W.
SC_Body_Clear_W = 10.8;
SC_Body_Clear_H = 13.8;

// General print/fit clearance.
SC_Clearance = 0.35;

/* [Holder layout] */
Holder_Count = 2;
Holder_Pitch = 30.0;

Base_Thickness = 3.0;
Base_Depth_Y = 26.0;
Base_Margin_X = 5.0;
Base_End_Extra_X = 7.0;
Base_Boss_Margin_X = 2.5;

Bottom_Stop_H = 2.2;
Rail_Depth_Y = 9.0;
Rail_Outer_Wall_X = 1.8;
Groove_Lip_Y = 2.4;          // front/back material left around flange thickness slot
Carrier_Top_Relief_Z = 0.30; // rails stop below keeper underside

Back_Spine_Thickness_Y = 3.0;
Back_Spine_H = 18.0;

/* [Long screw-down keeper plate] */
Keeper_Thickness = 2.6;
Keeper_Depth_Y = 12.0;
Keeper_End_Overhang_X = 6.0;
Keeper_Flange_Clearance_Z = 0.20;

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

/* [Mock colors] */
Mock_Color = "LimeGreen";
Mock_Alpha = 0.55;

// ---------- Derived dimensions ----------
count_active = Show_Two_Holders ? Holder_Count : 1;

flange_ear_w = (SC_Flange_W - SC_Body_Clear_W) / 2;
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
slot_y = SC_Flange_T + SC_Clearance;
boss_h = keeper_underside_z - Base_Thickness;

// ---------- Modules ----------
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
    // side = +1 right rail, -1 left rail.
    // The rail starts at the center body clearance edge and extends outward past the flange ear.
    // The slot is open toward the center so the full flange plate does not collide with an inner wall.

    body_edge = SC_Body_Clear_W/2;
    rail_center_x = side * (body_edge + rail_block_w/2 - SC_Clearance/2);

    slot_center_x = side * (body_edge + flange_ear_w/2);
    slot_w_x = flange_ear_w + SC_Clearance + 0.30;

    difference() {
        translate([rail_center_x, 0, Base_Thickness + rail_h/2])
            cube([rail_block_w, Rail_Depth_Y, rail_h], center=true);

        // Vertical flange-ear slot. Open at the top and open toward the center.
        translate([slot_center_x, 0, flange_bottom_z + (rail_top_z - flange_bottom_z)/2])
            cube([slot_w_x, slot_y, rail_top_z - flange_bottom_z + 1.2], center=true);

        // Top lead-in to ease sliding the flange down into the rails.
        translate([slot_center_x, 0, rail_top_z - 0.45])
            cube([slot_w_x + 0.6, slot_y + 0.8, 1.4], center=true);
    }
}

module rear_spine() {
    spine_h = min(Back_Spine_H, rail_h);
    translate([0, Rail_Depth_Y/2 - Back_Spine_Thickness_Y/2, Base_Thickness + spine_h/2])
    difference() {
        cube([single_w, Back_Spine_Thickness_Y, spine_h], center=true);

        // Clear the center coupler body.
        translate([0,0,Bottom_Stop_H + SC_Body_Clear_H/2])
            cube([SC_Body_Clear_W + SC_Clearance, Back_Spine_Thickness_Y+0.5, SC_Body_Clear_H + SC_Clearance], center=true);
    }
}

module single_holder_without_base(show_mock=true) {
    // Bottom ledge/stop under the flange.
    translate([0, 0, Base_Thickness + Bottom_Stop_H/2])
        cube([single_w, Rail_Depth_Y, Bottom_Stop_H], center=true);

    side_capture_rail(-1);
    side_capture_rail(1);
    rear_spine();

    if (Show_Clearance_Silhouette) clearance_silhouette();
    if (show_mock) mock_sc_coupler();
}

module mock_sc_coupler() {
    // This mock now matches the holder dimensions:
    // - flange uses SC_Flange_W/H/T
    // - body uses SC_Body_W/H/Depth_Y
    color(Mock_Color, Mock_Alpha) {
        // Center rectangular body through front/back.
        translate([0,0,flange_bottom_z + SC_Flange_H/2])
            cube([SC_Body_W, SC_Body_Depth_Y, SC_Body_H], center=true);

        // Thin flange plate across the connector.
        translate([0,0,flange_bottom_z + SC_Flange_H/2])
            cube([SC_Flange_W, SC_Flange_T, SC_Flange_H], center=true);

        // Small raised front/back collars only for visual reference.
        translate([0, SC_Flange_T/2 + 0.7, flange_bottom_z + SC_Flange_H/2])
            cube([SC_Body_W + 1.0, 1.4, SC_Body_H + 1.0], center=true);
        translate([0, -SC_Flange_T/2 - 0.7, flange_bottom_z + SC_Flange_H/2])
            cube([SC_Body_W + 1.0, 1.4, SC_Body_H + 1.0], center=true);
    }

    // Screw hole marks on the flange face only. These are visual; they are not part of holder fit.
    color("DarkGreen", 0.85)
    for (sx=[-1,1]) {
        translate([sx*(SC_Flange_W/2-3.8), -SC_Flange_T/2-0.06, flange_bottom_z + SC_Flange_H/2])
            rotate([90,0,0]) cylinder(d=2.4, h=0.5);
    }
}

module clearance_silhouette() {
    color("Orange", 0.20) {
        translate([0,0,flange_bottom_z + SC_Flange_H/2])
            cube([SC_Flange_W + SC_Clearance, SC_Flange_T + SC_Clearance, SC_Flange_H + SC_Clearance], center=true);
        translate([0,0,flange_bottom_z + SC_Flange_H/2])
            cube([SC_Body_Clear_W, SC_Body_Depth_Y, SC_Body_Clear_H], center=true);
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

        // Three screw clearance holes and shallow head recesses.
        for (x=[left_x, mid_x, right_x]) {
            translate([x, 0, -Keeper_Thickness/2-0.1])
                cylinder(d=Keeper_Screw_Dia, h=Keeper_Thickness+0.3);
            translate([x, 0, Keeper_Thickness/2-Keeper_Screw_Head_Depth])
                cylinder(d=Keeper_Screw_Head_Dia, h=Keeper_Screw_Head_Depth+0.2);
        }

        // Underside body relief only in the center body zone.
        // The flange-ear zones stay solid so the keeper actually holds the adapters down.
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
