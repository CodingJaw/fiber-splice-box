// Parametric two-piece filament spool adapter.
// Dimensions are in millimeters.
//
// Default values match the existing CR-6 STL intent:
// - 30 mm printer shaft
// - 52 mm spool bore
// - 60 mm keeper/flange supported against the spool side
//
// Render both printable halves side-by-side, then put the halves together
// around the shaft to adapt the shaft diameter up to the spool bore.

$fn = 96;

shaft_diameter = 30;
spool_bore_diameter = 52;
keeper_outer_diameter = 60;

adapter_width = 12;        // Total axial width of each half.
keeper_width = 2;          // Axial thickness of the side keeper/flange.
spool_seat_width = 5;      // Straight section that seats in the spool bore.
taper_end_diameter = 36;   // Outside diameter at the shaft-side end of taper.
clearance = 0.35;          // Added to the shaft bore and removed from the spool fit.
split_gap = 0.4;           // Clearance between the two assembled half faces.
print_gap = 12;            // Gap between the two halves in the rendered layout.

// Small flat pads at the split line help the halves sit cleanly together and
// make the geometry more robust when printed.
split_flat_width = 1.2;

module half_annulus_2d(outer_diameter, inner_diameter, side = 1) {
    radius = outer_diameter / 2;

    difference() {
        intersection() {
            circle(d = outer_diameter);

            // Keep only one side of the circular adapter.  The extra overlap
            // avoids coincident edges at the split line.
            translate([
                side > 0 ? split_gap / 2 : -radius - 1,
                -radius - 1
            ])
                square([radius + 1 - split_gap / 2, outer_diameter + 2]);
        }

        circle(d = inner_diameter);

        // Trim a narrow strip from the split face so the two halves do not bind
        // when they are clamped around the shaft.
        translate([
            side > 0 ? -split_flat_width : -split_gap / 2,
            -radius - 1
        ])
            square([split_flat_width + split_gap / 2, outer_diameter + 2]);
    }
}

module tapered_half_annulus(
    start_outer_diameter,
    end_outer_diameter,
    inner_diameter,
    height,
    side = 1
) {
    // Hull two very thin half-annulus slices to create a conical taper.  The
    // bore stays constant for the shaft while the outside shrinks from the
    // spool seat toward the smaller shaft-side end.
    slice_height = 0.05;

    if (height > 0) {
        hull() {
            linear_extrude(height = slice_height)
                half_annulus_2d(start_outer_diameter, inner_diameter, side);

            translate([0, 0, height - slice_height])
                linear_extrude(height = slice_height)
                    half_annulus_2d(end_outer_diameter, inner_diameter, side);
        }
    }
}

module adapter_half(side = 1) {
    shaft_bore = shaft_diameter + clearance;
    spool_fit = spool_bore_diameter - clearance;
    taper_end = max(taper_end_diameter, shaft_bore + 2);
    seat_width = min(spool_seat_width, adapter_width);
    taper_width = adapter_width - seat_width;

    union() {
        // Straight spool seat at the keeper side.
        linear_extrude(height = seat_width)
            half_annulus_2d(spool_fit, shaft_bore, side);

        // Taper from the spool seat back toward the smaller shaft-side end.
        translate([0, 0, seat_width])
            tapered_half_annulus(
                spool_fit,
                taper_end,
                shaft_bore,
                taper_width,
                side
            );

        // Larger side keeper/flange.  This is intentionally only on one side
        // so it bears on the side of the spool instead of widening the whole
        // adapter.
        linear_extrude(height = keeper_width)
            half_annulus_2d(keeper_outer_diameter, shaft_bore, side);
    }
}

module printable_pair() {
    part_offset = keeper_outer_diameter / 2 + print_gap / 2;

    translate([-part_offset, 0, 0])
        adapter_half(side = -1);

    translate([part_offset, 0, 0])
        adapter_half(side = 1);
}

printable_pair();
