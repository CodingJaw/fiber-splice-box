/*
    SC Fiber Connector Adapter Mock
    Based on corrected drawing.

    Orientation:
    X = length/front-to-back
    Y = width/side-to-side
    Z = height/top-bottom

    Main body:
    L = 27.5 mm
    W = 12.8 mm
    H = 9.3 mm

    Side flange:
    Overall width across side flanges = 14.8 mm
    Main body width = 12.8 mm
    Each side flange protrudes = (14.8 - 12.8) / 2 = 1.0 mm

    Flange thickness along length = 2.5 mm
    Flanges are side-only, not top/bottom.
*/

$fn = 48;

// --------------------
// Main dimensions
// --------------------
sc_l = 27.5;
sc_w = 12.8;
sc_h = 9.3;

flange_total_w = 14.8;
flange_t = 2.5;

side_flange_each = (flange_total_w - sc_w) / 2;

// Visual front detail settings
front_detail_depth = 0.45;
front_opening_d = 3.2;
front_inner_square = 6.4;

// --------------------
// SC adapter mock
// --------------------
module sc_connector_mock(
    show_front_detail = true,
    center = true
) {
    translate(center ? [-sc_l/2, -sc_w/2, -sc_h/2] : [0, 0, 0]) {

        difference() {
            union() {
                // Main rectangular body
                cube([sc_l, sc_w, sc_h]);

                // Left side flange only
                translate([0, -side_flange_each, 0])
                    cube([flange_t, side_flange_each, sc_h]);

                // Right side flange only
                translate([0, sc_w, 0])
                    cube([flange_t, side_flange_each, sc_h]);
            }

            if (show_front_detail) {
                // Shallow front square recess, centered on face
                translate([-0.01, (sc_w - front_inner_square) / 2, (sc_h - front_inner_square) / 2])
                    cube([front_detail_depth + 0.02, front_inner_square, front_inner_square]);

                // Center round connector hole visual
                translate([-0.02, sc_w / 2, sc_h / 2])
                    rotate([0, 90, 0])
                        cylinder(d = front_opening_d, h = front_detail_depth + 0.04);
            }
        }

        if (show_front_detail) {
            // Raised/remaining visual ridges on front face
            front_ridge_w = 0.55;
            front_ridge_h = 0.35;
            ridge_depth = 0.35;

            // Top/bottom horizontal ridges
            translate([-ridge_depth, (sc_w - 7.2) / 2, sc_h / 2 + 3.0])
                cube([ridge_depth, 7.2, front_ridge_h]);

            translate([-ridge_depth, (sc_w - 7.2) / 2, sc_h / 2 - 3.35])
                cube([ridge_depth, 7.2, front_ridge_h]);

            // Side vertical ridges
            translate([-ridge_depth, sc_w / 2 - 3.6, sc_h / 2 - 2.5])
                cube([ridge_depth, front_ridge_w, 5.0]);

            translate([-ridge_depth, sc_w / 2 + 3.05, sc_h / 2 - 2.5])
                cube([ridge_depth, front_ridge_w, 5.0]);
        }
    }
}

// --------------------
// Preview
// --------------------
sc_connector_mock();
