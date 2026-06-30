/*
  SC/APC Simplex Fiber Adapter Holder - Test Print V2

  Designed for common flanged SC/APC female-to-female simplex couplers.
  This version uses a THIN 2mm face plate so the coupler snap/flange area is not buried in thick plastic.

  Print this standalone part first and test-fit your green SC/APC coupler.

  Orientation:
  - The SC adapter slides through the rectangular window.
  - Fiber plugs connect from the front/back of this holder.
  - No box wall holes are modeled here; this is only the internal holder.
*/

$fn = 48;

/* [Main settings] */
SC_Count = 2;
SC_Pitch = 18;                 // center-to-center distance between adapters

// Thin panel that the SC adapters snap/seat into
Panel_Thickness = 2.0;         // keep thin; most SC couplers do not like thick panels
Panel_Height = 24;
Panel_Top_Margin = 5;
Panel_Bottom_Margin = 5;
Side_Margin = 8;

// SC/APC simplex adapter window; tune these after test-fit
SC_Window_W = 9.8;             // adapter narrow dimension + clearance
SC_Window_H = 13.4;            // adapter tall dimension + clearance
Corner_Radius = 0.8;

// Clearance space behind/front of panel so the coupler body is not pinched
Adapter_Clearance_Length = 35; // common couplers are about 31mm long
Clearance_W = 13.0;
Clearance_H = 16.5;

/* [Mounting base] */
Base_Thickness = 3;
Base_Depth = 18;
Base_Front_Overhang = 8;
Base_Back_Overhang = 8;
Mount_Hole_Dia = 3.2;          // M3 clearance
Mount_Hole_Offset_X = 8;
Mount_Hole_Offset_Y = 5;

/* [Retainer features] */
Add_Top_Retainer_Lip = true;
Retainer_Lip_Depth = 1.2;
Retainer_Lip_Height = 1.6;

/* [Visualization] */
Show_Mock_Adapters = true;     // turn false before exporting STL if desired
Mock_Length = 31;
Mock_Flange_W = 22;
Mock_Flange_H = 9;
Mock_Body_W = 9;
Mock_Body_H = 13;

Holder_W = (SC_Count - 1) * SC_Pitch + SC_Window_W + Side_Margin * 2;
Panel_Z = Base_Thickness;
Panel_W = Holder_W;
Panel_D = Panel_Thickness;

module rounded_rect_2d(w, h, r) {
    hull() {
        translate([ w/2-r,  h/2-r]) circle(r=r);
        translate([-w/2+r,  h/2-r]) circle(r=r);
        translate([ w/2-r, -h/2+r]) circle(r=r);
        translate([-w/2+r, -h/2+r]) circle(r=r);
    }
}

module rounded_window_cut(w, h, depth, r) {
    linear_extrude(height=depth + 0.4)
        rounded_rect_2d(w, h, r);
}

function sc_x(i) = -((SC_Count - 1) * SC_Pitch) / 2 + i * SC_Pitch;

module base_with_mounting_holes() {
    difference() {
        translate([-Holder_W/2, -Base_Front_Overhang, 0])
            cube([Holder_W, Base_Depth, Base_Thickness]);

        // mounting holes in the base tabs
        for (sx = [-1, 1]) {
            translate([sx * (Holder_W/2 - Mount_Hole_Offset_X), Mount_Hole_Offset_Y, -0.1])
                cylinder(d=Mount_Hole_Dia, h=Base_Thickness + 0.2);
        }
    }
}

module thin_sc_panel() {
    difference() {
        // main thin panel
        translate([-Panel_W/2, 0, Panel_Z])
            cube([Panel_W, Panel_D, Panel_Height]);

        // rectangular SC adapter windows
        for (i = [0:SC_Count-1]) {
            translate([sc_x(i), -0.2, Panel_Z + Panel_Height/2])
                rotate([-90, 0, 0])
                    rounded_window_cut(SC_Window_W, SC_Window_H, Panel_D + 0.4, Corner_Radius);
        }
    }

    // side supports / ribs, kept away from adapter body path
    translate([-Panel_W/2, 0, Panel_Z])
        cube([3, Base_Depth - Base_Front_Overhang, Panel_Height]);
    translate([Panel_W/2 - 3, 0, Panel_Z])
        cube([3, Base_Depth - Base_Front_Overhang, Panel_Height]);

    // small top retainer lip similar to molded fiber-box holders
    if (Add_Top_Retainer_Lip) {
        translate([-Panel_W/2, -Retainer_Lip_Depth, Panel_Z + Panel_Height - Retainer_Lip_Height])
            cube([Panel_W, Retainer_Lip_Depth, Retainer_Lip_Height]);
    }
}

module clearance_gauge() {
    // A non-printing visual reference showing free space needed for coupler body.
    // It is colored transparent in preview. It does not subtract anything because the design is already open.
    for (i = [0:SC_Count-1]) {
        color([1, 0.7, 0, 0.18])
            translate([sc_x(i) - Clearance_W/2, -Mock_Length/2, Panel_Z + Panel_Height/2 - Clearance_H/2])
                cube([Clearance_W, Mock_Length, Clearance_H]);
    }
}

module mock_sc_adapter() {
    // crude dimensional mockup for preview only
    for (i = [0:SC_Count-1]) {
        translate([sc_x(i), -Mock_Length/2 + Panel_D/2, Panel_Z + Panel_Height/2]) {
            color("green")
                cube([Mock_Body_W, Mock_Length, Mock_Body_H], center=true);
            color("limegreen")
                cube([Mock_Flange_W, 2.0, Mock_Flange_H], center=true);
            color("black")
                translate([0, -Mock_Length/2 - 0.5, 0])
                    cube([Mock_Body_W + 1, 1, Mock_Body_H + 1], center=true);
            color("black")
                translate([0, Mock_Length/2 + 0.5, 0])
                    cube([Mock_Body_W + 1, 1, Mock_Body_H + 1], center=true);
        }
    }
}

module sc_holder_v2() {
    base_with_mounting_holes();
    thin_sc_panel();

    // extra low back brace, below the SC windows
    translate([-Panel_W/2, Panel_D, Panel_Z])
        cube([Panel_W, Base_Back_Overhang, 4]);
}

sc_holder_v2();

if (Show_Mock_Adapters) {
    clearance_gauge();
    mock_sc_adapter();
}
