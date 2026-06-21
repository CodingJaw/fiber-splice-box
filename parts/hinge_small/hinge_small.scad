// OpenSCAD wrapper for the small hinge STL parts.
//
// The original source parts are binary STL exports in this directory:
//   - Hinge_small_L.stl
//   - Hinge_small_R.stl
//   - Hinge_small_Sp.stl
//   - Hinge_small_Cap.stl
//
// Units are millimeters.  Open this file from parts/hinge_small so the
// relative STL import paths resolve correctly, or adjust `stl_dir` below.

$fn = 96;

stl_dir = "./";

module hinge_small_left() {
    import(str(stl_dir, "Hinge_small_L.stl"), convexity = 10);
}

module hinge_small_right() {
    import(str(stl_dir, "Hinge_small_R.stl"), convexity = 10);
}

module hinge_small_spacer() {
    import(str(stl_dir, "Hinge_small_Sp.stl"), convexity = 10);
}

module hinge_small_cap() {
    import(str(stl_dir, "Hinge_small_Cap.stl"), convexity = 10);
}

module hinge_small_assembled() {
    hinge_small_left();
    hinge_small_right();
    hinge_small_spacer();
    hinge_small_cap();
}

module hinge_small_exploded(spacing = 18) {
    translate([0, -spacing, 0])
        hinge_small_left();

    translate([0, spacing, 0])
        hinge_small_right();

    translate([spacing, 0, 0])
        hinge_small_spacer();

    translate([-spacing, 0, 0])
        hinge_small_cap();
}

/* [View] */

// Select how to display the imported v1 STL parts.
view = "assembled"; // [assembled: Assembled, exploded: Exploded]

if (view == "exploded") {
    hinge_small_exploded();
} else {
    hinge_small_assembled();
}
