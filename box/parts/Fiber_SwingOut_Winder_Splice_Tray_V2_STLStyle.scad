/*
Fiber swing-out winder / splice tray - V2 STL-style reference
Standalone test part for the outdoor fiber connection box project.

Goal:
- Tray is the first part seen after the box lid is removed.
- Tray hinges/sings out of the way to expose SC connector holders below.
- Geometry is intentionally low-profile and tray-like, not a hinged cover/lid.
- Based on the uploaded reference tray style: rounded tray, perimeter fiber path,
  internal winding guides, splice sleeve holder, and hinge barrels on one edge.

Print note:
- Print flat as shown. No supports should be required for the tray body.
- Hinge barrels print horizontally; support may be needed depending on printer settings.
  If preferred, set Split_Hinge_Barrels = true to use shorter barrels with less bridging.
*/

$fn = 48;

/* [Tray fit / general] */
Tray_L = 92;                 // X size of tray body, not including hinge barrels
Tray_W = 74;                 // Y size of tray body
Base_T = 2.2;                // tray floor thickness
Corner_R = 11;
Tray_Clearance_From_Box = 3; // reference only
Show_Mock_Box_Opening = false;

/* [Raised routing features] */
Rib_H = 2.1;                 // height above tray floor
Rib_W = 2.1;                 // typical raised wall width
Outer_Rim_W = 2.4;
Retention_Tab_H = 1.2;
Retention_Tab_W = 6;
Retention_Tab_T = 1.1;

/* [Left oval winding loop] */
Loop_L = 50;
Loop_W = 58;
Loop_X = -19;
Loop_Y = 0;
Loop_Wall = 2.2;
Loop_Gap_Angle_Cut = true;

/* [Straight fiber guide lanes] */
Guide_Count = 4;
Guide_L = 56;
Guide_Start_X = -8;
Guide_End_X = 34;
Guide_Spacing = 10;
Guide_Y_Center = 0;
Guide_W = 2.1;

/* [Splice sleeve holder] */
Show_Splice_Holder = true;
Splice_Count = 6;
Splice_Block_L = 42;
Splice_Block_W = 18;
Splice_Block_H = 3.0;
Splice_X = 15;
Splice_Y = -22;
Splice_Slot_W = 2.2;         // groove width for splice sleeve/fiber sleeve
Splice_Slot_Depth = 1.5;

/* [Hinge edge] */
Hinge_On_Right = true;        // true = hinge on +X edge
Hinge_Pin_D = 2.6;            // pin hole diameter
Hinge_OD = 7.6;               // hinge barrel outside diameter
Hinge_Barrel_L = 18;          // length of each barrel along Y
Hinge_Offset_X = 3.8;         // barrel center offset outside tray edge
Hinge_Z = Base_T + Hinge_OD/2 - 0.3;
Hinge_Y_Offset = 26;
Split_Hinge_Barrels = true;   // shorter segmented barrels, closer to printed reference

/* [Pull tab / finger notch] */
Show_Pull_Tab = true;
Pull_Tab_W = 16;
Pull_Tab_L = 8;
Pull_Tab_Hole_D = 4.0;

/* [Preview helpers] */
Show_Fiber_Path = false;
Fiber_D = 1.2;
Show_Hinge_Pin = false;

// ---------- basic 2D helpers ----------
module rounded_rect_2d(l, w, r) {
    rr = min(r, min(l,w)/2 - 0.01);
    hull() {
        translate([ l/2-rr,  w/2-rr]) circle(r=rr);
        translate([-l/2+rr,  w/2-rr]) circle(r=rr);
        translate([ l/2-rr, -w/2+rr]) circle(r=rr);
        translate([-l/2+rr, -w/2+rr]) circle(r=rr);
    }
}

module rounded_box(l, w, h, r, center=false) {
    linear_extrude(height=h, center=center)
        rounded_rect_2d(l,w,r);
}

module slot2d(p1, p2, d) {
    hull() {
        translate(p1) circle(d=d);
        translate(p2) circle(d=d);
    }
}

module raised_slot(p1, p2, d, h) {
    linear_extrude(height=h)
        slot2d(p1,p2,d);
}

module capsule_ring(l, w, wall, h) {
    difference() {
        linear_extrude(height=h) rounded_rect_2d(l,w,w/2);
        translate([0,0,-0.05]) linear_extrude(height=h+0.1)
            rounded_rect_2d(l-2*wall,w-2*wall,(w-2*wall)/2);
        // small breaks so fiber can enter/exit loop; avoids a closed bathtub look
        if (Loop_Gap_Angle_Cut) {
            translate([l/2-4,0,h/2]) rotate([0,0,0]) cube([14,18,h+0.2], center=true);
            translate([-l/2+4,0,h/2]) rotate([0,0,0]) cube([14,14,h+0.2], center=true);
        }
    }
}

// ---------- tray body ----------
module tray_floor() {
    rounded_box(Tray_L, Tray_W, Base_T, Corner_R);
}

module perimeter_rim() {
    difference() {
        rounded_box(Tray_L, Tray_W, Base_T + Rib_H, Corner_R);
        translate([0,0,Base_T-0.05]) rounded_box(Tray_L-2*Outer_Rim_W, Tray_W-2*Outer_Rim_W, Rib_H+0.2, max(Corner_R-Outer_Rim_W,1));
        // open hinge side a little so the tray does not act like a sealed lid
        if (Hinge_On_Right)
            translate([Tray_L/2-1,0,Base_T+Rib_H/2]) cube([8,Tray_W-20,Rib_H+0.4], center=true);
        else
            translate([-Tray_L/2+1,0,Base_T+Rib_H/2]) cube([8,Tray_W-20,Rib_H+0.4], center=true);
    }
}

module left_winder_loop() {
    translate([Loop_X, Loop_Y, Base_T])
        capsule_ring(Loop_L, Loop_W, Loop_Wall, Rib_H);
}

module straight_guides() {
    // parallel long walls similar to the reference tray
    for (i=[0:Guide_Count-1]) {
        y = Guide_Y_Center + (i-(Guide_Count-1)/2)*Guide_Spacing;
        translate([0,0,Base_T])
            raised_slot([Guide_Start_X,y],[Guide_End_X,y],Guide_W,Rib_H);
    }

    // curved guide transitions at the left end, keeps fibers from a hard 90-degree turn
    for (i=[0:Guide_Count-1]) {
        y = Guide_Y_Center + (i-(Guide_Count-1)/2)*Guide_Spacing;
        translate([Guide_Start_X-5,y,Base_T])
            rotate([0,0,0])
                rounded_box(10, Guide_W, Rib_H, Guide_W/2);
    }
}

module retention_tabs() {
    // little overhanging-looking tabs represented as low bridges; printable as small features
    tab_positions = [
        [-26,  27], [-3, 27], [22,27],
        [-26, -27], [-3,-27], [22,-27],
        [5,  10], [24, 10],
        [5, -10], [24,-10]
    ];
    for (p = tab_positions) {
        translate([p[0], p[1], Base_T+Rib_H])
            rounded_box(Retention_Tab_W, Retention_Tab_T, Retention_Tab_H, 0.5);
    }
}

module splice_holder() {
    if (Show_Splice_Holder) {
        difference() {
            translate([Splice_X, Splice_Y, Base_T])
                rounded_box(Splice_Block_L, Splice_Block_W, Splice_Block_H, 1.5);
            // top grooves, not full through-cuts
            for (i=[0:Splice_Count-1]) {
                y = Splice_Y + (i-(Splice_Count-1)/2) * (Splice_Block_W/(Splice_Count+0.6));
                translate([Splice_X, y, Base_T+Splice_Block_H-Splice_Slot_Depth/2])
                    rotate([0,90,0])
                        cylinder(h=Splice_Block_L+1, d=Splice_Slot_W, center=true, $fn=24);
            }
        }
    }
}

module hinge_barrel(ypos, len) {
    x = Hinge_On_Right ? Tray_L/2 + Hinge_Offset_X : -Tray_L/2 - Hinge_Offset_X;
    translate([x, ypos, Hinge_Z])
        rotate([90,0,0])
            difference() {
                cylinder(h=len, d=Hinge_OD, center=true);
                cylinder(h=len+0.4, d=Hinge_Pin_D, center=true);
            }
    // hinge leaf tying barrel to tray without covering the tray like a lid
    translate([Hinge_On_Right ? Tray_L/2-0.8 : -Tray_L/2+0.8, ypos, Base_T+1.0])
        cube([Hinge_Offset_X*2.0, len*0.70, 2.0], center=true);
}

module hinge_features() {
    if (Split_Hinge_Barrels) {
        hinge_barrel( Hinge_Y_Offset, Hinge_Barrel_L);
        hinge_barrel(-Hinge_Y_Offset, Hinge_Barrel_L);
    } else {
        hinge_barrel(0, Tray_W-18);
    }
    if (Show_Hinge_Pin) {
        x = Hinge_On_Right ? Tray_L/2 + Hinge_Offset_X : -Tray_L/2 - Hinge_Offset_X;
        color("silver") translate([x,0,Hinge_Z]) rotate([90,0,0]) cylinder(h=Tray_W+16, d=Hinge_Pin_D*0.75, center=true);
    }
}

module pull_tab() {
    if (Show_Pull_Tab) {
        x = Hinge_On_Right ? -Tray_L/2 - Pull_Tab_L/2 + 1 : Tray_L/2 + Pull_Tab_L/2 - 1;
        difference() {
            translate([x,0,Base_T/2])
                rounded_box(Pull_Tab_L, Pull_Tab_W, Base_T, Pull_Tab_W/2);
            translate([x,0,Base_T/2])
                cylinder(h=Base_T+0.2, d=Pull_Tab_Hole_D, center=true);
        }
    }
}

module mock_fiber_path() {
    if (Show_Fiber_Path) {
        color("orange") {
            translate([Loop_X,Loop_Y,Base_T+Rib_H+0.7])
                difference() {
                    linear_extrude(height=Fiber_D) rounded_rect_2d(Loop_L-7, Loop_W-7, (Loop_W-7)/2);
                    translate([0,0,-0.1]) linear_extrude(height=Fiber_D+0.2) rounded_rect_2d(Loop_L-10, Loop_W-10, (Loop_W-10)/2);
                }
            for (i=[0:Guide_Count-1]) {
                y = Guide_Y_Center + (i-(Guide_Count-1)/2)*Guide_Spacing;
                translate([0,0,Base_T+Rib_H+0.7]) raised_slot([Guide_Start_X,y],[Guide_End_X,y],Fiber_D,Fiber_D);
            }
        }
    }
}

module mock_box_opening() {
    if (Show_Mock_Box_Opening) {
        // 120x100 box, rough internal safe area only; not part of print
        color([0.2,0.2,0.2,0.18])
            translate([0,0,-0.6])
                difference() {
                    rounded_box(110,90,0.5,12);
                    translate([0,0,-0.1]) rounded_box(104,84,0.8,10);
                }
    }
}

module fiber_swing_tray() {
    mock_box_opening();
    union() {
        tray_floor();
        perimeter_rim();
        left_winder_loop();
        straight_guides();
        splice_holder();
        retention_tabs();
        hinge_features();
        pull_tab();
    }
    mock_fiber_path();
}

fiber_swing_tray();
