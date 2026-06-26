// Parametric hotbed foot with OpenSCAD Customizer controls.
// Self-contained: this file does not import or reference the source STL.
// v3 replaces the raw mesh with editable dimensions and dropdown-based options.

/* [Foot body] */
// Overall left-to-right size of the box-shaped foot.
foot_length = 34.64; // [20:0.1:80]
// Overall front-to-back size of the box-shaped foot.
foot_width = 20.00; // [10:0.1:60]
// Overall bottom-to-top size of the box-shaped foot.
foot_height = 12.00; // [4:0.1:40]

/* [Large notch opening] */
// Large front opening width.
opening_width = 29.00; // [4:0.1:40]
// How far the large opening cuts into the foot from the front.
opening_depth = 14.00; // [2:0.1:50]
// Corner style for the rear of the large opening.
opening_back = "Rounded"; // [Rounded, Square]
// Radius used when the large opening has a rounded rear.
opening_radius = 2.00; // [0.1:0.1:10]

/* [Top wall notch] */
// Side of the large opening that gets the small notch at the top of the wall.
top_notch_side = "Left"; // [Left, Right, None]
// Left/right size of the small top wall notch.
top_notch_width = 2.00; // [0.5:0.1:10]
// Front/back size of the small top wall notch.
top_notch_depth = 4.00; // [0.5:0.1:15]
// How far down the small top notch cuts from the top surface.
top_notch_height = 2.50; // [0.5:0.1:10]

/* [Placement] */
// Default is centered so the model is visible immediately when opened.
model_position = "Centered"; // [Centered, Source STL]

module rounded_rear_opening(width, depth, height, radius) {
  union() {
    translate([-width / 2, -0.01, -0.01])
      cube([width, max(depth - radius, 0.01), height + 0.02]);

    translate([0, depth - radius, -0.01])
      cylinder(h = height + 0.02, r = min(radius, width / 2), $fn = 48);
  }
}

module large_notch_opening(width, depth, height, radius, back_style) {
  if (back_style == "Rounded") {
    rounded_rear_opening(width, depth, height, radius);
  } else {
    translate([-width / 2, -0.01, -0.01])
      cube([width, depth + 0.02, height + 0.02]);
  }
}

module top_wall_notch(side, opening_width_value, notch_width, notch_depth, notch_height, foot_height_value) {
  if (side != "None") {
    side_sign = side == "Left" ? -1 : 1;
    x_inner_edge = side_sign * opening_width_value / 2;
    x_start = side == "Left" ? x_inner_edge - notch_width : x_inner_edge;

    translate([x_start, -0.01, foot_height_value - notch_height])
      cube([notch_width, notch_depth + 0.02, notch_height + 0.02]);
  }
}

module hotbed_foot_v3(
  length = foot_length,
  width = foot_width,
  height = foot_height,
  opening_w = opening_width,
  opening_d = opening_depth,
  opening_r = opening_radius,
  opening_style = opening_back,
  notch_side = top_notch_side,
  notch_w = top_notch_width,
  notch_d = top_notch_depth,
  notch_h = top_notch_height,
  position = model_position
) {
  source_center = [149.8822937, 138.25900269, 6];
  placement = position == "Source STL" ? source_center : [0, 0, 0];

  translate(placement)
    translate([-length / 2, -width / 2, -height / 2])
      difference() {
        cube([length, width, height]);

        translate([length / 2, 0, 0])
          large_notch_opening(
            min(opening_w, length - 0.2),
            min(opening_d, width + 0.02),
            height,
            opening_r,
            opening_style
          );

        translate([length / 2, 0, 0])
          top_wall_notch(
            notch_side,
            min(opening_w, length - 0.2),
            notch_w,
            notch_d,
            min(notch_h, height),
            height
          );
      }
}

hotbed_foot_v3();
