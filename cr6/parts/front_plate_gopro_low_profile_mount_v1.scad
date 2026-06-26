// Combined CR6 front base plate + low-profile trimmed GoPro two-blade v3 mount.
// Uses the parametric base plate from front_plate_base_v1.scad and the trimmed/corner-relieved gopro_mount_2blade_v3.scad.
// Dropdown-only options are provided for plate holes, thickness, and mount rotation.

use <front_plate_base_v1.scad>
use <gopro_mount_2blade_v3.scad>

/* [Plate Options] */
plate_hole_mode = 2; // [0:Left diagonal, 1:Right diagonal, 2:All four holes]
base_plate_thickness = 2.0; // [1.5:1.5mm, 2.0:2.0mm, 2.5:2.5mm, 3.0:3.0mm, 4.0:4.0mm]

/* [Mount Options] */
mount_rotation_degrees = 0; // [0, 45, 90, 135, 180, 225, 270, 315]

// Bounds measured from gopro_mount_2blade_v3.scad output so the mount is translated only, not reshaped.
gopro_v3_min = [146.718002, 107.614998, 8.5];
gopro_v3_max = [161.718002, 122.614998, 25.0];
gopro_v3_center = [(gopro_v3_min[0] + gopro_v3_max[0]) / 2, (gopro_v3_min[1] + gopro_v3_max[1]) / 2];

module centered_gopro_mount_2blade_v3(thickness = base_plate_thickness, rotation = mount_rotation_degrees) {
    translate([0, 0, thickness - gopro_v3_min[2] - 0.05])
        rotate([0, 0, rotation])
            translate([-gopro_v3_center[0], -gopro_v3_center[1], 0])
                gopro_mount_2blade_v3();
}

module front_plate_gopro_low_profile_mount_v1(hole_mode = plate_hole_mode, thickness = base_plate_thickness, rotation = mount_rotation_degrees) {
    front_plate_base_v1(hole_mode, thickness);
    centered_gopro_mount_2blade_v3(thickness, rotation);
}

front_plate_gopro_low_profile_mount_v1();
