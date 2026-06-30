/*
  Fiber bottom cable clamp - restarted clean V1

  Purpose:
  - Removable 2-piece clamp for each cable.
  - Assembled front nose fits into a 1/2 inch wall hole and protrudes 1mm.
  - Cable stays centered in the 1/2 inch hole.
  - When screws are removed, upper and lower halves come off the cable.
  - Print layout shows separate loose pieces with cable grooves facing upward.

  Units: mm
*/

$fn = 72;

/* [Display] */
Show_Assembled = false;      // false = print layout, true = assembled preview
Clamp_Count = 2;             // 1 or 2
Show_Mock_Wall = false;
Show_Mock_Cables = false;

/* [Cable and wall] */
Entry_Hole_Dia = 12.7;       // 1/2 inch hole
Hole_Clearance = 0.35;       // clearance around printed bushing
Cable_Dia = 5.2;             // measured outer sheath, adjust after test
Cable_Compression = 0.20;    // makes groove slightly smaller than cable
Wall_Thickness = 2.4;
Bushing_Protrusion = 1.0;    // sticks into/out through 1/2 inch hole
Bushing_InBox_Depth = 5.0;   // additional round bushing length inside box

/* [Clamp body] */
Clamp_Depth = 17.0;          // length from wall inward
Clamp_Width = 25.0;          // total width across screw ears
Clamp_Half_Height = 6.4;     // height of each half from split line
Part_Gap = 18.0;             // spacing for print layout

/* [Screws] */
Screw_Dia = 3.2;             // M3 clearance in top half
Lower_Pilot_Dia = 2.6;       // pilot/tap hole in lower half
Screw_Head_Dia = 6.3;        // optional countersink/counterbore preview
Screw_Head_Depth = 1.8;
Screw_Y = 8.6;               // screws are +/- this from cable centerline
Screw_X = 10.0;              // screw distance inside box from wall face

/* [Alignment pins] */
Align_Pin_Dia = 2.2;
Align_Pin_Clearance = 0.25;
Align_Pin_Height = 2.0;
Align_Pin_X = 15.0;
Align_Pin_Y = 5.8;

/* [Derived] */
Bushing_Dia = Entry_Hole_Dia - Hole_Clearance;
Cable_Groove_Dia = Cable_Dia - Cable_Compression;
Bushing_Total_Depth = Bushing_Protrusion + Bushing_InBox_Depth;
Total_Depth = Bushing_Total_Depth + Clamp_Depth;

// Coordinate notes for assembled view:
// X axis = cable direction. Wall hole center is at X=0.
// Bushing extends from X=-Bushing_Protrusion to X=Bushing_InBox_Depth.
// Clamp body extends farther into the box in +X.
// Z=0 is the split line and cable centerline.
// Lower half is below Z=0. Upper half is above Z=0.

module cyl_x(d, h, center=false) {
    rotate([0,90,0]) cylinder(d=d, h=h, center=center);
}

module cable_cut(extra=1) {
    translate([-Bushing_Protrusion-extra,0,0])
        cyl_x(d=Cable_Groove_Dia, h=Total_Depth + 2*extra, center=false);
}

module bushing_round_half(upper=false) {
    intersection() {
        translate([-Bushing_Protrusion,0,0])
            cyl_x(d=Bushing_Dia, h=Bushing_Total_Depth, center=false);
        if (upper)
            translate([-Bushing_Protrusion-0.1, -Bushing_Dia/2-1, 0])
                cube([Bushing_Total_Depth+0.2, Bushing_Dia+2, Bushing_Dia/2+1], center=false);
        else
            translate([-Bushing_Protrusion-0.1, -Bushing_Dia/2-1, -Bushing_Dia/2-1])
                cube([Bushing_Total_Depth+0.2, Bushing_Dia+2, Bushing_Dia/2+1], center=false);
    }
}

module clamp_body_half(upper=false) {
    // Rectangular screw-ear body only inside the box.  It is intentionally open around the cable groove.
    if (upper) {
        translate([Bushing_InBox_Depth, -Clamp_Width/2, 0])
            cube([Clamp_Depth, Clamp_Width, Clamp_Half_Height], center=false);
    } else {
        translate([Bushing_InBox_Depth, -Clamp_Width/2, -Clamp_Half_Height])
            cube([Clamp_Depth, Clamp_Width, Clamp_Half_Height], center=false);
    }
}

module screw_holes_upper() {
    for (y=[-Screw_Y, Screw_Y]) {
        translate([Bushing_InBox_Depth + Screw_X, y, -0.2])
            cylinder(d=Screw_Dia, h=Clamp_Half_Height+0.6, center=false);
        translate([Bushing_InBox_Depth + Screw_X, y, Clamp_Half_Height - Screw_Head_Depth])
            cylinder(d=Screw_Head_Dia, h=Screw_Head_Depth+0.3, center=false);
    }
}

module screw_holes_lower() {
    for (y=[-Screw_Y, Screw_Y]) {
        translate([Bushing_InBox_Depth + Screw_X, y, -Clamp_Half_Height-0.3])
            cylinder(d=Lower_Pilot_Dia, h=Clamp_Half_Height+0.6, center=false);
    }
}

module alignment_pins_lower() {
    for (y=[-Align_Pin_Y, Align_Pin_Y]) {
        translate([Bushing_InBox_Depth + Align_Pin_X, y, 0])
            cylinder(d=Align_Pin_Dia, h=Align_Pin_Height, center=false);
    }
}

module alignment_pin_holes_upper() {
    for (y=[-Align_Pin_Y, Align_Pin_Y]) {
        translate([Bushing_InBox_Depth + Align_Pin_X, y, -0.2])
            cylinder(d=Align_Pin_Dia + Align_Pin_Clearance, h=Align_Pin_Height+0.6, center=false);
    }
}

module lower_half_assembled() {
    difference() {
        union() {
            bushing_round_half(false);
            clamp_body_half(false);
            alignment_pins_lower();
        }
        cable_cut(1.0);
        screw_holes_lower();
        // small relief along the split line so the halves clamp the cable before plastic touches plastic
        translate([-Bushing_Protrusion-0.5, -Clamp_Width/2-0.5, -0.05])
            cube([Total_Depth+1, Clamp_Width+1, 0.10], center=false);
    }
}

module upper_half_assembled() {
    difference() {
        union() {
            bushing_round_half(true);
            clamp_body_half(true);
        }
        cable_cut(1.0);
        screw_holes_upper();
        alignment_pin_holes_upper();
        // small relief along the split line so the halves clamp the cable before plastic touches plastic
        translate([-Bushing_Protrusion-0.5, -Clamp_Width/2-0.5, -0.05])
            cube([Total_Depth+1, Clamp_Width+1, 0.10], center=false);
    }
}

module one_clamp_assembled() {
    lower_half_assembled();
    upper_half_assembled();
}

module lower_half_print() {
    // already prints flat with groove facing upward
    translate([0,0,Clamp_Half_Height]) lower_half_assembled();
}

module upper_half_print() {
    // flip upper half so its cable groove faces upward on the build plate
    translate([0,0,Clamp_Half_Height])
        rotate([180,0,0]) upper_half_assembled();
}

module print_layout() {
    pitch_x = Total_Depth + Part_Gap;
    pitch_y = Clamp_Width + Part_Gap;

    // Row 1: lower halves
    for (i=[0:Clamp_Count-1]) {
        translate([i*pitch_x, 0, 0]) lower_half_print();
    }

    // Row 2: upper halves, same orientation/grooves up, clearly separate
    for (i=[0:Clamp_Count-1]) {
        translate([i*pitch_x, pitch_y, 0]) upper_half_print();
    }
}

module assembled_layout() {
    pitch_y = Clamp_Width + 12;
    for (i=[0:Clamp_Count-1]) {
        translate([0, i*pitch_y, 0]) one_clamp_assembled();
    }

    if (Show_Mock_Wall) {
        color([0.85,0.85,0.85,0.35])
        difference() {
            translate([-Wall_Thickness-Bushing_Protrusion, -Clamp_Width/2-4, -Entry_Hole_Dia/2-4])
                cube([Wall_Thickness, Clamp_Count*pitch_y + Clamp_Width + 8, Entry_Hole_Dia+8], center=false);
            for (i=[0:Clamp_Count-1]) {
                translate([-Wall_Thickness-Bushing_Protrusion-0.1, i*pitch_y, 0])
                    cyl_x(d=Entry_Hole_Dia, h=Wall_Thickness+0.2, center=false);
            }
        }
    }

    if (Show_Mock_Cables) {
        color([0.1,0.1,0.1,0.65])
        for (i=[0:Clamp_Count-1]) {
            translate([-Bushing_Protrusion-10, i*pitch_y, 0])
                cyl_x(d=Cable_Dia, h=Total_Depth+30, center=false);
        }
    }
}

if (Show_Assembled)
    assembled_layout();
else
    print_layout();

