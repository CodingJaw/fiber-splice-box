// Parametric/customizer wrapper for the original hotbed_foot.stl geometry.
// Self-contained: this file does not import or reference the source STL.
// Defaults intentionally match hotbed_foot_v2.scad and the original STL dimensions.
// Wall-strength options add material outside the source shape so inner geometry stays intact.

/* [Foot body] */
// Use Original STL to keep the exact source dimensions.
foot_size_preset = "Original STL"; // [Original STL, Custom]
// Custom left-to-right size; used only when foot_size_preset is Custom.
custom_foot_length = 34.63543701; // [20:0.1:80]
// Custom front-to-back size; used only when foot_size_preset is Custom.
custom_foot_width = 20; // [10:0.1:60]
// Custom bottom-to-top size; used only when foot_size_preset is Custom.
custom_foot_height = 12; // [4:0.1:40]

/* [Large notch opening] */
// Original STL keeps the notch exactly as modeled in the STL.
large_notch_preset = "Original STL"; // [Original STL, Wider, Narrower, Deeper, Shallower, Custom]
// Custom left/right scale for the large notch area; used only when large_notch_preset is Custom.
custom_large_notch_width_scale = 1.00; // [0.5:0.01:1.5]
// Custom front/back scale for the large notch area; used only when large_notch_preset is Custom.
custom_large_notch_depth_scale = 1.00; // [0.5:0.01:1.5]


/* [Wall strength] */
// Original STL adds no extra wall material. Strength presets expand outward only.
wall_strength_preset = "Original STL"; // [Original STL, +1 mm, +2 mm, Custom]
// Custom outward wall expansion; used only when wall_strength_preset is Custom.
custom_wall_expansion = 0.00; // [0:0.1:8]
// Which outside walls get extra material. Inner openings are not subtracted or resized.
wall_expansion_area = "Sides and Back"; // [Sides and Back, Sides Only, Back Only, All Outside]

/* [Top wall notch] */
// Original Left matches the source STL. Mirrored Right flips the foot so the notch moves to the other side.
top_notch_side = "Original Left"; // [Original Left, Mirrored Right]

/* [Placement] */
// Centered opens visibly at the origin; Source STL places the part at the original STL coordinates.
model_position = "Centered"; // [Centered, Source STL]

orig_length = 34.63543701;
orig_width = 20;
orig_height = 12;
source_center = [149.8822937, 138.25900269, 6];

function resolved_length() = foot_size_preset == "Original STL" ? orig_length : custom_foot_length;
function resolved_width() = foot_size_preset == "Original STL" ? orig_width : custom_foot_width;
function resolved_height() = foot_size_preset == "Original STL" ? orig_height : custom_foot_height;

function large_notch_width_scale() =
  large_notch_preset == "Wider" ? 1.10 :
  large_notch_preset == "Narrower" ? 0.90 :
  large_notch_preset == "Custom" ? custom_large_notch_width_scale :
  1.00;

function large_notch_depth_scale() =
  large_notch_preset == "Deeper" ? 1.10 :
  large_notch_preset == "Shallower" ? 0.90 :
  large_notch_preset == "Custom" ? custom_large_notch_depth_scale :
  1.00;


function wall_expansion_amount() =
  wall_strength_preset == "+1 mm" ? 1.00 :
  wall_strength_preset == "+2 mm" ? 2.00 :
  wall_strength_preset == "Custom" ? custom_wall_expansion :
  0.00;

module outside_wall_reinforcement(length, width, height, expansion, area) {
  overlap = 0.02;
  if (expansion > 0) {
    union() {
      if (area == "Sides and Back" || area == "Sides Only" || area == "All Outside") {
        translate([-length / 2 - expansion, -width / 2, -height / 2])
          cube([expansion + overlap, width, height]);
        translate([length / 2 - overlap, -width / 2, -height / 2])
          cube([expansion + overlap, width, height]);
      }

      if (area == "Sides and Back" || area == "Back Only" || area == "All Outside") {
        translate([-length / 2 - (area == "All Outside" ? expansion : 0), width / 2 - overlap, -height / 2])
          cube([length + (area == "All Outside" ? 2 * expansion : 0), expansion + overlap, height]);
      }

      if (area == "All Outside") {
        translate([-length / 2 - expansion, -width / 2 - expansion, -height / 2])
          cube([length + 2 * expansion, expansion + overlap, height]);
      }
    }
  }
}

module hotbed_foot_original_mesh_v5() {
  polyhedron(
    points = [
      [15.32070923, 10, 4.9980011],
      [17.31771851, 10, 4.9980011],
      [15.32070923, 10, -0.20199966],
      [17.31771851, 10, -6],
      [0.93670654, 1.9039917, -6],
      [0.93670654, 1.9039917, -4.0019989],
      [0.31771851, 2.0019989, -4.0019989],
      [0.31771851, 2.0019989, -6],
      [1.4947052, 1.61999512, -4.0019989],
      [-14.68429565, 10, -0.20199966],
      [17.31771851, -10, -6],
      [17.31771851, -10, 6],
      [-17.31771851, -10, 3.50236511],
      [-17.31771851, -10, 6],
      [-17.31771851, -10, -6],
      [-14.68429565, -6.0019989, 6],
      [15.32070923, -6.0019989, 6],
      [17.31771851, 5.9980011, 6],
      [15.32070923, 5.9980011, 6],
      [0.31771851, -2.0019989, -4.0019989],
      [0.93670654, -1.90400696, -4.0019989],
      [0.93670654, -1.90400696, -6],
      [0.31771851, -2.0019989, -6],
      [-0.30130005, -1.90400696, -4.0019989],
      [-0.30130005, -1.90400696, -6],
      [-0.85929871, -1.61999512, -4.0019989],
      [-0.85929871, -1.61999512, -6],
      [-1.30229187, -1.17700195, -6],
      [-1.30229187, -1.17700195, -4.0019989],
      [-14.68429565, -6.0019989, -4.0019989],
      [-1.58628845, -0.6190033, -6],
      [-1.58628845, -0.6190033, -4.0019989],
      [-1.68429565, 0, -6],
      [-1.68429565, 0, -4.0019989],
      [1.4947052, 1.61999512, -6],
      [1.93771362, 1.17700195, -4.0019989],
      [1.93771362, 1.17700195, -6],
      [15.32070923, 6.0019989, -4.0019989],
      [2.22271729, 0.61898804, -4.0019989],
      [2.22271729, 0.61898804, -6],
      [2.32070923, 0, -4.0019989],
      [2.32070923, 0, -6],
      [2.22271729, -0.6190033, -4.0019989],
      [2.22271729, -0.6190033, -6],
      [1.93771362, -1.17700195, -4.0019989],
      [1.93771362, -1.17700195, -6],
      [15.32070923, -6.0019989, -4.0019989],
      [1.4947052, -1.61999512, -4.0019989],
      [1.4947052, -1.61999512, -6],
      [-17.31771851, -6.89901733, 6],
      [-1.58628845, 0.61898804, -4.0019989],
      [-14.68429565, 6.0019989, -4.0019989],
      [-1.30229187, 1.17700195, -4.0019989],
      [-0.85929871, 1.61999512, -4.0019989],
      [-0.30130005, 1.9039917, -4.0019989],
      [-17.31771851, -6.31982422, -6],
      [-17.31771851, 4.72679138, -6],
      [-0.30130005, 1.9039917, -6],
      [-0.85929871, 1.61999512, -6],
      [-17.31771851, 5.91101074, -6],
      [-17.31771851, 5.69773865, -6],
      [-17.31771851, -7.01554871, -6],
      [-17.31771851, -7.17828369, -6],
      [-17.31771851, -6.56124878, -6],
      [-17.31771851, -6.80236816, -6],
      [-17.31771851, 6.03193665, -6],
      [-17.31771851, -7.27697754, -6],
      [-1.30229187, 1.17700195, -6],
      [-17.31771851, 5.41018677, -6],
      [-1.58628845, 0.61898804, -6],
      [-17.31771851, 5.06710815, -6],
      [-17.31771851, 5.39915466, -6],
      [-17.31771851, 10, -6],
      [17.31771851, 5.9980011, 4.9980011],
      [15.32070923, 5.9980011, 4.9980011],
      [-14.68429565, 6.0019989, -0.20199966],
      [15.32070923, 6.0019989, -0.20199966],
      [-17.31771851, -3.89782715, 6],
      [-14.68429565, 10, 6],
      [-17.31771851, 10, 6],
      [-17.31771851, 9.9969635, 6],
      [-17.31771851, 10, -0.96550751],
      [-17.31771851, 10, 0.61470413],
    ],
    faces = [
      [2, 1, 0],
      [2, 3, 1],
      [6, 5, 4],
      [7, 6, 4],
      [5, 8, 4],
      [9, 3, 2],
      [12, 11, 10],
      [12, 13, 11],
      [14, 12, 10],
      [16, 11, 15],
      [16, 18, 17],
      [11, 16, 17],
      [21, 20, 19],
      [22, 21, 19],
      [22, 19, 23],
      [24, 22, 23],
      [24, 23, 25],
      [26, 24, 25],
      [25, 28, 27],
      [26, 25, 27],
      [25, 29, 28],
      [28, 31, 30],
      [27, 28, 30],
      [31, 33, 32],
      [30, 31, 32],
      [29, 31, 28],
      [31, 29, 33],
      [4, 8, 34],
      [34, 8, 35],
      [36, 34, 35],
      [8, 37, 35],
      [36, 35, 38],
      [39, 36, 38],
      [37, 8, 5],
      [35, 37, 38],
      [39, 38, 40],
      [41, 39, 40],
      [41, 40, 42],
      [43, 41, 42],
      [43, 42, 44],
      [45, 43, 44],
      [42, 46, 44],
      [45, 44, 47],
      [48, 45, 47],
      [44, 46, 47],
      [47, 21, 48],
      [21, 47, 20],
      [47, 46, 20],
      [13, 15, 11],
      [13, 49, 15],
      [5, 6, 37],
      [40, 38, 37],
      [40, 46, 42],
      [46, 40, 37],
      [46, 19, 20],
      [19, 46, 29],
      [29, 23, 19],
      [25, 23, 29],
      [33, 51, 50],
      [51, 53, 52],
      [51, 54, 53],
      [56, 55, 32],
      [59, 58, 57],
      [59, 60, 58],
      [4, 3, 7],
      [61, 24, 26],
      [61, 62, 24],
      [63, 27, 30],
      [63, 64, 27],
      [36, 3, 34],
      [3, 4, 34],
      [65, 57, 7],
      [65, 59, 57],
      [10, 43, 45],
      [10, 41, 43],
      [10, 45, 48],
      [41, 10, 3],
      [39, 41, 3],
      [3, 36, 39],
      [64, 26, 27],
      [64, 61, 26],
      [66, 10, 22],
      [66, 14, 10],
      [22, 10, 21],
      [21, 10, 48],
      [62, 22, 24],
      [62, 66, 22],
      [60, 67, 58],
      [60, 68, 67],
      [70, 32, 69],
      [70, 56, 32],
      [55, 30, 32],
      [55, 63, 30],
      [71, 69, 67],
      [71, 70, 69],
      [72, 7, 3],
      [72, 65, 7],
      [17, 73, 11],
      [73, 10, 11],
      [73, 3, 10],
      [3, 73, 1],
      [18, 74, 73],
      [17, 18, 73],
      [18, 16, 74],
      [74, 0, 1],
      [73, 74, 1],
      [2, 76, 75],
      [75, 76, 37],
      [76, 2, 0],
      [76, 16, 46],
      [74, 76, 0],
      [16, 76, 74],
      [46, 37, 76],
      [29, 46, 16],
      [29, 16, 15],
      [75, 9, 2],
      [33, 50, 69],
      [32, 33, 69],
      [50, 51, 52],
      [50, 52, 67],
      [69, 50, 67],
      [52, 53, 58],
      [67, 52, 58],
      [53, 54, 57],
      [58, 53, 57],
      [57, 54, 6],
      [7, 57, 6],
      [51, 6, 54],
      [6, 51, 37],
      [68, 71, 67],
      [49, 77, 15],
      [75, 29, 15],
      [80, 79, 78],
      [77, 78, 15],
      [77, 80, 78],
      [81, 3, 9],
      [81, 72, 3],
      [79, 9, 78],
      [79, 82, 9],
      [82, 81, 9],
      [51, 75, 37],
      [51, 33, 29],
      [75, 15, 78],
      [75, 78, 9],
      [29, 75, 51],
      [49, 13, 12],
      [77, 49, 12],
      [80, 77, 12],
      [79, 80, 12],
      [82, 79, 12],
      [81, 82, 12],
      [72, 81, 12],
      [65, 72, 12],
      [59, 65, 12],
      [60, 59, 12],
      [68, 60, 12],
      [71, 68, 12],
      [70, 71, 12],
      [56, 70, 12],
      [55, 56, 12],
      [63, 55, 12],
      [64, 63, 12],
      [61, 64, 12],
      [62, 61, 12],
      [66, 62, 12],
      [14, 66, 12],
    ],
    convexity = 10
  );
}

module hotbed_foot_v5(
  position = model_position,
  notch_side = top_notch_side
) {
  placement = position == "Source STL" ? source_center : [0, 0, 0];
  body_scale = [resolved_length() / orig_length, resolved_width() / orig_width, resolved_height() / orig_height];
  notch_scale = [large_notch_width_scale(), large_notch_depth_scale(), 1];
  mirror_for_notch = notch_side == "Mirrored Right" ? [-1, 1, 1] : [1, 1, 1];

  translate(placement)
    scale(body_scale)
      union() {
        scale(mirror_for_notch)
          // The notch-scale control is centered on the original mesh so Original STL remains exact at 1.00.
          scale(notch_scale)
            hotbed_foot_original_mesh_v5();

        // Reinforcement is added outside the original bounding box only, preserving all inner/source geometry.
        outside_wall_reinforcement(orig_length, orig_width, orig_height, wall_expansion_amount(), wall_expansion_area);
      }
}

hotbed_foot_v5();
