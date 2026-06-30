/*
  Fiber swing-out winder + splice holder tray - V1
  Standalone test part for outdoor fiber connection box.

  Goals:
  - Swing-out tray with hinge barrels on one narrow side.
  - Raised fiber routing/winding guides with large bend radius.
  - Splice sleeve holder on tray face.
  - Parametric dimensions for later merge into waterproof box.

  OpenSCAD preview: F5
  Export STL: F6, then export.
*/

$fn = 64;

/* [Tray size] */
Tray_L = 86;              // overall tray length, hinge side to opposite side
Tray_W = 64;              // overall tray width
Tray_T = 2.4;             // base thickness
Tray_Corner_R = 10;

/* [Fiber bend / routing] */
Guide_H = 4.0;            // raised fiber guide height
Guide_W = 1.8;            // wall thickness of fiber guides
Outer_Guide_Inset = 5.5;  // distance from tray edge
Inner_Island_L = 42;      // center island length
Inner_Island_W = 18;      // center island width
Min_Bend_R_Visual = 15;   // not used as strict calc; keep guides above this radius
Retention_Tab_Count = 8;
Retention_Tab_W = 5.0;
Retention_Tab_D = 1.2;
Retention_Tab_H = 1.2;

/* [Splice holder] */
Show_Splice_Holder = true;
Splice_Count = 6;
Splice_Holder_L = 50;
Splice_Holder_W = 16;
Splice_Holder_H = 5.0;
Splice_Slot_W = 3.2;      // slot for splice sleeve diameter
Splice_Slot_D = 10.0;     // slot depth front/back
Splice_Retainer_Lip_H = 1.2;

/* [Hinge] */
Show_Hinge = true;
Hinge_Pin_D = 2.2;        // metal/plastic pin diameter clearance
Hinge_Barrel_OD = 7.5;
Hinge_Barrel_L = 13.5;
Hinge_Gap = 3.0;
Hinge_Count = 3;          // tray-side knuckles
Hinge_Offset_From_End = 8.0;
Hinge_Side_Clearance = 0.6;

/* [Mounting / optional holes] */
Show_Pull_Tab = true;
Pull_Tab_W = 12;
Pull_Tab_D = 6;
Pull_Tab_Hole_D = 3.0;

/* [View options] */
Show_Guide_Clearance_Mock_Fiber = false;
Mock_Fiber_D = 1.6;

// ---------- Utility modules ----------

module rounded_rect_2d(l, w, r) {
    hull() {
        translate([ l/2-r,  w/2-r]) circle(r=r);
        translate([-l/2+r,  w/2-r]) circle(r=r);
        translate([ l/2-r, -w/2+r]) circle(r=r);
        translate([-l/2+r, -w/2+r]) circle(r=r);
    }
}

module rounded_plate(l, w, h, r) {
    linear_extrude(height=h)
        rounded_rect_2d(l, w, r);
}

module rounded_ring(l, w, wall, h, r) {
    linear_extrude(height=h)
        difference() {
            rounded_rect_2d(l, w, r);
            rounded_rect_2d(l-2*wall, w-2*wall, max(0.1, r-wall));
        }
}

module screw_hole_z(d, h) {
    translate([0,0,-0.1]) cylinder(d=d, h=h+0.2);
}

// ---------- Main components ----------

module tray_base() {
    difference() {
        rounded_plate(Tray_L, Tray_W, Tray_T, Tray_Corner_R);

        // lightweight shallow recessed area, leaves outer rim stronger
        translate([0,0,Tray_T-0.8])
            linear_extrude(height=1.0)
                rounded_rect_2d(Tray_L-10, Tray_W-10, max(1, Tray_Corner_R-5));
    }

    // low outer rim to help keep fiber inside tray
    translate([0,0,Tray_T])
        rounded_ring(Tray_L-2.5, Tray_W-2.5, 1.4, 2.2, max(1, Tray_Corner_R-2));
}

module fiber_guides() {
    // Large outer wrap guide. This creates an oval/rounded rectangular fiber path.
    translate([-5,0,Tray_T])
        rounded_ring(Tray_L-18, Tray_W-18, Guide_W, Guide_H, max(4, Tray_Corner_R-4));

    // Center island forces a broad wrap path, not a tight bend.
    translate([-9,0,Tray_T])
        rounded_plate(Inner_Island_L, Inner_Island_W, Guide_H, 8);

    // small center ridge to form two lanes similar to small fiber trays
    translate([-9,0,Tray_T + Guide_H])
        rounded_plate(Inner_Island_L-8, 2.2, 1.0, 1.0);

    // Open entry/exit ramp guides near hinge side
    for (yy=[-12,12]) {
        translate([Tray_L/2-25, yy, Tray_T])
            cube([26, Guide_W, Guide_H], center=true);
    }
}

module retention_tabs() {
    // Small overhanging-looking tabs, printable because they are low and shallow.
    // They help keep fiber from jumping over the guide walls.
    positions = [
        [-30,  23, 0], [-8,  23, 0], [16,  23, 0],
        [-30, -23, 0], [-8, -23, 0], [16, -23, 0],
        [-42,   0, 90], [30, 0, 90]
    ];

    for (p = positions) {
        translate([p[0], p[1], Tray_T + Guide_H + 0.1])
            rotate([0,0,p[2]])
                cube([Retention_Tab_W, Retention_Tab_D, Retention_Tab_H], center=true);
    }
}

module splice_holder() {
    if (Show_Splice_Holder) {
        x0 = -6;
        y0 = -Tray_W/2 + 14;

        difference() {
            translate([x0,y0,Tray_T])
                rounded_plate(Splice_Holder_L, Splice_Holder_W, Splice_Holder_H, 2);

            // lengthwise half-round-ish slots approximated by rectangular openings
            for (i=[0:Splice_Count-1]) {
                sx = x0 - Splice_Holder_L/2 + (i+0.5)*Splice_Holder_L/Splice_Count;
                translate([sx, y0, Tray_T + Splice_Holder_H/2 + 0.4])
                    cube([Splice_Slot_W, Splice_Slot_D, Splice_Holder_H+1], center=true);
                translate([sx, y0, Tray_T + Splice_Holder_H - 0.1])
                    rotate([90,0,0]) cylinder(d=Splice_Slot_W, h=Splice_Slot_D+0.2, center=true, $fn=24);
            }
        }

        // raised lips front/back
        for (yy=[y0-Splice_Holder_W/2+1.0, y0+Splice_Holder_W/2-1.0]) {
            translate([x0, yy, Tray_T+Splice_Holder_H])
                cube([Splice_Holder_L-4, 1.2, Splice_Retainer_Lip_H], center=true);
        }
    }
}

module hinge_barrels() {
    if (Show_Hinge) {
        // Hinge axis runs along Y on the right/narrow side of the tray.
        x = Tray_L/2 + Hinge_Barrel_OD/2 - Hinge_Side_Clearance;
        z = Tray_T + Hinge_Barrel_OD/2;
        total_span = Tray_W - 2*Hinge_Offset_From_End;
        pitch = (Hinge_Count == 1) ? 0 : (total_span - Hinge_Barrel_L) / (Hinge_Count-1);

        for (i=[0:Hinge_Count-1]) {
            y = -total_span/2 + Hinge_Barrel_L/2 + i*pitch;
            difference() {
                translate([x,y,z])
                    rotate([90,0,0]) cylinder(d=Hinge_Barrel_OD, h=Hinge_Barrel_L, center=true);
                translate([x,y,z])
                    rotate([90,0,0]) cylinder(d=Hinge_Pin_D, h=Hinge_Barrel_L+0.4, center=true);
            }
            // small web connecting hinge barrel to tray
            translate([Tray_L/2-0.5, y, Tray_T+1.5])
                cube([4.0, Hinge_Barrel_L, 3.0], center=true);
        }
    }
}

module pull_tab() {
    if (Show_Pull_Tab) {
        difference() {
            translate([-Tray_L/2 - Pull_Tab_D/2 + 1.5, 0, Tray_T/2])
                rounded_plate(Pull_Tab_D, Pull_Tab_W, Tray_T, 2);
            translate([-Tray_L/2 - Pull_Tab_D/2 + 1.5, 0, 0])
                screw_hole_z(Pull_Tab_Hole_D, Tray_T+0.2);
        }
    }
}

module mock_fiber_path() {
    if (Show_Guide_Clearance_Mock_Fiber) {
        color("yellow")
        translate([-5,0,Tray_T+Guide_H+Mock_Fiber_D/2+0.3])
            rounded_ring(Tray_L-24, Tray_W-24, Mock_Fiber_D, Mock_Fiber_D, max(3, Tray_Corner_R-6));
    }
}

module fiber_swingout_tray() {
    tray_base();
    fiber_guides();
    retention_tabs();
    splice_holder();
    hinge_barrels();
    pull_tab();
    mock_fiber_path();
}

fiber_swingout_tray();
