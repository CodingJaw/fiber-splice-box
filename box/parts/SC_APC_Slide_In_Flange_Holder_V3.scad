/*
  SC/APC Simplex Coupler Holder - V3 Slide-In Flange Capture

  Purpose:
  - For SC/APC female-to-female simplex flange adapters/couplers.
  - The connector is NOT forced through a thick hole.
  - The side ears/flange slide down vertically into two capture rails.
  - A small screw-down top keeper plate prevents the coupler from lifting out.

  Coordinate idea:
  - Coupler plugs face front/back along the Y axis.
  - Coupler flange/ears sit in the X-Z plane.
  - Coupler slides down along Z into the side grooves.

  Print this first as a test holder.  Adjust the parameters below after test fitting.
*/

$fn = 48;

/* [Preview] */
Show_Two_Holders = true;
Show_Mock_Couplers = true;
Show_Top_Keeper_Installed = true;
Show_Top_Keeper_Separate = true;

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
Rail_Extra_H = 4.0;
// How far each flange ear slides into each side rail.
Groove_Depth_X = 3.2;
// Front/back lip thickness around the flange slot. Larger = stronger, smaller = looser.
Groove_Lip_Y = 2.3;
Back_Spine_Thickness_Y = 3.0;
Back_Spine_H = 21.0;

/* [Top screw-down keeper plate] */
Keeper_Thickness = 2.4;
Keeper_Overhang_X = 4.0;
Keeper_Depth_Y = 10.0;
Keeper_Clearance_Z = 0.30;
Keeper_Screw_Dia = 3.2;       // M3 clearance
Keeper_Screw_Head_Dia = 6.2;  // light countersink/counterbore preview
Keeper_Screw_Head_Depth = 1.2;
Screw_Boss_Dia = 7.5;
Screw_Boss_H = 7.5;
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
rail_center_x = (SC_Body_Clear_W/2) + Groove_Depth_X + (Rail_W - Groove_Depth_X)/2;
single_w = SC_Body_Clear_W + 2*Rail_W + 2*Groove_Depth_X;
base_w = single_w + 2*Base_Margin_X;
base_y0 = -Base_Depth_Y/2;

module rounded_box(size=[10,10,10], r=1.2) {
    // Simple light-rounded block using minkowski. Keep radius small for preview speed.
    minkowski() {
        cube([size[0]-2*r, size[1]-2*r, size[2]-2*r], center=true);
        sphere(r=r);
    }
}

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

        // chamfer/lead-in at top of groove to make insertion easier
        translate([
            inner_x + side*(Groove_Depth_X/2),
            0,
            Base_Thickness + rail_h - 1.1
        ])
            rotate([0,45*side,0]) cube([Groove_Depth_X*1.6, slot_y+0.4, 3.2], center=true);
    }
}

module screw_boss_pair() {
    for (sx=[-1,1]) {
        translate([sx*(SC_Body_Clear_W/2 + Rail_W/2), 0, Base_Thickness + rail_h + Screw_Boss_H/2 - 0.1])
        difference() {
            cylinder(d=Screw_Boss_Dia, h=Screw_Boss_H, center=true);
            translate([0,0,-Screw_Boss_H/2-0.1]) cylinder(d=Screw_Pilot_Dia, h=Screw_Boss_H+0.3);
        }
    }
}

module rear_spine() {
    // A low rear spine ties the two rails together while leaving the coupler body area open.
    translate([0, Rail_Depth_Y/2 - Back_Spine_Thickness_Y/2, Base_Thickness + Back_Spine_H/2])
    difference() {
        cube([single_w, Back_Spine_Thickness_Y, Back_Spine_H], center=true);
        // Center body clearance cutout through the spine
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

module top_keeper_plate() {
    keeper_w = SC_Body_Clear_W + 2*Rail_W + 2*Keeper_Overhang_X;
    difference() {
        translate([0,0,0])
            cube([keeper_w, Keeper_Depth_Y, Keeper_Thickness], center=true);
        for (sx=[-1,1]) {
            translate([sx*(SC_Body_Clear_W/2 + Rail_W/2), 0, -Keeper_Thickness/2-0.1])
                cylinder(d=Keeper_Screw_Dia, h=Keeper_Thickness+0.3);
            translate([sx*(SC_Body_Clear_W/2 + Rail_W/2), 0, Keeper_Thickness/2-Keeper_Screw_Head_Depth])
                cylinder(d=Keeper_Screw_Head_Dia, h=Keeper_Screw_Head_Depth+0.2);
        }
        // Small center relief so it acts as a keeper, not a hard clamp on the adapter body.
        translate([0,0,0]) cube([SC_Body_Clear_W, Keeper_Depth_Y+0.3, Keeper_Thickness+0.4], center=true);
    }
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

module single_holder(show_mock=true, show_keeper=true) {
    base_plate();
    side_capture_rail(-1);
    side_capture_rail(1);
    rear_spine();
    screw_boss_pair();

    if (show_keeper) {
        translate([0,0,Base_Thickness + rail_h + Screw_Boss_H + Keeper_Thickness/2 + Keeper_Clearance_Z])
            top_keeper_plate();
    }

    if (show_mock) mock_sc_coupler();
}

module holder_array() {
    count = Show_Two_Holders ? Holder_Count : 1;
    for (i=[0:count-1]) {
        translate([(i-(count-1)/2)*Holder_Pitch, 0, 0])
            single_holder(Show_Mock_Couplers, Show_Top_Keeper_Installed);
    }
}

holder_array();

if (Show_Top_Keeper_Separate) {
    // A separate keeper plate shown in front for test printing or inspection.
    translate([0, -Base_Depth_Y - 14, Keeper_Thickness/2])
        top_keeper_plate();
}
