/*
  Fiber Bottom Cable Clamp Test - V2 Centered Open Clamp

  Purpose:
  - Standalone test part for the two bottom cable clamps only.
  - Keeps each 5 mm fiber cable centered with the 1/2 inch box entry hole.
  - Removes the closed box around the wire so the clamp bar can actually tighten.

  Design intent:
  - Two 1/2 inch entry holes are shown in a mock wall for alignment only.
  - Cable centerline height is exactly the same as the entry-hole center height.
  - Lower saddles are open-top half-round supports, not enclosed tunnels.
  - Top clamp bar has matching underside half-round grooves.
  - Screw bosses are outside the cable paths and stop below the clamp bar so they do not hold the bar up.

  Print/test notes:
  - For visual checking, leave Show_Mock_Wall and Show_Mock_Cables enabled.
  - For printing the real clamp, set Show_Mock_Wall=false and Show_Mock_Cables=false.
  - Use Show_Clamp_Bar_Separate=true to print/check the top clamp bar as a separate part.
*/

$fn = 64;

// -----------------------------
// Preview / print controls
// -----------------------------
Show_Mock_Wall          = true;
Show_Mock_Cables        = true;
Show_Clamp_Bar_Separate = false;
Explode_Preview         = false;

// -----------------------------
// Cable / entry-hole settings
// -----------------------------
Cable_Dia               = 5.2;      // measured outer sheath target, mm
Cable_Clearance         = 0.25;     // fit clearance in grooves
Cable_Compression       = 0.25;     // how far the clamp bar sits into the theoretical cable circle
Entry_Hole_Dia          = 12.7;     // 1/2 inch bottom entry holes
Entry_Hole_Spacing      = 30.0;     // center-to-center spacing between the two holes/cables
Entry_Hole_Center_Z     = 12.0;     // cable centerline height; matches the hole center

// -----------------------------
// Mock wall settings
// -----------------------------
Mock_Wall_Thickness     = 3.0;
Mock_Wall_Width         = 56.0;
Mock_Wall_Height        = 28.0;

// -----------------------------
// Lower clamp base / saddle settings
// X direction = cable direction into box
// Y direction = spacing across the two cables
// Z direction = vertical
// -----------------------------
Base_L                  = 38.0;
Base_W                  = 56.0;
Base_T                  = 3.0;
Base_Radius             = 2.0;
Base_Back_From_Wall_X   = 3.0;      // gap from inside wall face to base

Saddle_L                = 26.0;
Saddle_W                = 10.5;
Saddle_Radius           = 1.4;
Saddle_Start_From_Wall  = 8.0;

// The lower saddle top is slightly above cable center, then the half-round is cut out.
// This creates a locating cradle without making a closed box around the cable.
Lower_Saddle_OverCenter = 0.20;

// -----------------------------
// Top clamp bar settings
// -----------------------------
Clamp_Bar_L             = 29.0;
Clamp_Bar_W             = 56.0;
Clamp_Bar_T             = 4.0;
Clamp_Bar_Radius        = 1.5;
Clamp_Bar_Overhang_X    = 1.5;

// -----------------------------
// Screw settings
// Four screws are outside the two cable paths.
// Boss tops stop below the clamp bar so they cannot prevent tightening.
// -----------------------------
Screw_Dia               = 3.1;      // M3 clearance through top clamp
Thread_Pilot_Dia        = 2.4;      // pilot hole in printed lower bosses for M3/self tapping
Screw_Boss_Dia          = 7.5;
Boss_Clearance_To_Bar   = 0.70;     // vertical gap below clamp bar when assembled
Counterbore_Dia         = 6.3;
Counterbore_Depth       = 1.6;

Screw_X_Offset_From_Center = 10.0;  // two rows along cable direction
Screw_Y_Offset             = 23.0;  // outside the two cable saddles

// -----------------------------
// Derived layout values
// -----------------------------
Inside_Wall_X           = 0;
Base_Center_X           = Inside_Wall_X + Base_Back_From_Wall_X + Base_L/2;
Saddle_Center_X         = Inside_Wall_X + Saddle_Start_From_Wall + Saddle_L/2;
Clamp_Center_X          = Saddle_Center_X + Clamp_Bar_Overhang_X;
Cable_Z                 = Entry_Hole_Center_Z;
Cable_Ys                = [ -Entry_Hole_Spacing/2, Entry_Hole_Spacing/2 ];
Groove_Dia              = Cable_Dia + Cable_Clearance;
Lower_Saddle_H          = (Cable_Z - Base_T) + Lower_Saddle_OverCenter;
Clamp_Bottom_Z          = Cable_Z - Cable_Compression;
Clamp_Assembled_Z       = Clamp_Bottom_Z;
Boss_H                  = max(2, Clamp_Bottom_Z - Boss_Clearance_To_Bar - Base_T);
Screw_Positions         = [
                            [Clamp_Center_X - Screw_X_Offset_From_Center, -Screw_Y_Offset],
                            [Clamp_Center_X + Screw_X_Offset_From_Center, -Screw_Y_Offset],
                            [Clamp_Center_X - Screw_X_Offset_From_Center,  Screw_Y_Offset],
                            [Clamp_Center_X + Screw_X_Offset_From_Center,  Screw_Y_Offset]
                          ];

// -----------------------------
// Main view
// -----------------------------
if (Show_Mock_Wall) mock_wall_with_entry_holes();

fiber_dual_open_cable_clamp_base();

if (Show_Clamp_Bar_Separate) {
    translate([Clamp_Center_X, -Base_W/2 - 18, Base_T + 0.2])
        top_open_clamp_bar();
} else {
    translate([Clamp_Center_X, 0, Clamp_Assembled_Z + (Explode_Preview ? 9 : 0)])
        top_open_clamp_bar();
}

if (Show_Mock_Cables) mock_cables();

// -----------------------------
// Modules
// -----------------------------
module fiber_dual_open_cable_clamp_base(){
    difference(){
        union(){
            // continuous mounting pad
            translate([Base_Center_X, 0, Base_T/2])
                rounded_box([Base_L, Base_W, Base_T], Base_Radius);

            // open lower half-round saddles, one per cable
            for (y = Cable_Ys){
                translate([Saddle_Center_X, y, Base_T + Lower_Saddle_H/2])
                    rounded_box([Saddle_L, Saddle_W, Lower_Saddle_H], Saddle_Radius);
            }

            // screw bosses outside the cable paths; these do not touch the cable
            for (p = Screw_Positions){
                translate([p[0], p[1], Base_T])
                    cylinder(h=Boss_H, d=Screw_Boss_Dia, center=false);
            }
        }

        // open cable cradles.  Because the saddle top is near cable centerline,
        // this does not form a closed tunnel or box around the cable.
        for (y = Cable_Ys){
            translate([Saddle_Center_X, y, Cable_Z])
                rotate([0,90,0])
                    cylinder(h=Saddle_L + 1.2, d=Groove_Dia, center=true);
        }

        // relief below the cable path so only the cradle remains, no front/back wall blocks tightening
        for (y = Cable_Ys){
            translate([Saddle_Center_X, y, Cable_Z + Groove_Dia/2])
                cube([Saddle_L + 1.5, Saddle_W + 0.6, Groove_Dia], center=true);
        }

        // pilot holes in lower screw bosses
        for (p = Screw_Positions){
            translate([p[0], p[1], Base_T - 0.2])
                cylinder(h=Boss_H + 0.6, d=Thread_Pilot_Dia, center=false);
        }
    }
}

module top_open_clamp_bar(){
    difference(){
        translate([0,0,Clamp_Bar_T/2])
            rounded_box([Clamp_Bar_L, Clamp_Bar_W, Clamp_Bar_T], Clamp_Bar_Radius);

        // underside grooves only.  The bar can move down and pinch the cable.
        for (y = Cable_Ys){
            translate([0, y, 0])
                rotate([0,90,0])
                    cylinder(h=Clamp_Bar_L + 1.2, d=Groove_Dia, center=true);
        }

        // through holes and top counterbores
        for (p = Screw_Positions){
            local_x = p[0] - Clamp_Center_X;
            local_y = p[1];

            translate([local_x, local_y, -0.2])
                cylinder(h=Clamp_Bar_T + 0.6, d=Screw_Dia, center=false);

            translate([local_x, local_y, Clamp_Bar_T - Counterbore_Depth])
                cylinder(h=Counterbore_Depth + 0.3, d=Counterbore_Dia, center=false);
        }
    }
}

module mock_wall_with_entry_holes(){
    difference(){
        translate([-Mock_Wall_Thickness/2, 0, Mock_Wall_Height/2])
            cube([Mock_Wall_Thickness, Mock_Wall_Width, Mock_Wall_Height], center=true);

        for (y = Cable_Ys){
            translate([-Mock_Wall_Thickness/2, y, Entry_Hole_Center_Z])
                rotate([0,90,0])
                    cylinder(h=Mock_Wall_Thickness + 1.0, d=Entry_Hole_Dia, center=true);
        }
    }
}

module mock_cables(){
    for (y = Cable_Ys){
        translate([Base_Center_X + 2.5, y, Cable_Z])
            rotate([0,90,0])
                cylinder(h=Base_L + 22, d=Cable_Dia, center=true);
    }
}

module rounded_box(size=[10,10,10], r=1){
    sx = size[0]; sy = size[1]; sz = size[2];
    linear_extrude(height=sz, center=true)
        offset(r=r)
            square([sx-2*r, sy-2*r], center=true);
}
