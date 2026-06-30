/*
  Fiber Bottom Cable Clamp Test - V1

  Standalone test part for the outdoor fiber connection box bottom cable clamps.

  Design intent:
  - Two 1/2 in cable entry holes are represented by a mock wall.
  - Two 5 mm fiber cable sheaths enter through the holes and run into the box.
  - A printed lower saddle supports the cables.
  - A removable screw-down clamp bar captures both cables from above.
  - No SC connector holders are included in this file.

  Print/test notes:
  - For first fit test, leave Show_Mock_Wall and Show_Mock_Cables enabled.
  - For printing the actual clamp pieces, set Show_Mock_Wall=false and Show_Mock_Cables=false.
  - Set Show_Clamp_Bar_Separate=true if you want the top clamp bar placed in front as a separate printable part.
*/

$fn = 48;

// -----------------------------
// Preview / print controls
// -----------------------------
Show_Mock_Wall          = true;
Show_Mock_Cables        = true;
Show_Clamp_Bar_Separate = false;
Explode_Preview         = false;

// -----------------------------
// Cable / wall settings
// -----------------------------
Cable_Dia               = 5.2;      // measured outer sheath target, mm
Cable_Clearance         = 0.35;     // clearance in saddle and bar grooves
Entry_Hole_Dia          = 12.7;     // 1/2 inch bottom entry holes
Entry_Hole_Spacing      = 30.0;     // center-to-center spacing between the two holes/cables
Mock_Wall_Thickness     = 3.0;
Mock_Wall_Width         = 52.0;
Mock_Wall_Height        = 24.0;
Entry_Hole_Center_Z     = 12.0;

// -----------------------------
// Lower clamp saddle settings
// -----------------------------
Base_L                  = 34.0;     // cable direction length
Base_W                  = 48.0;     // across both cables
Base_T                  = 3.0;
Base_Radius             = 2.0;
Saddle_Block_L          = 22.0;
Saddle_Block_W          = 11.0;
Saddle_Block_H          = 6.0;
Saddle_Start_X          = 10.0;     // distance from inside wall face to saddle center area

// -----------------------------
// Top clamp bar settings
// -----------------------------
Clamp_Bar_L             = 24.0;
Clamp_Bar_W             = 48.0;
Clamp_Bar_T             = 3.5;
Clamp_Bar_Z             = Base_T + Saddle_Block_H + 0.15;
Clamp_Bar_Radius        = 1.5;
Underside_Groove_Depth  = 2.2;      // should be less than Cable_Dia/2 for grip

// -----------------------------
// Screw settings
// -----------------------------
Screw_Dia               = 3.0;      // M3 clearance/pilot depending print settings
Screw_Boss_Dia          = 7.2;
Screw_Boss_H            = Saddle_Block_H;
Screw_X_Offset          = 0.0;
Screw_Y_Positions       = [ -21.0, -9.0, 9.0, 21.0 ];  // four screws across the shared clamp bar
Countersink_Dia         = 6.2;
Countersink_Depth       = 1.4;

// -----------------------------
// Layout coordinates
// -----------------------------
Inside_Wall_X           = 0;
Base_Center_X           = Inside_Wall_X + Base_L/2 + 2;
Saddle_Center_X         = Inside_Wall_X + Saddle_Start_X + Saddle_Block_L/2;
Cable_Z                 = Base_T + Cable_Dia/2 + 0.65;
Cable_Ys                = [ -Entry_Hole_Spacing/2, Entry_Hole_Spacing/2 ];

// Main view
if (Show_Mock_Wall) mock_wall_with_entry_holes();

fiber_dual_cable_clamp_base();

if (Show_Clamp_Bar_Separate) {
    translate([Base_Center_X, -Base_W/2 - 18, Base_T + 0.2])
        top_clamp_bar();
} else {
    translate([Base_Center_X, 0, Clamp_Bar_Z + (Explode_Preview ? 8 : 0)])
        top_clamp_bar();
}

if (Show_Mock_Cables) mock_cables();

// -----------------------------
// Modules
// -----------------------------
module fiber_dual_cable_clamp_base(){
    difference(){
        union(){
            // one continuous floor pad for both cable clamps
            translate([Base_Center_X, 0, Base_T/2])
                rounded_box([Base_L, Base_W, Base_T], Base_Radius);

            // lower cable saddles, one under each cable
            for (y = Cable_Ys){
                translate([Saddle_Center_X, y, Base_T + Saddle_Block_H/2])
                    rounded_box([Saddle_Block_L, Saddle_Block_W, Saddle_Block_H], 1.2);
            }

            // screw bosses rising from the base, aligned with clamp bar holes
            for (y = Screw_Y_Positions){
                translate([Base_Center_X + Screw_X_Offset, y, Base_T])
                    cylinder(h=Screw_Boss_H, d=Screw_Boss_Dia, center=false);
            }
        }

        // lower cable half-round grooves
        for (y = Cable_Ys){
            translate([Saddle_Center_X, y, Cable_Z])
                rotate([0,90,0])
                    cylinder(h=Saddle_Block_L + 1.0, d=Cable_Dia + Cable_Clearance, center=true);
        }

        // vertical screw pilot holes in base/bosses
        for (y = Screw_Y_Positions){
            translate([Base_Center_X + Screw_X_Offset, y, Base_T - 0.2])
                cylinder(h=Screw_Boss_H + Base_T + 0.6, d=Screw_Dia, center=false);
        }
    }
}

module top_clamp_bar(){
    difference(){
        translate([0,0,Clamp_Bar_T/2])
            rounded_box([Clamp_Bar_L, Clamp_Bar_W, Clamp_Bar_T], Clamp_Bar_Radius);

        // underside cable grooves. These are shallow so the bar clamps the 5 mm sheath.
        for (y = Cable_Ys){
            translate([0, y, -0.01])
                rotate([0,90,0])
                    cylinder(h=Clamp_Bar_L + 1.0, d=Cable_Dia + Cable_Clearance, center=true);
        }

        // screw holes through the bar
        for (y = Screw_Y_Positions){
            translate([Screw_X_Offset, y, -0.2])
                cylinder(h=Clamp_Bar_T + 0.6, d=Screw_Dia + 0.3, center=false);
            // light countersink/counterbore on top face
            translate([Screw_X_Offset, y, Clamp_Bar_T - Countersink_Depth])
                cylinder(h=Countersink_Depth + 0.3, d=Countersink_Dia, center=false);
        }
    }
}

module mock_wall_with_entry_holes(){
    difference(){
        // mock wall is only for visual alignment to the box bottom/narrow wall
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
        translate([Base_Center_X + 2, y, Cable_Z])
            rotate([0,90,0])
                cylinder(h=Base_L + 18, d=Cable_Dia, center=true);
    }
}

module rounded_box(size=[10,10,10], r=1){
    // 2D rounded rectangle extruded in Z. Reliable and fast for this test part.
    sx = size[0]; sy = size[1]; sz = size[2];
    linear_extrude(height=sz, center=true)
        offset(r=r)
            square([sx-2*r, sy-2*r], center=true);
}
