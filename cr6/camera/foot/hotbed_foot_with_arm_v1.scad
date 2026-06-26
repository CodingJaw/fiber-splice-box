// Combined hotbed foot + single selectable arm attachment.
// Foot uses hotbed_foot_v6.scad; arm uses hotbed_foot_arm_v2.scad.
// Notch/front side of the foot is +Y. Arms attach on the opposite side and extend toward -Y.

use <hotbed_foot_v6.scad>
use <hotbed_foot_arm_v2.scad>

/* [Assembly] */
// Select exactly one arm attachment location.
arm_attach_location = "Center"; // [Left, Center, Right]
// Show colored preview matching the reference sketch.
preview_colors = "Enabled"; // [Enabled, Disabled]

/* [Foot settings] */
// Foot placement is centered by default for easier assembly alignment.
foot_position = "Centered"; // [Centered, Source STL]
// Keep original notch side or mirror the foot/notch.
foot_notch_side = "Original Left"; // [Original Left, Mirrored Right]

/* [Arm settings] */
// Arm length from attachment edge to far side of round end.
arm_length = 103.91; // [30:0.1:180]
// Arm width.
arm_width = 12.00; // [6:0.1:60]
// Arm height/thickness.
arm_height = 12.00; // [2:0.1:30]
// Round end diameter.
arm_end_circle_diameter = 21.00; // [10:0.1:80]
// How far the arm overlaps into the foot for a fused printable joint.
arm_attach_overlap = 2.00; // [0:0.1:10]

/* [Attachment geometry] */
// Left and right arm angles measured in degrees from +X before the arm is rotated into place.
side_arm_angle = 45; // [15:1:75]
// X position of the side attachments from center. Default lands near the foot corners.
side_attach_x = 15.30; // [4:0.1:25]
foot_length = 34.63543701;
foot_width = 20.00;
foot_height = 12.00;

module maybe_color(name) {
  if (preview_colors == "Enabled") {
    color(name) children();
  } else {
    children();
  }
}

module placed_arm(location) {
  z_base = -foot_height / 2;
  attach_y = -foot_width / 2 + arm_attach_overlap;

  if (location == "Center") {
    translate([0, attach_y, z_base])
      rotate([0, 0, -90])
        hotbed_foot_arm_v2(
          length = arm_length,
          width = arm_width,
          height = arm_height,
          end_diameter = arm_end_circle_diameter,
          position = "Positive X"
        );
  }

  if (location == "Left") {
    translate([-side_attach_x, attach_y, z_base])
      rotate([0, 0, -90 - side_arm_angle])
        hotbed_foot_arm_v2(
          length = arm_length,
          width = arm_width,
          height = arm_height,
          end_diameter = arm_end_circle_diameter,
          position = "Positive X"
        );
  }

  if (location == "Right") {
    translate([side_attach_x, attach_y, z_base])
      rotate([0, 0, -90 + side_arm_angle])
        hotbed_foot_arm_v2(
          length = arm_length,
          width = arm_width,
          height = arm_height,
          end_diameter = arm_end_circle_diameter,
          position = "Positive X"
        );
  }
}

module hotbed_foot_with_arm_v1(
  location = arm_attach_location
) {
  union() {
    maybe_color("gold")
      hotbed_foot_v6(position = foot_position, notch_side = foot_notch_side);

    maybe_color("blue")
      placed_arm(location);
  }
}

hotbed_foot_with_arm_v1();
