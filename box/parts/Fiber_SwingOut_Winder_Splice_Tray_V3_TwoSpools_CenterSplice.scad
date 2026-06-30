// Fiber Swing-Out Winder and Splice Tray - V3
// Designed as the first visible swing-out tray inside an outdoor fiber connection box.
// Focus: two fiber winding spools + center splice sleeve holder.
// Units: mm

$fn = 64;

/* [Tray size] */
Tray_W = 103;               // X width, based near supplied STL width
Tray_D = 86;                // Y depth, based near supplied STL depth
Base_T = 2.2;               // base plate thickness
Tray_R = 12;                // rounded tray corners
Perimeter_Wall_H = 3.0;     // low edge wall above base
Perimeter_Wall_T = 2.0;

/* [Fiber winding spools] */
Spool_Count = 2;
Spool_W = 31;               // spool island width X
Spool_D = 58;               // spool island depth Y
Spool_H = 5.2;              // spool island height from build plate
Spool_R = 14;               // rounded spool ends
Spool_X_Offset = 25;        // left/right spool center offset
Spool_Y = 0;
Spool_Lip_H = 1.3;          // small raised top lip
Spool_Lip_T = 1.8;

/* [Center splice holder] */
Splice_Block_W = 42;        // X length of splice holder
Splice_Block_D = 25;        // Y depth of splice holder
Splice_Block_H = 4.8;       // total height from build plate
Splice_Grooves = 6;
Splice_Groove_R = 1.55;     // splice sleeve groove radius
Splice_Groove_Spacing = 3.8;
Splice_Groove_Depth_Adjust = 0.15;

/* [Fiber retaining tabs] */
Tab_W = 8;
Tab_D = 2.6;
Tab_H = 2.2;
Tab_Clearance_Z = 2.2;      // tabs start above base, low enough to keep fiber down
Show_Retention_Tabs = true;

/* [Swing hinge / pull tab] */
Show_Hinge = true;
Hinge_Barrel_OD = 7.0;
Hinge_Barrel_ID = 3.2;
Hinge_Barrel_L = 15;
Hinge_Clearance_From_Edge = 1.0;
Pull_Tab_W = 18;
Pull_Tab_D = 8;
Pull_Tab_Hole_D = 4;

/* [Preview helpers] */
Show_Mock_Box_Footprint = false;
Mock_Box_Inside_W = 112;
Mock_Box_Inside_D = 92;

// ---------- Basic geometry helpers ----------
module rounded_rect_2d(w, d, r) {
    r2 = min(r, min(w, d) / 2 - 0.01);
    hull() {
        translate([ w/2-r2,  d/2-r2]) circle(r=r2);
        translate([-w/2+r2,  d/2-r2]) circle(r=r2);
        translate([ w/2-r2, -d/2+r2]) circle(r=r2);
        translate([-w/2+r2, -d/2+r2]) circle(r=r2);
    }
}

module rounded_box(w, d, h, r) {
    linear_extrude(height=h)
        rounded_rect_2d(w, d, r);
}

module rounded_ring(w, d, h, r, wall) {
    difference() {
        rounded_box(w, d, h, r);
        translate([0,0,-0.05])
            rounded_box(w - 2*wall, d - 2*wall, h + 0.10, max(0.1, r - wall));
    }
}

module screw_hole(d=3.2, h=20) {
    translate([0,0,-0.1]) cylinder(d=d, h=h+0.2);
}

// ---------- Tray components ----------
module tray_base() {
    // base plate
    rounded_box(Tray_W, Tray_D, Base_T, Tray_R);

    // low perimeter wall/rim, open center
    translate([0,0,Base_T])
        rounded_ring(Tray_W, Tray_D, Perimeter_Wall_H, Tray_R, Perimeter_Wall_T);
}

module spool_island(xpos) {
    // main raised oval/rounded island the fiber wraps around
    translate([xpos, Spool_Y, Base_T])
        rounded_box(Spool_W, Spool_D, Spool_H-Base_T, Spool_R);

    // raised top lip/edge on spool island to help keep fiber on the island perimeter
    translate([xpos, Spool_Y, Spool_H])
        rounded_ring(Spool_W, Spool_D, Spool_Lip_H, Spool_R, Spool_Lip_T);
}

module splice_holder() {
    difference() {
        translate([0,0,Base_T])
            rounded_box(Splice_Block_W, Splice_Block_D, Splice_Block_H-Base_T, 2.0);

        // U-shaped top grooves running left/right across the splice block
        start_y = -((Splice_Grooves-1) * Splice_Groove_Spacing) / 2;
        for (i=[0:Splice_Grooves-1]) {
            y = start_y + i * Splice_Groove_Spacing;
            translate([0, y, Splice_Block_H - Splice_Groove_R + Splice_Groove_Depth_Adjust])
                rotate([0,90,0])
                    cylinder(r=Splice_Groove_R, h=Splice_Block_W + 2, center=true);
        }
    }

    // small end stops for splice sleeves
    stop_w = 1.6;
    for (x=[-Splice_Block_W/2 + 4, Splice_Block_W/2 - 4]) {
        translate([x,0,Splice_Block_H])
            cube([stop_w, Splice_Block_D-5, 1.4], center=true);
    }
}

module retention_tabs() {
    if (Show_Retention_Tabs) {
        // tabs around left spool
        for (x=[-Spool_X_Offset, Spool_X_Offset]) {
            translate([x,  Spool_D/2 + 4, Tab_Clearance_Z]) cube([Tab_W, Tab_D, Tab_H], center=true);
            translate([x, -Spool_D/2 - 4, Tab_Clearance_Z]) cube([Tab_W, Tab_D, Tab_H], center=true);
            translate([x + Spool_W/2 + 5, 0, Tab_Clearance_Z]) rotate([0,0,90]) cube([Tab_W, Tab_D, Tab_H], center=true);
            translate([x - Spool_W/2 - 5, 0, Tab_Clearance_Z]) rotate([0,0,90]) cube([Tab_W, Tab_D, Tab_H], center=true);
        }

        // tabs near center splice routing area
        translate([0,  Splice_Block_D/2 + 7, Tab_Clearance_Z]) cube([16, Tab_D, Tab_H], center=true);
        translate([0, -Splice_Block_D/2 - 7, Tab_Clearance_Z]) cube([16, Tab_D, Tab_H], center=true);
    }
}

module hinge_barrels() {
    if (Show_Hinge) {
        // hinge on left narrow side; barrels point along Y
        x = -Tray_W/2 - Hinge_Barrel_OD/2 + Hinge_Clearance_From_Edge;
        for (y=[-Tray_D/2 + 18, Tray_D/2 - 18]) {
            difference() {
                translate([x, y, Base_T + Hinge_Barrel_OD/2])
                    rotate([90,0,0]) cylinder(d=Hinge_Barrel_OD, h=Hinge_Barrel_L, center=true);
                translate([x, y, Base_T + Hinge_Barrel_OD/2])
                    rotate([90,0,0]) cylinder(d=Hinge_Barrel_ID, h=Hinge_Barrel_L+1, center=true);
            }
        }
    }
}

module pull_tab() {
    difference() {
        translate([Tray_W/2 + Pull_Tab_D/2 - 1, 0, Base_T/2])
            rounded_box(Pull_Tab_D, Pull_Tab_W, Base_T, 3);
        translate([Tray_W/2 + Pull_Tab_D/2 - 1, 0, -0.1])
            cylinder(d=Pull_Tab_Hole_D, h=Base_T+0.3);
    }
}

module mock_box_footprint() {
    if (Show_Mock_Box_Footprint) {
        color("gray", 0.25)
        translate([0,0,-0.3])
            difference() {
                rounded_box(Mock_Box_Inside_W, Mock_Box_Inside_D, 0.3, 8);
                translate([0,0,-0.05]) rounded_box(Mock_Box_Inside_W-4, Mock_Box_Inside_D-4, 0.5, 6);
            }
    }
}

module fiber_swingout_tray_v3() {
    mock_box_footprint();
    tray_base();
    spool_island(-Spool_X_Offset);
    spool_island( Spool_X_Offset);
    splice_holder();
    retention_tabs();
    hinge_barrels();
    pull_tab();
}

fiber_swingout_tray_v3();
