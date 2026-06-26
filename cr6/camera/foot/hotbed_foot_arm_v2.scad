// Parametric arm for the hotbed foot/camera mount.
// v2 defaults match the requested "new default" OpenSCAD parameter set.
// Self-contained OpenSCAD model; does not import or reference STL files.

/* [Arm body] */
// Overall arm length from the square end to the far side of the round end.
arm_length = 103.91; // [30:0.1:180]
// Straight arm width.
arm_width = 12.00; // [6:0.1:60]
// Arm thickness/height. Default matches the hotbed foot height.
arm_height = 12.00; // [2:0.1:30]

/* [Round end] */
// Diameter of the round section at the end of the arm.
end_circle_diameter = 21.00; // [10:0.1:80]
// Segment count for the round end and screw hole.
round_detail = 96; // [32, 48, 64, 96, 128]

/* [Raised / lowered circle pad] */
// Raised adds material above the round end; Lowered cuts a circular recess; Flush disables the feature.
pad_style = "Lowered"; // [Raised, Lowered, Flush]
// Diameter of the raised/lowered circular pad area.
pad_diameter = 14.00; // [6:0.1:70]
// Height of raised pad or depth of lowered recess.
pad_height = 3.00; // [0.2:0.1:12]

/* [M3 screw hole] */
// M3 clearance hole diameter.
m3_hole_diameter = 3.20; // [2.8:0.05:4.0]
// Optional counterbore diameter. Set style to None to disable.
counterbore_style = "Lowered side"; // [None, Raised side, Lowered side]
// Counterbore diameter for screw head clearance.
counterbore_diameter = 5.60; // [4:0.1:12]
// Counterbore depth.
counterbore_depth = 2.50; // [0.5:0.1:8]

/* [Placement] */
// Centered places the arm around the origin; Positive X starts the square end at X=0.
model_position = "Centered"; // [Centered, Positive X]

module rounded_arm_2d(length, width, end_diameter) {
  circle_center_x = length / 2 - end_diameter / 2;

  union() {
    translate([-length / 2, -width / 2])
      square([max(circle_center_x + length / 2, 0.01), width]);

    translate([circle_center_x, 0])
      circle(d = end_diameter, $fn = round_detail);
  }
}

module arm_base(length, width, height, end_diameter) {
  linear_extrude(height = height)
    rounded_arm_2d(length, width, end_diameter);
}

module circle_pad(length, height, end_diameter, diameter, style, feature_height) {
  circle_center_x = length / 2 - end_diameter / 2;

  if (style == "Raised") {
    translate([circle_center_x, 0, height])
      cylinder(h = feature_height, d = diameter, $fn = round_detail);
  }
}

module pad_recess_cut(length, height, end_diameter, diameter, style, feature_height) {
  circle_center_x = length / 2 - end_diameter / 2;

  if (style == "Lowered") {
    translate([circle_center_x, 0, height - feature_height])
      cylinder(h = feature_height + 0.02, d = diameter, $fn = round_detail);
  }
}

module screw_cuts(length, height, end_diameter) {
  circle_center_x = length / 2 - end_diameter / 2;
  total_cut_height = height + (pad_style == "Raised" ? pad_height : 0) + 0.04;

  translate([circle_center_x, 0, -0.02])
    cylinder(h = total_cut_height, d = m3_hole_diameter, $fn = round_detail);

  if (counterbore_style == "Raised side") {
    translate([circle_center_x, 0, height + (pad_style == "Raised" ? pad_height : 0) - counterbore_depth])
      cylinder(h = counterbore_depth + 0.04, d = counterbore_diameter, $fn = round_detail);
  }

  if (counterbore_style == "Lowered side") {
    translate([circle_center_x, 0, -0.02])
      cylinder(h = counterbore_depth + 0.04, d = counterbore_diameter, $fn = round_detail);
  }
}

module hotbed_foot_arm_v2(
  length = arm_length,
  width = arm_width,
  height = arm_height,
  end_diameter = end_circle_diameter,
  position = model_position
) {
  placement = position == "Positive X" ? [length / 2, 0, 0] : [0, 0, 0];

  translate(placement)
    difference() {
      union() {
        arm_base(length, width, height, end_diameter);
        circle_pad(length, height, end_diameter, pad_diameter, pad_style, pad_height);
      }

      pad_recess_cut(length, height, end_diameter, pad_diameter, pad_style, pad_height);
      screw_cuts(length, height, end_diameter);
    }
}

hotbed_foot_arm_v2();
