/*
    SC Fiber Connector Adapter Mock - centered side flange version

    Orientation:
    X = length/front-to-back
    Y = width/side-to-side
    Z = height/top-bottom

    Corrected interpretation:
    - Main body is 27.5 long x 12.8 wide x 9.3 high.
    - The wider flange is side-only: no top or bottom flange.
    - Flange is centered along the length of the adapter, not placed at one end.
    - Overall width across side flanges is 14.8.
    - Side protrusion is therefore 1.0 mm per side.
*/

$fn = 64;

// --------------------
// Main dimensions, mm
// --------------------
sc_l = 27.5;
sc_w = 12.8;
sc_h = 9.3;

flange_total_w = 14.8;
flange_t = 2.5;              // thickness along X
flange_x_center = sc_l / 2;  // centered flange location

side_flange_each = (flange_total_w - sc_w) / 2;

// Visual-only front detail
front_detail_depth = 0.45;
front_opening_d = 3.2;
front_inner_square = 6.4;

module sc_connector_mock(center=true, show_front_detail=true) {
    translate(center ? [-sc_l/2, -sc_w/2, -sc_h/2] : [0,0,0]) {
        difference() {
            union() {
                // Main rectangular adapter body
                cube([sc_l, sc_w, sc_h]);

                // Centered left side flange only
                translate([flange_x_center - flange_t/2, -side_flange_each, 0])
                    cube([flange_t, side_flange_each, sc_h]);

                // Centered right side flange only
                translate([flange_x_center - flange_t/2, sc_w, 0])
                    cube([flange_t, side_flange_each, sc_h]);
            }

            if (show_front_detail) {
                // Shallow square recess on the front face, visual only
                translate([-0.01, (sc_w - front_inner_square)/2, (sc_h - front_inner_square)/2])
                    cube([front_detail_depth + 0.02, front_inner_square, front_inner_square]);

                // Center round connector opening, visual only
                translate([-0.02, sc_w/2, sc_h/2])
                    rotate([0,90,0])
                        cylinder(d=front_opening_d, h=front_detail_depth + 0.04);
            }
        }

        if (show_front_detail) {
            ridge_depth = 0.35;
            front_ridge_w = 0.55;
            front_ridge_h = 0.35;

            // Raised visual ridges on front face
            translate([-ridge_depth, (sc_w - 7.2)/2, sc_h/2 + 3.0])
                cube([ridge_depth, 7.2, front_ridge_h]);

            translate([-ridge_depth, (sc_w - 7.2)/2, sc_h/2 - 3.35])
                cube([ridge_depth, 7.2, front_ridge_h]);

            translate([-ridge_depth, sc_w/2 - 3.6, sc_h/2 - 2.5])
                cube([ridge_depth, front_ridge_w, 5.0]);

            translate([-ridge_depth, sc_w/2 + 3.05, sc_h/2 - 2.5])
                cube([ridge_depth, front_ridge_w, 5.0]);
        }
    }
}

// Preview
sc_connector_mock();
