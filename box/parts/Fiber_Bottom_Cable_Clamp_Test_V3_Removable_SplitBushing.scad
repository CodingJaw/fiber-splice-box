/*
  Fiber Bottom Cable Clamp Test - V3 Removable Split Bushing Clamp

  Purpose:
  - Standalone test part for bottom cable entry clamps.
  - Each cable clamp is a removable two-piece split bushing/clamp.
  - When assembled with screws, the upper and lower halves form a round outside nose
    that fits the 1/2 inch wall hole and protrudes through it by about 1 mm.
  - When screws are removed, the upper and lower clamp halves separate from the cable
    so a pre-terminated fiber connector can be inserted/removed through the box hole.

  Design intent:
  - Cable centerline is the same as the 1/2 inch hole centerline.
  - No closed tunnel around the cable: the clamp is split into upper/lower removable halves.
  - Two alignment dowel posts per clamp keep the upper/lower halves registered.
  - Two screws per clamp pull the top half down onto the lower half.
  - A small split gap is left between the upper/lower halves so tightening pressure can clamp the 5 mm sheath.

  Coordinate system:
  - X = cable direction through the box wall.
  - Y = left/right spacing between the two cable holes.
  - Z = vertical.
  - Mock wall outside face is at X=0; inside of box is +X.
*/

$fn = 96;

// -----------------------------
// Preview / print controls
// -----------------------------
Show_Mock_Wall      = true;
Show_Mock_Cables    = true;
Show_Assembled      = true;     // true = assembled/alignment preview, false = print layout loose parts
Explode_Preview     = false;    // raises upper halves for visual checking when Show_Assembled=true
Show_Only_One_Clamp = false;    // useful for quicker test prints

// -----------------------------
// Cable / wall-hole settings
// -----------------------------
Cable_Dia               = 5.2;   // measured sheath diameter target
Cable_Clearance         = 0.10;  // groove clearance before screw compression
Cable_Compression       = 0.20;  // top half sits this much into nominal cable circle
Entry_Hole_Dia          = 12.7;  // 1/2 inch
Entry_Hole_Clearance    = 0.35;  // outside bushing clearance for printed fit in hole
Entry_Hole_Spacing      = 30.0;  // center-to-center spacing between two cable holes
Entry_Hole_Center_Z     = 12.0;  // hole and cable center height

// The bushing nose is what partially enters the 1/2 inch box hole.
Bushing_OD              = Entry_Hole_Dia - Entry_Hole_Clearance;
Bushing_Protrude_X      = 1.0;   // protrudes out/into the 1/2 inch hole by 1 mm
Bushing_Grip_Length_X   = 7.0;   // length of the round split bushing section inside the box
Bushing_Total_L_X       = Bushing_Protrude_X + Bushing_Grip_Length_X;

// -----------------------------
// Main clamp body settings
// -----------------------------
Clamp_Back_From_Wall_X  = -Bushing_Protrude_X;  // bushing starts 1 mm into the wall hole
Clamp_Body_L_X          = 18.0;  // rectangular clamp length inside box after the round nose
Clamp_Body_W_Y          = 22.0;  // width of each individual clamp body
Clamp_Body_H_Z          = 13.0;  // total split clamp body height
Split_Gap_Z             = 0.45;  // gap between upper and lower halves for tightening
Corner_R                = 1.3;

// Calculated clamp body locations
Cable_Z                 = Entry_Hole_Center_Z;
Lower_Top_Z             = Cable_Z - Split_Gap_Z/2;
Upper_Bottom_Z          = Cable_Z + Split_Gap_Z/2;
Lower_Z0                = Cable_Z - Clamp_Body_H_Z/2;
Upper_Z1                = Cable_Z + Clamp_Body_H_Z/2;
Lower_H_Z               = Lower_Top_Z - Lower_Z0;
Upper_H_Z               = Upper_Z1 - Upper_Bottom_Z;

Bushing_Center_X        = Clamp_Back_From_Wall_X + Bushing_Total_L_X/2;
Body_Center_X           = Clamp_Back_From_Wall_X + Bushing_Total_L_X + Clamp_Body_L_X/2;
Total_Center_X          = (Clamp_Back_From_Wall_X + Bushing_Total_L_X + Clamp_Body_L_X)/2;

Cable_Ys                = Show_Only_One_Clamp ? [0] : [-Entry_Hole_Spacing/2, Entry_Hole_Spacing/2];

// -----------------------------
// Screw / alignment settings
// -----------------------------
Screw_Dia               = 3.2;   // M3 clearance through upper half
Thread_Pilot_Dia        = 2.35;  // M3/self-tapping pilot in lower half
Screw_Head_Dia          = 6.4;
Screw_Head_Depth        = 2.0;
Screw_Y_Offset          = 7.3;   // screw positions on each side of cable
Screw_X                 = Body_Center_X + 1.0;

Align_Post_Dia          = 2.4;
Align_Post_Clearance    = 0.25;
Align_Post_H            = 2.3;
Align_Y_Offset          = 4.6;   // two alignment posts per clamp, outside cable groove
Align_X                 = Body_Center_X - 5.5;

// -----------------------------
// Mock wall settings
// -----------------------------
Mock_Wall_Thickness     = 3.0;
Mock_Wall_Width         = Show_Only_One_Clamp ? 30.0 : 58.0;
Mock_Wall_Height        = 28.0;

// -----------------------------
// Main display
// -----------------------------
if (Show_Mock_Wall)
    mock_wall_with_entry_holes();

if (Show_Assembled) {
    for (y = Cable_Ys) {
        removable_split_clamp_lower(y);
        translate([0,0, Explode_Preview ? 7 : 0])
            removable_split_clamp_upper(y);
    }
    if (Show_Mock_Cables) mock_cables();
} else {
    // Print layout: lower halves behind, upper halves in front.
    for (i = [0:len(Cable_Ys)-1]) {
        y = Cable_Ys[i];
        translate([0, y, 0]) removable_split_clamp_lower(0);
        translate([0, y - 38, 0]) removable_split_clamp_upper(0);
    }
}

// -----------------------------
// Modules
// -----------------------------
module removable_split_clamp_lower(yc=0){
    difference(){
        union(){
            // lower half of round bushing nose; fits lower half of the 1/2 inch wall hole
            translate([Bushing_Center_X, yc, Cable_Z])
                half_cylinder_x(Bushing_Total_L_X, Bushing_OD, lower=true);

            // lower clamp body
            translate([Body_Center_X, yc, Lower_Z0 + Lower_H_Z/2])
                rounded_box([Clamp_Body_L_X, Clamp_Body_W_Y, Lower_H_Z], Corner_R);

            // alignment posts on lower half
            for (ay = [-Align_Y_Offset, Align_Y_Offset]) {
                translate([Align_X, yc + ay, Lower_Top_Z])
                    cylinder(h=Align_Post_H, d=Align_Post_Dia, center=false);
            }
        }

        // lower cable saddle: open-top half groove
        translate([Total_Center_X, yc, Cable_Z])
            rotate([0,90,0])
                cylinder(h=Bushing_Total_L_X + Clamp_Body_L_X + 2, d=Cable_Dia + Cable_Clearance, center=true);

        // remove everything above the split line so it cannot become a closed tunnel
        translate([Total_Center_X, yc, Cable_Z + 25])
            cube([Bushing_Total_L_X + Clamp_Body_L_X + 4, Clamp_Body_W_Y + 4, 50], center=true);

        // lower screw pilot holes
        for (sy = [-Screw_Y_Offset, Screw_Y_Offset]) {
            translate([Screw_X, yc + sy, Lower_Z0 - 0.2])
                cylinder(h=Lower_H_Z + 0.8, d=Thread_Pilot_Dia, center=false);
        }
    }
}

module removable_split_clamp_upper(yc=0){
    difference(){
        union(){
            // upper half of round bushing nose; fits upper half of the 1/2 inch wall hole
            translate([Bushing_Center_X, yc, Cable_Z])
                half_cylinder_x(Bushing_Total_L_X, Bushing_OD, lower=false);

            // upper clamp body
            translate([Body_Center_X, yc, Upper_Bottom_Z + Upper_H_Z/2])
                rounded_box([Clamp_Body_L_X, Clamp_Body_W_Y, Upper_H_Z], Corner_R);
        }

        // upper cable groove, lowered slightly for sheath compression
        translate([Total_Center_X, yc, Cable_Z - Cable_Compression])
            rotate([0,90,0])
                cylinder(h=Bushing_Total_L_X + Clamp_Body_L_X + 2, d=Cable_Dia + Cable_Clearance, center=true);

        // remove everything below the split line so the top is a separate removable half
        translate([Total_Center_X, yc, Cable_Z - 25])
            cube([Bushing_Total_L_X + Clamp_Body_L_X + 4, Clamp_Body_W_Y + 4, 50], center=true);

        // alignment post receiver holes
        for (ay = [-Align_Y_Offset, Align_Y_Offset]) {
            translate([Align_X, yc + ay, Upper_Bottom_Z - 0.2])
                cylinder(h=Align_Post_H + 0.7, d=Align_Post_Dia + Align_Post_Clearance, center=false);
        }

        // screw clearance holes and counterbores
        for (sy = [-Screw_Y_Offset, Screw_Y_Offset]) {
            translate([Screw_X, yc + sy, Upper_Bottom_Z - 0.3])
                cylinder(h=Upper_H_Z + 0.8, d=Screw_Dia, center=false);
            translate([Screw_X, yc + sy, Upper_Z1 - Screw_Head_Depth])
                cylinder(h=Screw_Head_Depth + 0.4, d=Screw_Head_Dia, center=false);
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
        translate([Total_Center_X + 2.0, y, Cable_Z])
            rotate([0,90,0])
                cylinder(h=Bushing_Total_L_X + Clamp_Body_L_X + 22, d=Cable_Dia, center=true);
    }
}

// A half cylinder along X.  The split is at Z=center.
module half_cylinder_x(len=10, dia=10, lower=true){
    intersection(){
        rotate([0,90,0]) cylinder(h=len, d=dia, center=true);
        if (lower)
            translate([0,0,-dia/4]) cube([len+0.2, dia+0.2, dia/2], center=true);
        else
            translate([0,0,dia/4]) cube([len+0.2, dia+0.2, dia/2], center=true);
    }
}

module rounded_box(size=[10,10,10], r=1){
    sx = size[0]; sy = size[1]; sz = size[2];
    linear_extrude(height=sz, center=true)
        offset(r=r)
            square([max(0.1,sx-2*r), max(0.1,sy-2*r)], center=true);
}
