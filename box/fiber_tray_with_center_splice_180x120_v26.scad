/*
  Fiber Tray With Centered MID-FLEX Oval Fiber Holder + Straight 4-Splice Holder 180x120 V26

  Purpose:
    Places the current 4.3 mm MID-FLEX oval fiber holder on a tray/base plate
    and adds the current OPEN HI-THIN splice holder flat in the center at 0 degrees.

  Default layout:
    - Tray/base plate: 160 mm long x 105 mm wide for the 180x120 box
    - Oval holder: centered on tray
    - Center splice holder: OPEN HI-THIN size 2, 4 sleeves, 38 mm holder length, rotated 0 degrees
    - Holder style: MID-FLEX oval/racetrack
    - Fiber mock/keepout: 4.3 mm fiber with clearance
    - Finger settings use the requested default profile
    - Oval keeper lips use a symmetric mirrored layout by default
    - Optional off-ramp/pass-through line continues ONE selected long straight side past BOTH oval ends
    - Default off ramp is the top long-side path only
    - V14 removes the actual remaining outer curved transition wall segments at the selected long-side pass-through openings
    - Duplicate racetrack straight-wall geometry is skipped and replaced by the pass-through wall pair
    - Outer curved wall segments are opened at the transition so the pass-through does not collide with the racetrack
    - Inner wall behavior remains controlled only by Remove_Inner_Wall_On_Short_Ends
    - V23 removes the remaining baseplate/outline-rib lip by cutting directly at the racetrack wall outside edge
    - 180x120 V24 expands the tray/base footprint from the 120x80 tray size to fit the 180x120 box
      while leaving the centered splice holder dimensions/settings unchanged.
    - 180x120 V25 narrows the tray-side hinge bridge and limits the hinge-side rear trim
      to the hinge bridge area so the tray keeps more usable baseplate.
    - 180x120 V26 scales the oval/racetrack holder width from the 120x80 tray proportions
      so the hinge bridge depth stays narrow instead of filling the larger tray margin.

  Export:
    Set Show_Mock_Fiber = false before exporting STL.
*/

$fn = 72;

/* [Preset / Main Mode] */

// ============================================================
// CUSTOMIZER - PRESET / MAIN MODE
// ============================================================

// Main preset selector. Use Custom manual if you want the values in the
// "Manual Profile Values" tab to control the oval holder dimensions.
// 1 = older straight MID-FLEX test-strip settings
// 2 = requested oval defaults
// 3 = use the manual custom values below
Settings_Profile = 2; // [1:Previous MID-FLEX strip, 2:Requested oval default, 3:Custom manual]

/* [Manual Profile Values] */

// ============================================================
// CUSTOMIZER - MANUAL VALUES USED WHEN Settings_Profile = 3
// ============================================================

Custom_Channel_Length = 60;                    // [25:1:160]
Custom_Fiber_Bottom_Clearance = 1.05;          // [0:0.05:2.5]
Custom_Fiber_Keepout_Radial_Clearance = 0.35;  // [0:0.05:1.0]
Custom_Finger_Count = 4;                       // [1:20]
Custom_Finger_Tip_To_Opposite_Wall_Gap = 2.35; // [0.8:0.05:6.0]
Custom_Wall_Height = 7.0;                      // [3:0.1:14]
Custom_Wall_Thickness = 1.3;                   // [0.5:0.05:2.5]

/* [Tray / Base Plate] */

// ============================================================
// CUSTOMIZER - TRAY / BASE PLATE
// ============================================================

Tray_Length = 160;                     // [50:1:180]
Tray_Width = 105;                      // [30:1:120]
Tray_Base_Thickness = 1.0;             // [0.6:0.1:4]
Tray_Corner_Radius = 3.0;              // [0:0.1:10]

// Optional low outline lip around tray edge.
Show_Tray_Outline_Rib = true;          // [true,false]
Tray_Outline_Rib_Width = 0.55;         // [0.25:0.05:2.0]
Tray_Outline_Rib_Height = 0.25;        // [0.1:0.05:1.0]

/* [Oval Holder Placement] */

// ============================================================
// CUSTOMIZER - OVAL HOLDER PLACEMENT ON TRAY
// ============================================================

Holder_X_Offset = 0;                   // [-50:0.5:50]
Holder_Y_Offset = 0;                   // [-30:0.5:30]
Holder_Rotation = 0;                   // [0:1:359]

// When true, only the holder walls/fingers are added to the tray.
// The tray itself acts as the base plate.
Use_Tray_As_Holder_Base = true;        // [true,false]

// Optional rectangular holder base under the oval, usually not needed when
// the holder is already being placed on a tray.
Holder_Base_Length = 160;              // [50:1:180]
Holder_Base_Width = 105;               // [30:1:120]
Holder_Base_Thickness = 1.0;           // [0.4:0.1:4]
Holder_Base_Corner_Radius = 3.0;       // [0:0.1:10]


/* [Center Splice Holder Placement] */

// ============================================================
// CUSTOMIZER - CENTER SPLICE HOLDER PLACEMENT
// ============================================================

Show_Center_Splice_Holder = true;      // [true,false]
Splice_Holder_X_Offset = 0;            // [-40:0.5:40]
Splice_Holder_Y_Offset = 0;            // [-25:0.5:25]
Splice_Holder_Rotation = 0;            // [0:1:359]

// True = no separate rectangular base under the splice holder; the tray itself
// acts as the base. This is best for putting it flat in the middle of the oval.
Use_Tray_As_Splice_Base = true;        // [true,false]

/* [Center Splice Holder Settings] */

// ============================================================
// CUSTOMIZER - CENTER SPLICE HOLDER SETTINGS
// ============================================================

// Default is the current working splice holder: OPEN HI-THIN 2.
Splice_Size_Profile = 2;               // [1:Tight, 2:Current OPEN HI-THIN 2, 3:Loose]
Splice_Count = 4;                      // [1:12]
Splice_Center_Distance = 7.2;          // [5:0.1:16]
Splice_Holder_Length = 38;             // [20:1:120]

Splice_Base_Length = 70;               // [30:1:140]
Splice_Base_Width = 30;                // [12:1:90]
Splice_Base_Thickness = 1.0;           // [0.4:0.1:4]
Splice_Base_Corner_Radius = 2.0;       // [0:0.1:8]

Splice_Sleeve_Diameter = 3.2;          // [1.5:0.1:6]
Splice_Mock_Sleeve_Length = 60;        // [20:1:100]
Splice_Crimp_Clearance_D = 0.45;       // [0:0.05:1.5]
Splice_Crimp_Z_Offset = 0.35;          // [0:0.05:1.5]

Splice_Finger_Count = 5;               // [3:10]
Splice_Finger_Width = 3.4;             // [1.5:0.1:8]
Splice_Finger_Height = 3.10;           // [1.5:0.1:6]
Splice_Finger_Lip_Thickness = 0.62;    // [0.3:0.05:1.5]

Splice_Side_Rail_Width = 0.95;         // [0.5:0.05:2.5]
Splice_Side_Rail_Height = 1.35;        // [0.5:0.05:4]
Splice_Lower_Guide_Height_Ratio = 0.62;// [0.3:0.05:0.9]

Splice_Groove_Depth = 0.36;            // [0:0.05:1.2]
Splice_Groove_Extra_Width = 0.05;      // [0:0.05:1.0]

Splice_Show_Mock_Sleeves = true;       // [true,false]
Splice_Show_Label = false;             // [false,true]

/* [Fiber Slot / Clearance] */

// ============================================================
// CUSTOMIZER - FIBER / SLOT SETTINGS
// ============================================================

Mock_Fiber_Diameter = 4.3;             // [1:0.1:8]
Minimum_Slot_Inside_Gap = 4.0;         // [3:0.1:8]
Fiber_Side_Clearance = 0.35;           // [0:0.05:1.5]
Finger_Top_Clearance = 0.25;           // [0:0.05:1.0]

Minimum_Finger_Reach = 0.50;           // [0.2:0.05:3.0]
Minimum_Finger_Tip_Gap = 0.60;         // [0.2:0.05:3.0]
Finger_X_Width = 4.0;                  // [1.5:0.1:8]
Finger_Lip_Thickness = 0.65;           // [0.3:0.05:1.5]

/* [Oval / Racetrack Pattern] */

// ============================================================
// CUSTOMIZER - OVAL / RACETRACK PATTERN SETTINGS
// ============================================================

// Treats the path like a racetrack around two circles.
Oval_Outer_Circle_Diameter = 100;      // [30:1:120]
Oval_Center_Distance = 40;             // [0:1:120]
Auto_Center_Distance_From_Tray = true; // [true,false]
Oval_Outer_Inset = 0.6;                // [0:0.1:8]

Use_Full_Oval = true;                  // [true,false]
Partial_Path_Percent = 100;            // [10:5:100]

Straight_Segment_Spacing = 4.0;        // [2:0.5:10]
Arc_Angle_Step = 6;                    // [3:1:15]
Path_Cylinder_Extra = 1.8;             // [0:0.2:5]

// Opens the inner wall on the two rounded/short ends of the oval so fiber can
// pass from the racetrack into the center splice holder area. This is separate
// from the off-ramp openings. Off ramps now open only the outer wall.
Remove_Inner_Wall_On_Short_Ends = true; // [true,false]

// If true, the finger count is scaled around the oval using the selected
// Channel_Length as the reference. If false, each path section gets the raw
// selected Finger_Count.
Scale_Fingers_Around_Oval = true;      // [true,false]
Minimum_Total_Fingers = 8;             // [4:1:80]
Maximum_Total_Fingers = 80;            // [8:1:140]

// Makes the oval keeper lips mirror cleanly left/right and top/bottom instead
// of simply alternating by walking around the path. This gives a more even,
// symmetric lip pattern while keeping the same MID-FLEX finger style.
Use_Symmetric_Lip_Layout = true;       // [true,false]
Symmetric_Lip_Start_Outer = true;      // [true,false]
Symmetric_Lip_End_Clearance = 3.0;     // [0:0.25:10]
Minimum_Straight_Lips_Per_Side = 2;    // [1:1:30]
Minimum_Arc_Lips_Per_End = 2;          // [1:1:30]

/* [Off Ramp Extensions] */

// ============================================================
// CUSTOMIZER - OFF RAMP EXTENSIONS
// ============================================================

// Adds a straight pass-through extension to a selected LONG side of the oval.
// The selected straight run continues past BOTH oval ends, forming one straight line.
// Default is one long side only. 1 = top long side, 2 = bottom long side, 3 = both long sides.
Off_Ramp_Mode = 1;                     // [0:Off, 1:Top long side only, 2:Bottom long side only, 3:Both long sides]

// V10 default: build the selected long side as one continuous straight channel
// from tray edge to tray edge. This prevents the new off-ramp walls from
// interfering with the racetrack straight wall pieces.
Off_Ramp_Pass_Through_Line = true;     // [true,false]
Auto_Off_Ramp_Length_To_Tray_Edge = true; // [true,false]
Off_Ramp_Length = 24;                  // [4:1:60]
Off_Ramp_End_Inset_From_Tray = 5.0;    // [1:0.5:20]
Off_Ramp_Overlap_Into_Oval = 0.0;      // [0:0.25:8]

Off_Ramp_Add_Fingers = true;           // [true,false]
Off_Ramp_Finger_Count_Per_Run = 2;     // [0:1:12]
Off_Ramp_Match_Symmetric_Lips = true;  // [true,false]

// Keeps the final model clean by not leaving duplicate racetrack straight-wall
// pieces underneath the new pass-through line. The inner wall is replaced in
// the same location by the pass-through wall pair; it is not removed from the final part.
Off_Ramp_Replace_Selected_Straight_Walls = true; // [true,false]

// Removes the two inner-wall sections marked in red in the reference diagram.
// This keeps the selected long-side off-ramp as a straight path, but leaves
// openings between the center straight channel and the outer end tails.
Remove_Red_Inner_Wall_Segments = true; // [true,false]
Off_Ramp_Inner_Wall_Removal_Length = 17.0; // [0:0.5:35]

// Opens the oval OUTER wall only where the pass-through line crosses the curved
// racetrack transition. This is the part that removes the blocking outer wall
// between the two MID-FLEX channel walls.
Open_Outer_Wall_For_Off_Ramps = true;  // [true,false]
Open_Outer_Straight_End_For_Off_Ramps = true; // [true,false]
Off_Ramp_Outer_Wall_Opening_Angle = 38;// [6:1:70]

// V13 cleanup cut: removes any leftover wall/finger/ramp material at the
// selected long-side off-ramp transition so it cannot protrude into the
// 4.3 mm mock cord/fiber clearance.
Apply_Off_Ramp_Transition_Keepout = false; // [true,false]
Off_Ramp_Transition_Keepout_Length = 18.0; // [2:0.5:24]
Off_Ramp_Transition_Keepout_Width_Extra = 3.0; // [0:0.1:6]
Off_Ramp_Transition_Keepout_Height_Extra = 1.5; // [0.2:0.1:5]


// V15 shaped outer transition walls. These restore the red-marked wall shape
// after the previous version removed too much material near the off-ramp.
Add_Shaped_Outer_Transition_Walls = true; // [true,false]
Transition_Wall_Horizontal_Length = 7.5;  // [2:0.5:20]
Transition_Wall_Diagonal_Length = 9.0;    // [2:0.5:20]
Transition_Wall_Diagonal_Angle = 32;      // [10:1:60]
Transition_Wall_Y_Trim = 0.35;            // [0:0.05:2.0]

/* [Finger Ramp Supports] */

// ============================================================
// CUSTOMIZER - FINGER RAMP SUPPORTS
// ============================================================

Add_Ramped_Finger_Supports = true;     // [true,false]
Support_Min_Reach = 0.75;              // [0.3:0.05:2.5]
Support_Tip_Inset = 0.10;              // [0:0.05:0.5]
Support_Web_Thickness = 0.18;          // [0.08:0.01:0.5]
Support_Embed_Into_Lip = 0.08;         // [0:0.01:0.25]


/* [Tray Hinge - Yellow Tray Side] */

// ============================================================
// CUSTOMIZER - TRAY HINGE / YELLOW TRAY-SIDE EARS
// ============================================================

// Adds the yellow tray-side hinge ears that match the wedge hinge mounted on the box.
// Default follows the off-ramp side.
Show_Tray_Hinge = true;                 // [true,false]
Tray_Hinge_Side_Mode = 0;               // [0:Same side as off-ramp, 1:Top long side, 2:Bottom long side]
Tray_Hinge_X_Offset = 0;                // [-40:0.5:40]
Tray_Hinge_Y_Offset = 0;                // [-20:0.5:20]
Tray_Hinge_Z_Offset = 0;                // [-3:0.1:8]
Tray_Hinge_Rotation_Adjust = 0;         // [-30:1:30]

// Positive value pulls the hinge inward toward the tray/racetrack wall.
// Set this to 0 to match the V18 hinge distance.
Tray_Hinge_Pull_Toward_Tray = 1.5;      // [0:0.1:8]

// Hinge dimensions copied from current_v2_wedge_tray_hinge_standalone.scad.
// Tray side owns the two outside barrels/ears; the box wedge owns the inner barrels.
Hinge_Pin_Hole_D = 2.20;                // [1.5:0.05:3.5]
Hinge_Knuckle_OD = 6.5;                 // [4:0.1:10]
Hinge_Barrel_Len = 10.0;                // [5:0.5:20]
Hinge_Side_Gap = 0.70;                  // [0.2:0.05:2.0]
Hinge_Center_Access_Gap = 15.0;         // [5:0.5:35]
Hinge_Tray_Edge_Height = 8.0;           // [3:0.1:16]
Hinge_Barrel_Edge_Gap = 3.0;            // [0:0.1:8]
Hinge_Solid_Overlap = 1.50;             // [0.4:0.1:4]
Hinge_Ear_Anchor_H = 4.9;               // [2:0.1:10]
Hinge_Ear_Anchor_Y = 1.5;               // [0.5:0.1:5]
Hinge_Ear_Flatten_Back = true;          // [true,false]
Hinge_Ear_Flat_Y_T = 2.0;               // [0.5:0.1:5]
Hinge_Ear_Flat_Z = 6.0;                 // [2:0.1:12]

// Fills the gap between the hinge mounting pad and the selected racetrack/pass-through wall.
Connect_Hinge_To_Racetrack_Wall = true;  // [true,false]
Hinge_Wall_Bridge_Width = 62.0;          // [20:1:110]
Hinge_Wall_Bridge_Height = 7.0;          // [1:0.1:12]
Hinge_Wall_Bridge_Overlap = 0.80;        // [0:0.05:3.0]
Hinge_Bottom_On_XY_Plane = true;         // [true,false]
Hinge_Wall_Bridge_Hinge_Overlap = 1.6;   // [0:0.1:5.0]



/* [Opposite Side Baseplate Trim] */

// ============================================================
// CUSTOMIZER - OPPOSITE SIDE BASEPLATE TRIM
// ============================================================

// Removes baseplate-level material outside/past the racetrack walls on the side opposite the hinge.
// With the default hinge/off-ramp on the top side, this cuts the U-shaped area around the bottom and side arcs.
Trim_Baseplate_Opposite_Hinge = true;   // [true,false]
Baseplate_Trim_Extra_Clearance = 0.0;   // [0:0.05:3.0]
Baseplate_Trim_Keep_Side_Edge = 0.0;    // [0:0.5:15]
Baseplate_Trim_Cut_Height = 2.4;        // [0.6:0.05:4.0]

// Removes rear/hinge-side baseplate only around the hinge bridge instead of cutting a full-width strip.
Trim_Baseplate_Hinge_Side_Rear = true;  // [true,false]
Rear_Baseplate_Trim_Extra_Clearance = 0.0;  // [0:0.05:3.0]
Rear_Baseplate_Trim_Side_Clearance = 4.0;   // [0:0.5:20]

// Adds back the two short inner racetrack wall tails marked green.
Add_Missing_Hinge_Side_Track_Wall_Tails = true; // [true,false]
Missing_Track_Wall_Tail_Length = 11.0;  // [2:0.5:30]
Missing_Track_Wall_End_Inset = 2.0;     // [0:0.5:12]
Missing_Track_Wall_Y_Adjust = 0.0;      // [-2:0.05:2]


/* [Preview / Export] */

// ============================================================
// CUSTOMIZER - PREVIEW / EXPORT
// ============================================================

Apply_Global_Fiber_Keepout = true;     // [true,false]
Show_Mock_Fiber = true;                // [true,false]
Show_Label = true;                     // [true,false]
Show_Center_Mark = false;              // [true,false]

// Small overlap to avoid tangent-face/non-manifold issues.
EPS = 0.04;                            // [0.005:0.005:0.1]

// ============================================================
// BUILD
// ============================================================

tray_with_centered_mid_flex_fiber_holder();

module tray_with_centered_mid_flex_fiber_holder() {
    difference() {
        union() {
            // Main tray/base plate with optional V21/V22 base-only trim cuts.
            tray_baseplate_trimmed();

            if (Show_Tray_Outline_Rib)
                translate([0, 0, Tray_Base_Thickness - EPS])
                    tray_outline_rib_trimmed();

            // Optional separate rectangular holder base.
            if (!Use_Tray_As_Holder_Base)
                translate([Holder_X_Offset, Holder_Y_Offset, Tray_Base_Thickness - EPS])
                    rotate([0, 0, Holder_Rotation])
                        rounded_box_centered([Holder_Base_Length, Holder_Base_Width, Holder_Base_Thickness + EPS], Holder_Base_Corner_Radius);

            // Actual centered fiber holder geometry.
            translate([Holder_X_Offset, Holder_Y_Offset, holder_mount_z()])
                rotate([0, 0, Holder_Rotation])
                    oval_channel_holder();

            // Current working splice holder, flat in the middle of the oval.
            if (Show_Center_Splice_Holder)
                translate([Splice_Holder_X_Offset, Splice_Holder_Y_Offset, splice_holder_mount_z()])
                    rotate([0, 0, Splice_Holder_Rotation])
                        center_open_hi_thin_splice_holder_printable();

            // Yellow tray-side hinge ears, matched to the V2 wedge hinge on the box.
            if (Show_Tray_Hinge)
                place_tray_side_hinge_on_selected_side();

            if (Show_Label)
                translate([0, -Tray_Width/2 + 4.2, Tray_Base_Thickness - EPS])
                    raised_label("MID-FLEX CENTER", 3.0, 0.32 + EPS);

            if (Show_Center_Mark)
                translate([0, 0, Tray_Base_Thickness - EPS])
                    center_mark();
        }

        // Final global fiber keepout. This is cut after the whole tray/holder
        // union is built, so no wall, finger, ramp, label, or tray rib can
        // protrude into the fiber volume.
        if (Apply_Global_Fiber_Keepout)
            translate([Holder_X_Offset, Holder_Y_Offset, holder_mount_z()])
                rotate([0, 0, Holder_Rotation])
                    oval_fiber_keepout_path();

        // V13 final local cleanup at the straight pass-through/oval transition.
        // This removes the small highlighted solid nibs that can remain inside
        // the mock cord clearance near the off-ramp entrance/exit.
        if (Apply_Off_Ramp_Transition_Keepout)
            translate([Holder_X_Offset, Holder_Y_Offset, holder_mount_z()])
                rotate([0, 0, Holder_Rotation])
                    off_ramp_transition_keepout();

        // Baseplate trim cuts are now applied only inside tray_baseplate_trimmed()
        // so hinge, bridge, and racetrack walls are not cut from below.
    }

    // Transparent preview fiber. It is not part of the printed STL.
    if (Show_Mock_Fiber)
        translate([Holder_X_Offset, Holder_Y_Offset, holder_mount_z()])
            rotate([0, 0, Holder_Rotation])
                %oval_mock_fiber_path();

    if (Show_Center_Splice_Holder && Splice_Show_Mock_Sleeves)
        translate([Splice_Holder_X_Offset, Splice_Holder_Y_Offset, splice_holder_mount_z()])
            rotate([0, 0, Splice_Holder_Rotation])
                center_splice_holder_mock_sleeves();
}

function holder_mount_z() = Use_Tray_As_Holder_Base
    ? Tray_Base_Thickness - EPS
    : Tray_Base_Thickness + Holder_Base_Thickness - 2*EPS;

function splice_holder_mount_z() = Use_Tray_As_Splice_Base
    ? Tray_Base_Thickness - EPS
    : Tray_Base_Thickness - EPS;

function splice_channel_z_offset() = Use_Tray_As_Splice_Base
    ? 0
    : Splice_Base_Thickness - EPS;

function splice_y_pos(i) = (i - (Splice_Count - 1) / 2) * Splice_Center_Distance;

function splice_clearance_by_profile(v) =
    v == 1 ? 0.15 :
    v == 2 ? 0.35 :
             0.60;

function splice_crimp_z() = Splice_Sleeve_Diameter/2 + Splice_Crimp_Z_Offset;

module center_open_hi_thin_splice_holder_printable() {
    difference() {
        union() {
            if (!Use_Tray_As_Splice_Base)
                rounded_box_centered([Splice_Base_Length, Splice_Base_Width, Splice_Base_Thickness], Splice_Base_Corner_Radius);

            for (i = [0:Splice_Count-1]) {
                y = splice_y_pos(i);
                translate([0, y, splice_channel_z_offset()])
                    center_splice_open_hi_thin_channel(Splice_Size_Profile);
            }

            if (Splice_Show_Label) {
                translate([0, -Splice_Base_Width/2 + 3.0, splice_channel_z_offset()])
                    raised_label(str("OPEN HI-THIN ", Splice_Size_Profile), 3.0, 0.32 + EPS);
            }
        }
    }
}

module center_splice_open_hi_thin_channel(profile) {
    channel_w = Splice_Sleeve_Diameter + splice_clearance_by_profile(profile);

    difference() {
        union() {
            center_splice_style_open_hi_thin(channel_w, profile);
        }

        // Oversized crimp keepout: no printed geometry should enter the splice sleeve body.
        center_splice_crimp_keepout_cut();

        // Shallow bottom locator groove. It is harmless when the tray is used as the base.
        translate([0, 0, -EPS])
            center_splice_rounded_slot_cut(Splice_Holder_Length - 5,
                                           channel_w + Splice_Groove_Extra_Width,
                                           Splice_Groove_Depth + EPS);
    }
}

module center_splice_style_open_hi_thin(channel_w, profile) {
    post_y = channel_w/2 + Splice_Side_Rail_Width/2;
    rail_h = Splice_Side_Rail_Height;
    clip_count = Splice_Finger_Count;
    clip_len = Splice_Finger_Width;
    post_h = Splice_Finger_Height;
    lip_t = Splice_Finger_Lip_Thickness;

    base_lip_depth =
        profile == 1 ? 0.78 :
        profile == 2 ? 0.60 :
                       0.44;

    lip_depth = base_lip_depth + 0.08;

    // Low continuous side rails guide each splice sleeve while leaving the top open.
    for (side = [-1, 1]) {
        translate([0, side * post_y, rail_h/2])
            cube([Splice_Holder_Length, Splice_Side_Rail_Width, rail_h + EPS], center = true);
    }

    // Alternating left/right keeper fingers, same concept as current working splice holder.
    for (n = [0:clip_count-1]) {
        x = -Splice_Holder_Length/2 + 7 + n * ((Splice_Holder_Length - 14) / max(1, clip_count - 1));
        side = (n % 2 == 0) ? -1 : 1;

        // Tall outside post.
        translate([x, side * post_y, post_h/2])
            cube([clip_len, Splice_Side_Rail_Width, post_h + EPS], center = true);

        // Top keeper lip. The crimp keepout trims it away from the sleeve body.
        translate([x, side * (channel_w/2 - lip_depth/2 + EPS/2), post_h - lip_t/2])
            cube([clip_len, lip_depth + EPS, lip_t], center = true);

        // Lower opposite guide keeps the path fishable instead of closing it.
        translate([x, -side * post_y, (post_h * Splice_Lower_Guide_Height_Ratio)/2])
            cube([clip_len, Splice_Side_Rail_Width, post_h * Splice_Lower_Guide_Height_Ratio + EPS], center = true);
    }

    // Small angled start guides on both ends.
    for (xend = [-1, 1]) {
        for (side = [-1, 1]) {
            translate([xend * (Splice_Holder_Length/2 - 2.0), side * post_y, rail_h + 0.35])
                rotate([0, 0, xend * side * 18])
                    cube([4.0, Splice_Side_Rail_Width, 0.70], center = true);
        }
    }
}

module center_splice_crimp_keepout_cut() {
    translate([0, 0, splice_crimp_z()])
        rotate([0, 90, 0])
            cylinder(h = max(Splice_Mock_Sleeve_Length, Splice_Holder_Length) + 10,
                     d = Splice_Sleeve_Diameter + Splice_Crimp_Clearance_D,
                     center = true);
}

module center_splice_holder_mock_sleeves() {
    for (i = [0:Splice_Count-1]) {
        y = splice_y_pos(i);
        translate([0, y, splice_channel_z_offset()])
            %center_splice_mock_crimp();
    }
}

module center_splice_mock_crimp() {
    translate([0, 0, splice_crimp_z()])
        rotate([0, 90, 0])
            cylinder(h = Splice_Mock_Sleeve_Length, d = Splice_Sleeve_Diameter, center = true);
}

module center_splice_rounded_slot_cut(len, width, height) {
    safe_len = max(len, width + 0.1);
    linear_extrude(height = height)
        hull() {
            translate([-safe_len/2 + width/2, 0]) circle(d = width);
            translate([ safe_len/2 - width/2, 0]) circle(d = width);
        }
}

// ============================================================
// PRESET-AWARE VALUES
// ============================================================

function selected_channel_length() =
    Settings_Profile == 1 ? 52 :
    Settings_Profile == 2 ? 60 : Custom_Channel_Length;

function selected_fiber_bottom_clearance() =
    Settings_Profile == 1 ? 0.35 :
    Settings_Profile == 2 ? 1.05 : Custom_Fiber_Bottom_Clearance;

function selected_fiber_keepout_radial_clearance() =
    Settings_Profile == 1 ? 0.20 :
    Settings_Profile == 2 ? 0.35 : Custom_Fiber_Keepout_Radial_Clearance;

function selected_finger_count() =
    Settings_Profile == 1 ? 5 :
    Settings_Profile == 2 ? 4 : Custom_Finger_Count;

function selected_finger_tip_gap() =
    Settings_Profile == 1 ? 3.65 :
    Settings_Profile == 2 ? 2.35 : Custom_Finger_Tip_To_Opposite_Wall_Gap;

function selected_wall_height() =
    Settings_Profile == 1 ? 6.0 :
    Settings_Profile == 2 ? 7.0 : Custom_Wall_Height;

function selected_wall_thickness() =
    Settings_Profile == 1 ? 0.95 :
    Settings_Profile == 2 ? 1.3 : Custom_Wall_Thickness;

// ============================================================
// CORE DIMENSIONS / FUNCTIONS
// ============================================================

function effective_slot_gap() = max(Minimum_Slot_Inside_Gap, Mock_Fiber_Diameter + 2 * Fiber_Side_Clearance);
function fiber_center_z_local() = selected_fiber_bottom_clearance() + Mock_Fiber_Diameter / 2;
function fiber_keepout_d() = Mock_Fiber_Diameter + 2 * selected_fiber_keepout_radial_clearance();
function fiber_keepout_top_z_local() = fiber_center_z_local() + fiber_keepout_d() / 2;
function clamp_value(v, lo, hi) = min(max(v, lo), hi);
function finger_reach() = clamp_value(effective_slot_gap() - selected_finger_tip_gap(),
                                      Minimum_Finger_Reach,
                                      max(Minimum_Finger_Reach, effective_slot_gap() - Minimum_Finger_Tip_Gap));
function finger_under_z() = fiber_keepout_top_z_local() + Finger_Top_Clearance;
function calculated_wall_height() = max(selected_wall_height(), finger_under_z() + Finger_Lip_Thickness + 0.30);

function channel_outer_half_width() = effective_slot_gap()/2 + selected_wall_thickness();
function racetrack_center_distance() = Auto_Center_Distance_From_Tray
    ? max(0, Tray_Length - Oval_Outer_Circle_Diameter)
    : Oval_Center_Distance;

// Centerline radius is pulled inward so the outside of the channel fits inside
// the selected outer-circle diameter.
function path_radius() = max(3, Oval_Outer_Circle_Diameter/2 - Oval_Outer_Inset - channel_outer_half_width());
function racetrack_full_length_est() = 2 * racetrack_center_distance() + 2 * PI * path_radius();
function used_path_fraction() = Use_Full_Oval ? 1 : clamp_value(Partial_Path_Percent/100, 0.1, 1);
function total_fingers_for_oval() = Scale_Fingers_Around_Oval
    ? clamp_value(round(selected_finger_count() * racetrack_full_length_est() * used_path_fraction() / max(1, selected_channel_length())), Minimum_Total_Fingers, Maximum_Total_Fingers)
    : selected_finger_count();

// ============================================================
// OVAL HOLDER GEOMETRY
// ============================================================

module oval_channel_holder() {
    r = path_radius();
    d = racetrack_center_distance();
    gap = effective_slot_gap();
    wall_t = selected_wall_thickness();
    wall_h = calculated_wall_height();

    union() {
        racetrack_side_walls(r, d, gap, wall_t, wall_h);
        racetrack_fingers(r, d, gap, wall_t, wall_h);
        off_ramp_channel_holder(r, d, gap, wall_t, wall_h);

        if (Add_Missing_Hinge_Side_Track_Wall_Tails)
            missing_hinge_side_track_wall_tails(r, d, gap, wall_t, wall_h);
    }
}


// Off-ramp openings are now tied to the selected LONG side, not to one short end.
// path_side =  1 is the top straight run. path_side = -1 is the bottom straight run.
function normalized_angle(a) = a < 0 ? a + 360 : a;
function angle_delta_deg(a, target) = abs(normalized_angle(a) - target) > 180
    ? 360 - abs(normalized_angle(a) - target)
    : abs(normalized_angle(a) - target);
function angle_near_deg(a, target, tol) = angle_delta_deg(a, target) <= tol;

function off_ramp_long_side_active(path_side) =
    Off_Ramp_Mode == 3 ? true :
    Off_Ramp_Mode == 1 ? (path_side == 1) :
    Off_Ramp_Mode == 2 ? (path_side == -1) : false;

function skip_outer_wall_for_off_ramp(end_sign, side, a) =
    Open_Outer_Wall_For_Off_Ramps &&
    side == 1 &&
    (
        (off_ramp_long_side_active( 1) && angle_near_deg(a,  90, Off_Ramp_Outer_Wall_Opening_Angle)) ||
        (off_ramp_long_side_active(-1) && angle_near_deg(a, 270, Off_Ramp_Outer_Wall_Opening_Angle))
    );

// Removes only the OUTER straight wall section at the two selected long-side
// exit points. The INNER wall is intentionally not skipped here. This creates
// a clean opening between the two MID-FLEX channel walls while keeping the
// racetrack inner wall intact.
function skip_selected_straight_for_pass_through(path_side) =
    Off_Ramp_Pass_Through_Line &&
    Off_Ramp_Replace_Selected_Straight_Walls &&
    off_ramp_long_side_active(path_side);

function skip_outer_straight_end_for_off_ramp(x, path_side, side, d) =
    // In pass-through mode, the selected straight run is not duplicated; it is
    // replaced by one continuous wall pair generated by off_ramp_pass_through_walls().
    skip_selected_straight_for_pass_through(path_side) ||
    (
        Open_Outer_Straight_End_For_Off_Ramps &&
        side == 1 &&
        off_ramp_long_side_active(path_side) &&
        abs(abs(x) - d/2) <= (Straight_Segment_Spacing + 0.45)
    );

module racetrack_side_walls(r, d, gap, wall_t, wall_h) {
    // Top and bottom straight walls.
    // Off-ramp openings remove only the end-most OUTER wall section on the
    // selected long side. Inner walls remain in place.
    for (x = [-d/2 : Straight_Segment_Spacing : d/2 + 0.001]) {
        for (side = [-1, 1]) {
            if (!skip_outer_straight_end_for_off_ramp(x,  1, side, d))
                place_oriented_box([x,  r, 0], 0,   side * (gap/2 + wall_t/2), [Straight_Segment_Spacing + 0.8, wall_t, wall_h + EPS], wall_h/2);
            if (!skip_outer_straight_end_for_off_ramp(x, -1, side, d))
                place_oriented_box([x, -r, 0], 180, side * (gap/2 + wall_t/2), [Straight_Segment_Spacing + 0.8, wall_t, wall_h + EPS], wall_h/2);
        }
    }

    // Right end circle, clockwise from top to bottom.
    // side =  1 is the outer wall. side = -1 is the inner wall.
    // The inner wall can be omitted on the short rounded ends to create
    // access openings from the oval fiber path toward the center splice holder.
    for (a = [90 : -Arc_Angle_Step : -90 + 0.001]) {
        for (side = [-1, 1]) {
            if (!(Remove_Inner_Wall_On_Short_Ends && side == -1) &&
                !skip_outer_wall_for_off_ramp(1, side, a)) {
                p = [d/2 + r*cos(a), r*sin(a), 0];
                theta = a - 90;
                place_oriented_box(p, theta, side * (gap/2 + wall_t/2), [arc_segment_len(r), wall_t, wall_h + EPS], wall_h/2);
            }
        }
    }

    // Left end circle, clockwise from bottom to top.
    // side =  1 is the outer wall. side = -1 is the inner wall.
    for (a = [270 : -Arc_Angle_Step : 90 + 0.001]) {
        for (side = [-1, 1]) {
            if (!(Remove_Inner_Wall_On_Short_Ends && side == -1) &&
                !skip_outer_wall_for_off_ramp(-1, side, a)) {
                p = [-d/2 + r*cos(a), r*sin(a), 0];
                theta = a - 90;
                place_oriented_box(p, theta, side * (gap/2 + wall_t/2), [arc_segment_len(r), wall_t, wall_h + EPS], wall_h/2);
            }
        }
    }
}

module racetrack_fingers(r, d, gap, wall_t, wall_h) {
    if (Use_Symmetric_Lip_Layout) {
        racetrack_fingers_symmetric(r, d, gap, wall_t, wall_h);
    } else {
        fcnt = total_fingers_for_oval();

        for (n = [0 : fcnt - 1]) {
            s = (n + 0.5) / max(1, fcnt);
            path_position_and_finger(s, n, r, d, gap, wall_t, wall_h);
        }
    }
}

function symmetric_lip_side(n) =
    Symmetric_Lip_Start_Outer
        ? ((n % 2 == 0) ? 1 : -1)
        : ((n % 2 == 0) ? -1 : 1);

function auto_straight_lips_per_side() =
    max(Minimum_Straight_Lips_Per_Side,
        round(total_fingers_for_oval() * max(0.001, racetrack_center_distance()) / max(1, racetrack_full_length_est())));

function auto_arc_lips_per_end(r) =
    max(Minimum_Arc_Lips_Per_End,
        round(total_fingers_for_oval() * PI * r / max(1, racetrack_full_length_est())));

module racetrack_fingers_symmetric(r, d, gap, wall_t, wall_h) {
    straight_cnt = auto_straight_lips_per_side();
    arc_cnt = auto_arc_lips_per_end(r);
    usable_straight = max(0.001, d - 2 * Symmetric_Lip_End_Clearance);
    arc_margin_deg = min(35, max(0, Symmetric_Lip_End_Clearance / max(0.001, r) * 180 / PI));
    usable_arc_deg = max(20, 180 - 2 * arc_margin_deg);

    // Top and bottom straight sections. Each top lip has a matching mirrored
    // bottom lip at the same X position and same inner/outer start side.
    if (d > 0.5) {
        for (i = [0 : straight_cnt - 1]) {
            x = -usable_straight/2 + (i + 0.5) * usable_straight / straight_cnt;
            side = symmetric_lip_side(i);

            add_finger_at_with_side([x,  r, 0], 0,   side, gap, wall_t, wall_h);
            add_finger_at_with_side([x, -r, 0], 180, side, gap, wall_t, wall_h);
        }
    }

    // Left and right rounded ends. The right-side lip and left-side lip are
    // mirrored across the centerline, using the same inner/outer start side.
    for (i = [0 : arc_cnt - 1]) {
        a = 90 - arc_margin_deg - (i + 0.5) * usable_arc_deg / arc_cnt;
        side = symmetric_lip_side(i + straight_cnt);

        // Right rounded end.
        add_finger_at_with_side([d/2 + r*cos(a), r*sin(a), 0], a - 90, side, gap, wall_t, wall_h);

        // Left rounded end, mirrored from the right rounded end.
        add_finger_at_with_side([-d/2 - r*cos(a), r*sin(a), 0], 90 - a, side, gap, wall_t, wall_h);
    }
}

module path_position_and_finger(s, n, r, d, gap, wall_t, wall_h) {
    // Approximate distribution by length around: top straight, right arc,
    // bottom straight, left arc.
    top_len = d;
    arc_len = PI * r;
    full_len = 2 * top_len + 2 * arc_len;
    target = s * full_len * used_path_fraction();

    if (target <= top_len) {
        x = -d/2 + target;
        add_finger_at([x, r, 0], 0, n, gap, wall_t, wall_h);
    } else if (target <= top_len + arc_len) {
        t = (target - top_len) / max(0.001, arc_len);
        a = 90 - 180 * t;
        add_finger_at([d/2 + r*cos(a), r*sin(a), 0], a - 90, n, gap, wall_t, wall_h);
    } else if (target <= 2*top_len + arc_len) {
        t = target - top_len - arc_len;
        x = d/2 - t;
        add_finger_at([x, -r, 0], 180, n, gap, wall_t, wall_h);
    } else {
        t = (target - 2*top_len - arc_len) / max(0.001, arc_len);
        a = 270 - 180 * t;
        add_finger_at([-d/2 + r*cos(a), r*sin(a), 0], a - 90, n, gap, wall_t, wall_h);
    }
}

module add_finger_at(p, theta, n, gap, wall_t, wall_h) {
    side = (n % 2 == 0) ? 1 : -1; // legacy alternating outer/inner wall starts
    add_finger_at_with_side(p, theta, side, gap, wall_t, wall_h);
}

module add_finger_at_with_side(p, theta, side, gap, wall_t, wall_h) {
    reach = finger_reach();
    under_z = finger_under_z();

    // Local upright root/support at the wall.
    place_oriented_box(p, theta, side * (gap/2 + wall_t/2), [Finger_X_Width, wall_t + EPS, wall_h + EPS], wall_h/2);

    // Finger lip across the slot.
    place_oriented_box(p, theta, side * (gap/2 - reach/2 + EPS/2), [Finger_X_Width, reach + EPS, Finger_Lip_Thickness], under_z + Finger_Lip_Thickness/2);

    // Ramped underside print support.
    if (Add_Ramped_Finger_Supports && reach >= Support_Min_Reach)
        ramped_finger_support_at(p, theta, side, reach, under_z, gap);
}

module ramped_finger_support_at(p, theta, side, reach, under_z, gap) {
    y_wall = side * (gap/2 - EPS/2);
    y_tip  = side * (gap/2 - reach + Support_Tip_Inset);
    z_low  = -EPS;
    z_top  = under_z + Support_Embed_Into_Lip;

    hull() {
        place_oriented_box(p, theta, y_wall,
                           [Finger_X_Width + EPS, Support_Web_Thickness, z_top - z_low],
                           (z_top + z_low)/2);

        place_oriented_box(p, theta, y_tip,
                           [Finger_X_Width + EPS, Support_Web_Thickness, Support_Web_Thickness],
                           z_top - Support_Web_Thickness/2);
    }
}

// Local X follows the tangent, local Y crosses the slot.
module place_oriented_box(p, theta, cross_offset, size, zc) {
    translate([p[0], p[1], zc])
        rotate([0, 0, theta])
            translate([0, cross_offset, 0])
                cube(size, center = true);
}

function arc_segment_len(r) = max(2.0, 2 * PI * r * Arc_Angle_Step / 360 + 1.0);



// ============================================================
// V22 MISSING SHORT TRACK WALL TAILS
// ============================================================

module missing_hinge_side_track_wall_tails(r, d, gap, wall_t, wall_h) {
    path_side = tray_hinge_selected_side();
    theta = off_ramp_theta_for_path_side(path_side);
    cy = path_side * r;
    len = max(0.1, Missing_Track_Wall_Tail_Length);
    x_center = max(0, Tray_Length/2 - Missing_Track_Wall_End_Inset - len/2);
    inner_cross = -1 * (gap/2 + wall_t/2) + Missing_Track_Wall_Y_Adjust;

    // These restore the two short inner wall pieces marked green, one on each
    // end of the hinge/off-ramp side. They do not fill the center channel.
    for (end_sign = [-1, 1])
        place_oriented_box([end_sign * x_center, cy, 0], theta, inner_cross,
                           [len + EPS, wall_t, wall_h + EPS], wall_h/2);
}

// ============================================================
// OFF RAMP / PASS-THROUGH GEOMETRY
// ============================================================

function off_ramp_effective_length(d) = Auto_Off_Ramp_Length_To_Tray_Edge
    ? max(0, Tray_Length/2 - d/2 - Off_Ramp_End_Inset_From_Tray)
    : Off_Ramp_Length;

function off_ramp_pass_through_half_len(d) = Auto_Off_Ramp_Length_To_Tray_Edge
    ? max(d/2, Tray_Length/2 - Off_Ramp_End_Inset_From_Tray)
    : d/2 + Off_Ramp_Length;

function off_ramp_pass_through_len(d) = 2 * off_ramp_pass_through_half_len(d);
function off_ramp_inner_wall_gap_len(d) = min(Off_Ramp_Inner_Wall_Removal_Length,
                                             max(0, off_ramp_pass_through_half_len(d) - d/2));
function off_ramp_inner_wall_tail_len(d) = max(0, off_ramp_pass_through_half_len(d) - d/2 - off_ramp_inner_wall_gap_len(d));
function off_ramp_total_length(d) = off_ramp_effective_length(d) + Off_Ramp_Overlap_Into_Oval;
function off_ramp_end_segment_center_x(end_sign, d) = end_sign * (d/2 + (off_ramp_effective_length(d) - Off_Ramp_Overlap_Into_Oval)/2);
function off_ramp_start_x(end_sign, d) = end_sign * (d/2 - Off_Ramp_Overlap_Into_Oval);
function off_ramp_end_x(end_sign, d) = end_sign * off_ramp_pass_through_half_len(d);
function off_ramp_theta_for_path_side(path_side) = path_side > 0 ? 0 : 180;

module off_ramp_channel_holder(r, d, gap, wall_t, wall_h) {
    if (Off_Ramp_Mode != 0) {
        for (path_side = [-1, 1]) {
            if (off_ramp_long_side_active(path_side)) {
                if (Off_Ramp_Pass_Through_Line) {
                    off_ramp_pass_through_walls(path_side, r, d, gap, wall_t, wall_h);
                    if (Off_Ramp_Add_Fingers) {
                        for (end_sign = [-1, 1])
                            off_ramp_end_fingers(end_sign, path_side, r, d, gap, wall_t, wall_h);
                    }
                    if (Add_Shaped_Outer_Transition_Walls)
                        shaped_outer_transition_walls(path_side, r, d, gap, wall_t, wall_h);
                } else if (off_ramp_effective_length(d) > 0.1) {
                    for (end_sign = [-1, 1]) {
                        off_ramp_end_walls(end_sign, path_side, r, d, gap, wall_t, wall_h);
                        if (Off_Ramp_Add_Fingers)
                            off_ramp_end_fingers(end_sign, path_side, r, d, gap, wall_t, wall_h);
                    }
                    if (Add_Shaped_Outer_Transition_Walls)
                        shaped_outer_transition_walls(path_side, r, d, gap, wall_t, wall_h);
                }
            }
        }
    }
}


module shaped_outer_transition_walls(path_side, r, d, gap, wall_t, wall_h) {
    // Desired transition shape: a short horizontal segment plus a diagonal
    // segment at each end, following the red-marked reference. These pieces are
    // placed outside the fiber keepout path.
    theta = off_ramp_theta_for_path_side(path_side);
    cy = path_side * r;
    outer_cross = gap/2 + wall_t/2 + max(0, Transition_Wall_Y_Trim);
    hlen = max(0.1, Transition_Wall_Horizontal_Length);
    dlen = max(0.1, Transition_Wall_Diagonal_Length);
    diag_angle = Transition_Wall_Diagonal_Angle;

    for (end_sign = [-1, 1]) {
        // Horizontal short wall tail at the selected long-side transition.
        hx = end_sign * (d/2 + hlen/2 - EPS);
        place_oriented_box([hx, cy, 0], theta, outer_cross,
                           [hlen + EPS, wall_t, wall_h + EPS], wall_h/2);

        // Diagonal wall, mirrored at each end. The diagonal leans toward the
        // curved oval section without intruding into the cord keepout.
        dx = end_sign * (d/2 - dlen/2 + hlen*0.10);
        local_angle = theta - end_sign * path_side * diag_angle;
        translate([dx, cy, 0])
            rotate([0, 0, local_angle])
                translate([0, outer_cross, wall_h/2])
                    cube([dlen + EPS, wall_t, wall_h + EPS], center = true);
    }
}

module off_ramp_pass_through_walls(path_side, r, d, gap, wall_t, wall_h) {
    len = off_ramp_pass_through_len(d);
    half_len = off_ramp_pass_through_half_len(d);
    remove_len = off_ramp_inner_wall_gap_len(d);
    tail_len = off_ramp_inner_wall_tail_len(d);
    cy = path_side * r;
    theta = off_ramp_theta_for_path_side(path_side);

    // One clean, straight OUTER wall across the selected long side.
    // side = 1 is the outer wall for both top and bottom long sides.
    place_oriented_box([0, cy, 0], theta, 1 * (gap/2 + wall_t/2),
                       [len + EPS, wall_t, wall_h + EPS], wall_h/2);

    // The INNER wall is split so the two red-marked sections from the
    // reference diagram are removed. This prevents the pass-through wall
    // from blocking the fiber transition into the racetrack.
    if (!Remove_Red_Inner_Wall_Segments || remove_len <= 0.001) {
        place_oriented_box([0, cy, 0], theta, -1 * (gap/2 + wall_t/2),
                           [len + EPS, wall_t, wall_h + EPS], wall_h/2);
    } else {
        // Center inner wall inside the original racetrack straight section.
        if (d > 0.001)
            place_oriented_box([0, cy, 0], theta, -1 * (gap/2 + wall_t/2),
                               [d + EPS, wall_t, wall_h + EPS], wall_h/2);

        // V12: do not recreate the short end-tail wall segments.
        // Only the center inner wall section remains on the selected
        // long-side pass-through path. This matches the latest reference
        // sketch where the small leftover straight tail pieces are removed.
        // (tail_len intentionally not used here.)
    }
}

module off_ramp_end_walls(end_sign, path_side, r, d, gap, wall_t, wall_h) {
    len = off_ramp_total_length(d);
    cx = off_ramp_end_segment_center_x(end_sign, d);
    cy = path_side * r;
    theta = off_ramp_theta_for_path_side(path_side);

    for (side = [-1, 1]) {
        place_oriented_box([cx, cy, 0], theta, side * (gap/2 + wall_t/2),
                           [len + EPS, wall_t, wall_h + EPS], wall_h/2);
    }
}

module off_ramp_end_fingers(end_sign, path_side, r, d, gap, wall_t, wall_h) {
    cnt = max(0, Off_Ramp_Finger_Count_Per_Run);
    theta = off_ramp_theta_for_path_side(path_side);
    cy = path_side * r;
    sx = off_ramp_start_x(end_sign, d);
    ex = off_ramp_end_x(end_sign, d);

    if (cnt > 0) {
        for (i = [0 : cnt - 1]) {
            t = (i + 0.5) / cnt;
            x = sx + (ex - sx) * t;
            side = Off_Ramp_Match_Symmetric_Lips ? symmetric_lip_side(i) : ((i % 2 == 0) ? 1 : -1);
            add_finger_at_with_side([x, cy, 0], theta, side, gap, wall_t, wall_h);
        }
    }
}


module off_ramp_transition_keepout() {
    if (Off_Ramp_Mode != 0 && Off_Ramp_Pass_Through_Line) {
        r = path_radius();
        d = racetrack_center_distance();
        gap = effective_slot_gap();
        wall_t = selected_wall_thickness();
        wall_h = selected_wall_height();

        cut_len = max(0.1, Off_Ramp_Transition_Keepout_Length);
        cut_w = gap + 2*wall_t + 2*Off_Ramp_Transition_Keepout_Width_Extra;
        cut_h = wall_h + Off_Ramp_Transition_Keepout_Height_Extra + EPS;
        zc = cut_h/2 - EPS;

        for (path_side = [-1, 1]) {
            if (off_ramp_long_side_active(path_side)) {
                theta = off_ramp_theta_for_path_side(path_side);

                // V14: cut where the remaining curved outer transition segments
                // actually appear: just outside the racetrack straight-end, not
                // in the middle of the straight pass-through.
                for (end_sign = [-1, 1]) {
                    cx = end_sign * (d/2 + cut_len/2 - EPS);
                    cy = path_side * (r - cut_w/2 + gap/2 + wall_t/2);
                    translate([cx, cy, zc])
                        rotate([0, 0, theta])
                            cube([cut_len + 2*EPS, cut_w, cut_h], center = true);
                }
            }
        }
    }
}

module off_ramp_cyl_path(r, d, dia, zc) {
    if (Off_Ramp_Mode != 0) {
        for (path_side = [-1, 1]) {
            if (off_ramp_long_side_active(path_side)) {
                cy = path_side * r;
                theta = off_ramp_theta_for_path_side(path_side);

                if (Off_Ramp_Pass_Through_Line) {
                    place_oriented_cylinder([0, cy, 0], theta,
                                            off_ramp_pass_through_len(d) + Path_Cylinder_Extra,
                                            dia, zc);
                } else if (off_ramp_effective_length(d) > 0.1) {
                    for (end_sign = [-1, 1]) {
                        len = off_ramp_total_length(d) + Path_Cylinder_Extra;
                        cx = off_ramp_end_segment_center_x(end_sign, d);
                        place_oriented_cylinder([cx, cy, 0], theta, len, dia, zc);
                    }
                }
            }
        }
    }
}

// ============================================================
// MOCK FIBER AND GLOBAL KEEP-OUT
// ============================================================

module oval_mock_fiber_path() {
    racetrack_cyl_path(path_radius(), racetrack_center_distance(), Mock_Fiber_Diameter, fiber_center_z_local());
    off_ramp_cyl_path(path_radius(), racetrack_center_distance(), Mock_Fiber_Diameter, fiber_center_z_local());
}

module oval_fiber_keepout_path() {
    racetrack_cyl_path(path_radius(), racetrack_center_distance(), fiber_keepout_d(), fiber_center_z_local());
    off_ramp_cyl_path(path_radius(), racetrack_center_distance(), fiber_keepout_d(), fiber_center_z_local());
}

module racetrack_cyl_path(r, d, dia, zc) {
    len_straight = Straight_Segment_Spacing + Path_Cylinder_Extra;
    len_arc = arc_segment_len(r) + Path_Cylinder_Extra;

    // Top and bottom straight path.
    for (x = [-d/2 : Straight_Segment_Spacing : d/2 + 0.001]) {
        place_oriented_cylinder([x, r, 0], 0,   len_straight, dia, zc);
        place_oriented_cylinder([x,-r, 0], 180, len_straight, dia, zc);
    }

    // Right arc.
    for (a = [90 : -Arc_Angle_Step : -90 + 0.001])
        place_oriented_cylinder([d/2 + r*cos(a), r*sin(a), 0], a - 90, len_arc, dia, zc);

    // Left arc.
    for (a = [270 : -Arc_Angle_Step : 90 + 0.001])
        place_oriented_cylinder([-d/2 + r*cos(a), r*sin(a), 0], a - 90, len_arc, dia, zc);
}

module place_oriented_cylinder(p, theta, len, dia, zc) {
    translate([p[0], p[1], zc])
        rotate([0, 0, theta])
            rotate([0, 90, 0])
                cylinder(h = len, d = dia, center = true);
}




// ============================================================
// BASEPLATE-ONLY TRIM WRAPPER
// ============================================================

module tray_baseplate_trimmed() {
    difference() {
        rounded_box_centered([Tray_Length, Tray_Width, Tray_Base_Thickness], Tray_Corner_Radius);

        if (Trim_Baseplate_Opposite_Hinge)
            opposite_hinge_baseplate_trim_cut();

        if (Trim_Baseplate_Hinge_Side_Rear)
            hinge_side_rear_baseplate_trim_cut();
    }
}

function hinge_side_rear_trim_start_y() =
    tray_hinge_selected_side()
    * (path_radius()
       + effective_slot_gap()/2
       + selected_wall_thickness()
       + Rear_Baseplate_Trim_Extra_Clearance);

function hinge_side_rear_trim_outer_y() =
    tray_hinge_selected_side() * (Tray_Width/2 + 3);

function hinge_side_rear_trim_center_y() =
    (hinge_side_rear_trim_start_y() + hinge_side_rear_trim_outer_y()) / 2;

function hinge_side_rear_trim_depth() =
    abs(hinge_side_rear_trim_outer_y() - hinge_side_rear_trim_start_y());

function hinge_side_rear_trim_length() =
    min(Tray_Length + 6, Hinge_Wall_Bridge_Width + 2*Rear_Baseplate_Trim_Side_Clearance);

module hinge_side_rear_baseplate_trim_cut() {
    cut_h = Baseplate_Trim_Cut_Height + EPS;

    translate([Tray_Hinge_X_Offset,
               hinge_side_rear_trim_center_y(),
               cut_h/2 - EPS])
        cube([hinge_side_rear_trim_length(),
              max(0.1, hinge_side_rear_trim_depth()),
              cut_h],
             center=true);
}

// ============================================================
// OPPOSITE-HINGE BASEPLATE TRIM
// ============================================================

function opposite_side_of_hinge() = -tray_hinge_selected_side();

// Outer edge of the racetrack wall plus a small clearance.
// The trim is made by cutting a large opposite-side region, then subtracting
// this capsule keepout so the racetrack wall and everything inside it remains.
function baseplate_trim_keepout_radius() =
    path_radius()
    + effective_slot_gap()/2
    + selected_wall_thickness()
    + Baseplate_Trim_Extra_Clearance;

// Default top hinge means opposite side is bottom.
// This limit reaches up to the top inner straight wall line, so the left/right
// outside arc areas are cleared too, matching the marked red U-shaped region.
function baseplate_trim_inner_limit_y() =
    -opposite_side_of_hinge()
    * (path_radius()
       - effective_slot_gap()/2
       - selected_wall_thickness()/2);

function baseplate_trim_outer_limit_y() =
    opposite_side_of_hinge() * (Tray_Width/2 + 3);

function baseplate_trim_center_y() =
    (baseplate_trim_outer_limit_y() + baseplate_trim_inner_limit_y()) / 2;

function baseplate_trim_depth() =
    abs(baseplate_trim_outer_limit_y() - baseplate_trim_inner_limit_y());

module racetrack_outer_keepout_2d_for_base_trim() {
    r_keep = baseplate_trim_keepout_radius();
    d = racetrack_center_distance();

    hull() {
        translate([-d/2, 0]) circle(r = r_keep);
        translate([ d/2, 0]) circle(r = r_keep);
    }
}

module opposite_hinge_baseplate_trim_cut() {
    cut_len = max(0.1, Tray_Length - 2*Baseplate_Trim_Keep_Side_Edge);
    cut_depth = max(0.1, baseplate_trim_depth());
    cut_h = Baseplate_Trim_Cut_Height + EPS;

    // Cut area = large rectangle on the side opposite the hinge.
    // Protected area = capsule around the racetrack outer walls.
    // Result = U-shaped baseplate-only removal outside the racetrack walls.
    difference() {
        translate([0,
                   baseplate_trim_center_y(),
                   cut_h/2 - EPS])
            cube([cut_len, cut_depth, cut_h], center=true);

        translate([Holder_X_Offset, Holder_Y_Offset, -2*EPS])
            rotate([0, 0, Holder_Rotation])
                linear_extrude(height = cut_h + 4*EPS)
                    racetrack_outer_keepout_2d_for_base_trim();
    }
}


// ============================================================
// CURRENT YELLOW TRAY-SIDE HINGE MODULES
// Based on current_v2_wedge_tray_hinge_standalone.scad
// ============================================================

function tray_hinge_selected_side() =
    Tray_Hinge_Side_Mode == 1 ?  1 :
    Tray_Hinge_Side_Mode == 2 ? -1 :
    Off_Ramp_Mode == 2       ? -1 :
                                1; // default top side when off-ramp is off, top, or both

function hinge_r() = Hinge_Knuckle_OD/2;
function hinge_rear_edge_y() = -Tray_Width/2;
function hinge_axis_y() = hinge_rear_edge_y() - Hinge_Barrel_Edge_Gap - hinge_r();
function hinge_axis_z() = Hinge_Bottom_On_XY_Plane ? hinge_r() : Hinge_Tray_Edge_Height/2;
function hinge_anchor_z(h) = Hinge_Bottom_On_XY_Plane ? h/2 : hinge_axis_z();
function hinge_span() = 4*Hinge_Barrel_Len + 2*Hinge_Side_Gap + Hinge_Center_Access_Gap;

function hinge_barrel_x(i) =
    let(start = -hinge_span()/2)
    i == 0 ? start + Hinge_Barrel_Len/2 :
    i == 1 ? start + Hinge_Barrel_Len + Hinge_Side_Gap + Hinge_Barrel_Len/2 :
    i == 2 ? start + 2*Hinge_Barrel_Len + Hinge_Side_Gap + Hinge_Center_Access_Gap + Hinge_Barrel_Len/2 :
             start + 3*Hinge_Barrel_Len + 2*Hinge_Side_Gap + Hinge_Center_Access_Gap + Hinge_Barrel_Len/2;

// Current matching set: tray owns the outside barrels.
function tray_hinge_owns_barrel(i) = (i == 0 || i == 3);

module hinge_cyl_x(len, d, center=true) {
    rotate([0,90,0])
        cylinder(h=len, d=d, center=center);
}

module tray_hinge_pin_bore_cut(extra=20) {
    translate([0, hinge_axis_y(), hinge_axis_z()])
        hinge_cyl_x(hinge_span() + extra, Hinge_Pin_Hole_D, center=true);
}

module tray_hinge_ear_current(i) {
    x = hinge_barrel_x(i);

    union() {
        hull() {
            // Hinge barrel.
            translate([x, hinge_axis_y(), hinge_axis_z()])
                hinge_cyl_x(Hinge_Barrel_Len, Hinge_Knuckle_OD, center=true);

            // Small anchor bridge back to tray edge.
            translate([x, hinge_rear_edge_y() + Hinge_Ear_Anchor_Y/2 - Hinge_Solid_Overlap, hinge_anchor_z(Hinge_Ear_Anchor_H)])
                cube([Hinge_Barrel_Len, Hinge_Ear_Anchor_Y + 2*Hinge_Solid_Overlap, Hinge_Ear_Anchor_H], center=true);

            // Flattened back pad against tray edge.
            if (Hinge_Ear_Flatten_Back)
                translate([x, hinge_rear_edge_y() - Hinge_Solid_Overlap, hinge_anchor_z(Hinge_Ear_Flat_Z)])
                    cube([Hinge_Barrel_Len, Hinge_Ear_Flat_Y_T, Hinge_Ear_Flat_Z], center=true);
        }

        translate([x, hinge_rear_edge_y() + Hinge_Ear_Anchor_Y/2 - Hinge_Solid_Overlap, hinge_anchor_z(Hinge_Ear_Anchor_H)])
            cube([Hinge_Barrel_Len, Hinge_Ear_Anchor_Y + 2*Hinge_Solid_Overlap, Hinge_Ear_Anchor_H], center=true);

        if (Hinge_Ear_Flatten_Back)
            translate([x, hinge_rear_edge_y() - Hinge_Solid_Overlap, hinge_anchor_z(Hinge_Ear_Flat_Z)])
                cube([Hinge_Barrel_Len, Hinge_Ear_Flat_Y_T, Hinge_Ear_Flat_Z], center=true);
    }
}

module tray_side_hinge_ears_only_current() {
    difference() {
        union() {
            for (i=[0:3])
                if (tray_hinge_owns_barrel(i))
                    tray_hinge_ear_current(i);
        }
        tray_hinge_pin_bore_cut();
    }
}


function outer_wall_center_y_for_hinge(side_sign) =
    side_sign * (path_radius() + effective_slot_gap()/2 + selected_wall_thickness()/2);

function hinge_bridge_outer_y_for_hinge(side_sign) =
    side_sign * (Tray_Width/2 + Hinge_Wall_Bridge_Hinge_Overlap - Tray_Hinge_Pull_Toward_Tray);

function hinge_bridge_center_y(side_sign) =
    (outer_wall_center_y_for_hinge(side_sign) + hinge_bridge_outer_y_for_hinge(side_sign)) / 2;

function hinge_bridge_depth(side_sign) =
    abs(hinge_bridge_outer_y_for_hinge(side_sign) - outer_wall_center_y_for_hinge(side_sign))
    + selected_wall_thickness()
    + 2*Hinge_Wall_Bridge_Overlap;

module hinge_to_racetrack_bridge(side_sign) {
    // Rectangular connector rib between the hinge anchor and the selected
    // racetrack/pass-through wall. V18 extends it into the hinge anchor and
    // starts it at the XY plane so there is no floating gap.
    translate([Tray_Hinge_X_Offset,
               hinge_bridge_center_y(side_sign) + Tray_Hinge_Y_Offset,
               Tray_Hinge_Z_Offset + Hinge_Wall_Bridge_Height/2])
        cube([Hinge_Wall_Bridge_Width,
              hinge_bridge_depth(side_sign),
              Hinge_Wall_Bridge_Height + EPS],
             center=true);
}

module place_tray_side_hinge_on_selected_side() {
    selected_side = tray_hinge_selected_side();

    // The uploaded hinge file is modeled on the negative-Y tray edge.
    // Bottom side uses it directly. Top/off-ramp side rotates it 180 degrees.
    translate([Tray_Hinge_X_Offset, Tray_Hinge_Y_Offset, Tray_Hinge_Z_Offset])
        rotate([0, 0, (selected_side > 0 ? 180 : 0) + Tray_Hinge_Rotation_Adjust])
            translate([0, Tray_Hinge_Pull_Toward_Tray, 0])
                tray_side_hinge_ears_only_current();

    // V17 bridge: closes the gap between the hinge mounting pad and the
    // racetrack/pass-through wall on the same side.
    if (Connect_Hinge_To_Racetrack_Wall)
        hinge_to_racetrack_bridge(selected_side);
}


// ============================================================
// TRAY / LABEL HELPERS
// ============================================================

module rounded_box_centered(size, r) {
    sx = size[0];
    sy = size[1];
    sz = size[2];
    rr = min(r, min(sx, sy)/2 - 0.01);

    if (rr <= 0) {
        translate([0, 0, sz/2])
            cube(size, center = true);
    } else {
        linear_extrude(height = sz)
            offset(r = rr)
                square([sx - 2*rr, sy - 2*rr], center = true);
    }
}


module tray_outline_rib_trimmed() {
    // V23: the outline rib/lip must be trimmed in the same regions as the
    // baseplate, otherwise a raised lip remains in the removed areas.
    difference() {
        tray_outline_rib();

        if (Trim_Baseplate_Opposite_Hinge)
            translate([0, 0, -Tray_Base_Thickness])
                opposite_hinge_baseplate_trim_cut();

        if (Trim_Baseplate_Hinge_Side_Rear)
            translate([0, 0, -Tray_Base_Thickness])
                hinge_side_rear_baseplate_trim_cut();
    }
}

module tray_outline_rib() {
    rib_h = Tray_Outline_Rib_Height + EPS;
    rib_w = Tray_Outline_Rib_Width;

    difference() {
        rounded_box_centered([Tray_Length - 1.2, Tray_Width - 1.2, rib_h], max(0, Tray_Corner_Radius - 0.2));
        translate([0, 0, -EPS])
            rounded_box_centered([Tray_Length - 1.2 - 2*rib_w, Tray_Width - 1.2 - 2*rib_w, rib_h + 2*EPS], max(0, Tray_Corner_Radius - rib_w - 0.2));
    }
}

module raised_label(txt, size_mm, height_mm) {
    linear_extrude(height = height_mm)
        text(txt,
             size = size_mm,
             halign = "center",
             valign = "center",
             font = "Liberation Sans:style=Bold");
}

module center_mark() {
    h = 0.25 + EPS;
    translate([0, 0, h/2]) {
        cube([10, 0.45, h], center = true);
        cube([0.45, 10, h], center = true);
    }
}
