/*
  Fiber box base - SC holder centered - stacked print layout - 180x120 V29
  Current requested outside case size:
    Caselength = 180 mm
    CaseWidth  = 120 mm
    CaseHeight = 50 mm

  Use the long 180 mm side as the vertical/upright direction for layout.
  The future two 1/2 inch cable holes should be placed on the bottom side of the box.

  Print layout:
    ShowBottom = true;
    ShowTop = true;
    ShowCaseAssembled = false;
    Bottom and lid are stacked one above the other on the XY plane.

  Added in this version:
    - Current dual SC holder base integrated into the center of the box bottom.
    - Holder uses corrected 2.85 mm SC flange pocket.
    - SC adapter ends point along the 180 mm case length.
    - V6 fix: added missing rounded_cube_xy helper used by clamp preview.
    - V15: moved clamp parameter section to the top-level Customizer area so it shows as its own dropdown group.
    - V18: removed extra neck/square material from the round clamp plug below the main square block.
    - V19: extended the round plug inward until it touches the square block, removing the gap without re-adding the square neck.
    - V22: copied to a new 180x120x50 file; string options remain Customizer dropdowns, numeric settings remain number fields.
    - V23: copied to a new file and added grouped hinge Customizer dropdowns for spacing and wall height.
    - V24: copied to a new file and constrained hinge wall height to the bottom-box opening so it does not enter the lid.
    - V25: copied to a new file and removed the upper Z restriction so custom hinge height can go above the lid split.
    - V26: copied to a new file and added a hinge-side sealing-surface relief cut above the lid split.
    - V27: copied to a new file and narrowed the relief cut so it does not remove the groove/seal feature.
    - V28: copied to a new file and limited relief Y-depth so it stops before the groove/ridge band.
    - V29: copied to a new file for the new standard Customizer JSON parameter set.
*/

/*******************************************************************************
TITLE:
Stable and waterproof OpenSCAD case by pbtec

DESCRIPTION:

highly scalable case for 3D printing. Try it out!

Optimized for Openscad Customizer. Activate it under view/customizer and play around ;-)

No Support needed to print

- for waterproof cases you can use silicone sealing cord with diameters from 1 to 3mm
- to use also without sealing cord. The groove and ridge gives the housing a high stability and tightness.
- Use of regular nuts or square nuts
- define outer vertical radius of corners
- echo output in console shows inner and outer size and more
- echo output shows the needed length of the screws
- use screws from m2 up to m5
- default are 4 screws at each corner. For large cases add addtional ones in the middle of both x and y sides if needed
- use several predefined wall mount holder, some with multiple mounting holes (up to 3)

Important!
- If you use standard nuts you need to pause the printer a certain level to insert the nuts
- If you need a stable and waterproof case please print with 100% infill
- I'm aware that sometimes, when using too big or too small parameters, there are some rendering issues.
  To prevent such issues change only one parameter at once and check the result.

for waterproofness see https://blog.prusaprinters.org/watertight-3d-printing-part-2_53638/

AUTHOR:
pbtec / pb-tec.ch

use https://paypal.me/pbtec if you want to spend me a coold beer. Thanks in advance :-)


VERSION:
V   KZZ DATE     COMMENT
6.0 pb  31.07.21 First Version to share

*******************************************************************************/

/* [View settings] */
// Export/display selector. Use this dropdown to export each object as its own STL.
DisplayItem               = "All"; // [All, Top, Box, Clamp, SCCover]

// Shows the Bottom of the case
ShowBottom                = true;
// Shows the top of the case
ShowTop                   = true;
// Distance between top and bottom when both are shown in the print layout
DistanceBetweenObjects    = 20;   // print gap between box bottom and lid
// Shows the housing assembled
ShowCaseAssembled         = false;

/* [Common fiber box settings] */
// Adds the current dual SC center-flange holder base to the bottom half
AddCenteredSCHolder        = true;
// Preview-only: show two SC connector mocks in the holder. Turn off before STL export.
ShowSCConnectorMocks       = false;
// Preview-only: show the SC holder lid in place. Turn off before STL export unless you want it fused in.
ShowSCHolderLidPreview     = false;

// Adds two 1/2 inch cable entry holes on the bottom short side of the box
AddBottomCableHoles       = true;
// Adds two screw-post pairs for the current split wire clamps
AddClampScrewPosts        = true;
// Preview-only: shows assembled clamp blocks lined up with the holes/posts. Turn off before STL export.
ShowClampPreview          = false;

// Adds the blue V2 wedge-style box-side hinge to the right inside wall.
AddBlueWedgeBoxHinge      = true;

// Hinge spacing uses dropdown presets. The value is the open space between the two box-side hinge barrels.
BlueHingeSpacingPreset    = "Standard - 15mm gap"; // [Close - 8mm gap, Standard - 15mm gap, Wide - 25mm gap, Custom numeric gap]
// Used only when BlueHingeSpacingPreset is Custom numeric gap. Number text boxes are OK for dimensions.
BlueHingeCustomGap        = 15.0;

// Hinge wall height uses dropdown presets to raise/lower the hinge on the right wall.
// CutFromTop is the lid depth; CaseHeight - CutFromTop is the split line between bottom and lid.
// Positive custom offsets are allowed to move the hinge above that split line.
BlueHingeHeightPreset     = "At split line"; // [Lower - 6mm, Lower - 3mm, At split line, Raise +3mm, Raise +6mm, Custom numeric offset]
// Used only when BlueHingeHeightPreset is Custom numeric offset. Positive raises the hinge; negative lowers it.
BlueHingeCustomZOffset    = 0.0;

// Removes the wall-side hinge/wedge material above the lid split so raised hinges do not intrude into the lid sealing surface.
BlueHingeReliefAboveSplit = true;
// Extra depth into the hinge barrel side for the relief cut. Increase only if the raised hinge still touches the sealing surface.
BlueHingeReliefExtraY     = 0.05;
// Extra X clearance on each side of each hinge barrel relief. Keep small to avoid cutting the groove/seal feature.
BlueHingeReliefXClearance = 0.35;
// Clearance before the yellow groove/ridge band. Larger values keep the relief farther away from the groove.
BlueHingeReliefGrooveClearance = 0.25;


/* [Clamp settings] */
// Diameter of the printed box wall hole. 12.7 mm = 1/2 inch.
Clamp_Box_Hole_D              = 12.7;

// OD of the round plug/shaft that fills the 1/2 inch hole.
Clamp_Round_Shaft_D           = 12.45;

// How far the round shaft sticks out through/past the bottom wall of the box.
Clamp_Round_Shaft_Stickout    = 8.0;

// Wire hole through the center of the clamp. Default requested value.
Clamp_Wire_Hole_D             = 4.3;

// Screw holes through the clamp body. M3 clearance is usually 3.2 mm.
Clamp_Screw_Hole_D            = 3.2;

// Chamfer on the outside/bottom end of the round clamp plug to help it start into the 1/2 inch hole.
// Set to 0 for a straight cylinder.
Clamp_Round_Shaft_Entry_Chamfer = 0.8;

// Square/rectangular clamp block INSIDE the box.
// V17 correction:
// Clamp_Square_Length_Inside now shortens/lengthens the square block AROUND the fixed screw line.
// This means reducing the length pulls the wall-facing edge of the square block away from
// the 1/2 inch hole while the screw holes still line up with the box screw posts.
// Clamp_Square_Back_From_Wall is a minimum extra setback and only matters if it is larger
// than the centered length would produce.
Clamp_Square_Back_From_Wall   = 2.0;
Clamp_Square_Length_Inside    = 10.0;
Clamp_Square_Width            = 18.0;
Clamp_Square_Height           = 10.0;
Clamp_Square_Corner_R         = 1.8;

// Fixed screw-hole locations. These stay in the same place even when the clamp body size changes.
Clamp_Screw_X_Fixed           = 6.35;
Clamp_Screw_Y_Offset_Fixed    = 5.8;

// Box wall cut clearance around the 1/2 inch entry hole.
Clamp_Box_Hole_Print_Clearance = 0.10;


/* [Control cuts (use only one at a time)] */

// To see the nuts inside (best view if not assembled showed)
SeeNutCut                 = false;
// To see the groove, ridge and Screw (best view if assembled showed)
SeeGrooveRidgeScrew       = false;


/* [Case settings] */

// Length of the case
Caselength                = 180;
// Width of the case
CaseWidth                 = 120;
// Height of the case
CaseHeight                = 50;
// Splitt the Case height into bottom and top, check for the needed screws in echo output (console)
CutFromTop                = 10.0;    
// Thickness for the bottom and top wall (vertical walls needs to be calculated)
BottomTopThickness        = 3.0; 
// If this is bigger than the needed cylinder around the screw it will be ignored
CaseRadius                = 12.0;     

/* [Case Screw settings] */

//2=m2/2.5=m2.5/3=m3/4=m4/5=m5   // max m5, larger sizes do not fit
CountersinkScrew          = 3.0;     // [2:m2, 2.5: m2.5, 3: m3, 4: m4, 5: m5]

// Adds additional Screws on X axis (for large cases) --> Try it out
XAdditionalScrew          = false;  // can be true or false / Adds additional Screws on X axis (for large cases) --> Try it out
// Adds additional Screws on Y axis (for large cases) --> Try it out
YAdditionalScrew          = false;  // can be true or false / Adds additional Screws on Y axis (for large cases) --> Try it out

/* [Groove settings] */

// If using a SealingCord use the SealingCord diameter, otherwise x-times of your 3D Printer Nozzle (0.8/1.2/...) --> Ridge gets perfect for printing
GrooveWidth               = 1.6;   // [0.8:0.1:3]

// Not less than 1mm (for stability) and not more than 3mm --> Best 2mm
GrooveDepth               = 2.0;   // [1.0:0.1:3]

// Space between Groove and Ridge for a perfect fit, usualy 0.2 or 0.3 for FDM depending on your printer quality
Space                     = 0.3;   // [0.0:0.1:0.4]

// Addtional vertical room for the pressed sealing Cord. For sealing cord 1.5mm -->0.5 // for 2mm -->0.8 // for 2.5 -->1.0 // If no sealing cord then set this parameter to 0.
AddGrooveDepthForSealing  = 0.8;   // [0.0:0.1:3]   

// Range Inside groove/ridge. Usualy 2 times or more the printer nozzle. For best stability at least 0.8
InnerBorder               = 1.4;   // [0.8:0.1:4]


// Range Outside groove/ridge . Usualy 2 times or more the printer nozzle. For best stability at least 0.8
OuterBorder               = 1.4;   // [0.8:0.1:4]

/* [Nut general settings] */

// Size of material (plastic) above nut/square nut (3mm or more). The more, the more stable but need longer screw.
NutSink                   = 4.0; 

/* [Standard nut settings] */

// Nut Settings / As there are (or I have) many different nuts dimensions, the size must be specified / Do not add separation space, only the real measurement // m2=1.5 // m2.5=1.9 // m3=2.4 // m4=3.2 // n5=3.8
NutHigh                   = 2.4;   

// Distance between the paralell sides / Do not add separation space, only the real measurement // m2=3.8 // m2.5=4.9 // m3=5.4 // m4=6.9 // m5=7.9
NutDia                    = 5.4;   

/* [Square Nut settings] */

// Select if you want to use square nuts instead of normal nuts
UseSquareNutInsteadOfNut  = false; 

// Select the high of the square nut / Do not add separation space, only the real measurement
SquareNutHigh             = 1.9;

// Select the size of the square nut / Do not add separation space, only the real measurement
SquareNutSize             = 5.4;

// Square nut insert from which side
EdgeSquareNutInsertFrom_X = true;       

/* [Wall mount holder settings] */
 
// Select if you need a mount holder
EnableMountHolder         = false; 

// Where to put the wall mount holders.
// LeftRight = original left/right sides when cable holes are at the bottom.
// TopBottom = top and bottom short ends of the box.
// All = mounts on all four sides.
MountHolderPlacement      = "TopBottom"; // [LeftRight, TopBottom, All]

// Chose your desired wall mount style
MountHolderStyle          = 4;      // [1:Style 1, 2: Style 2, 3: Style 3, 4 : Style 4, 5 : Style 5]

// Some styles (1-3) allow more than one hole
CountOfMountHolderHoles   = 1;     // [1:One hole centered, 2: Two holes, 3: Three holes]
MountHolderHoleDiameter   = 5;   // [1:0.1:10]
MountHolderThickness      = 4.0;   // [2:0.1:10]

/* [PCB/Device holder settings] */
// Activate customizable PCB/Device holder
ShowDeviceHolder         = false;
// Hole in the cylinder for the screw // 2.9 Screw = 2mm hole
ScrewHoleDiameter        = 2.6;  
// The diamter of the screw cylinder
ScrewCylinderDiameter    = 7;
// The height of the screw cylinders (also the deepness for the screw hole)
ScrewCylinderHeight      = 8.0;
// Distance between the holders in X direction
DeviceHolder_X_Distance  = 60;
// Distance between the holders in Y direction
DeviceHolder_y_Distance  = 80;
// Move all holders in X direction
Offset_X                 = 0;
// Move all holders in Y direction
Offset_Y                 = -20;

/* [Wall Holes settings (for cable gland cut)] */
// Activate customizable holes for cable gland or similar
ShowSideWallHoles        = false;
// Holes on X or Y side of the housing
SideWallHolesOn_X        = false;
// Count of holes, if there is an additional screw on X or Y side the hole in the middle is not showed
CountOfSideWallHoles     = 1;     //[1:1:3]
// Diameter of the holes
SideWallHoleDiameter     = 16.5;  //[1:0.1:80]
// Add or decrease height position
SiedWallHoleOffset_Z     = 0;     



/* [Render quality settings] */
// Set to at least to 150 before render and save as .stl file, otherwise you can go down to 40 for quick 3D view
$fn                       = 60;   // [20:1:300] 

// =========================  C A L C U L A T E D   S E T T I N G S (do not change!!!) ===================================

// Calculated Screw settings (do not change!!!)
ScrewHoleDia              = CountersinkScrew+1;
ScrewHeadDia              = CountersinkScrew*2;
ScrewCountersink          = (CountersinkScrew+8)/14-0.5;

// Calculated settings for Ridge (do not change!!!)
RidgeHeight               = GrooveDepth-Space;
RidgeWidth                = GrooveWidth-Space;

// Calculated settings for case (do not change!!!)
SideWallThickness             = InnerBorder+GrooveWidth+OuterBorder;
CaseRoundingRadius        = ScrewHoleDia/2+InnerBorder+GrooveWidth+OuterBorder;
ScrewCornerPos            = [Caselength/2-CaseRoundingRadius,CaseWidth/2-CaseRoundingRadius,0];
ScrewAddXPos              = [0,CaseWidth/2-CaseRoundingRadius,0];
ScrewAddYPos              = [Caselength/2-CaseRoundingRadius,0,0];

// Calculated settings for wall mount holder
MountHolderLenght         = MountHolderHoleDiameter*3;

// if both objects showed
// Stack the two parts along Y instead of side-by-side along X.
// This keeps the 180 mm long side pointing the same direction for both pieces.
Y_ObjectPosition = ((ShowBottom)&&(ShowTop)&&(!ShowCaseAssembled)) ? CaseWidth/2+DistanceBetweenObjects/2:0;

// If the case is assembled showed
Y_TopRotation = ShowCaseAssembled ? 180:0;
Z_TopHigh = ShowCaseAssembled ? CaseHeight:0;


//===============================================================================
//                         F I B E R   B O X   A D D - O N S
//===============================================================================

// Current dual SC holder parameters, copied from
// dual_sc_center_10mm_holder_print_ready_flange_2p85.scad
// This holder base is fused to the inside bottom of the box.

sc_l = 27.5;              // full SC adapter length, X
sc_w = 12.8;              // main body width, Y
sc_h = 9.3;               // main body height, Z
sc_flange_total_w = 14.8; // total width across side flanges, Y
sc_flange_t = 2.85;       // corrected flange thickness along X
sc_side_flange_each = (sc_flange_total_w - sc_w) / 2;

sc_holder_l = 10.0;       // only center 10 mm covered
sc_bottom_thick = 2.4;
sc_lid_t = 2.2;

sc_body_clearance_y = 0.25;
sc_body_clearance_z = 0.25;
sc_flange_clearance_y = 0.30;
sc_flange_clearance_x = 0.35;

sc_slot_w = sc_w + sc_body_clearance_y;
sc_slot_h = sc_h + sc_body_clearance_z;
sc_flange_pocket_w = sc_flange_total_w + sc_flange_clearance_y;
sc_flange_pocket_l = sc_flange_t + sc_flange_clearance_x;

sc_side_wall = 2.2;
sc_center_wall = 3.0;
sc_post_zone_w = 8.5;
sc_post_d = 6.5;

sc_base_l = sc_holder_l;
sc_base_h = sc_bottom_thick + sc_slot_h;
sc_base_w = sc_post_zone_w * 2 + sc_side_wall * 2 + sc_flange_pocket_w * 2 + sc_center_wall;

sc_usable_y0 = sc_post_zone_w + sc_side_wall;
sc_slot1_y = sc_usable_y0 + sc_flange_pocket_w / 2;
sc_slot2_y = sc_usable_y0 + sc_flange_pocket_w + sc_center_wall + sc_flange_pocket_w / 2;
sc_slot_y_centers = [sc_slot1_y, sc_slot2_y];
sc_flange_x0 = sc_base_l / 2 - sc_flange_pocket_l / 2;

sc_screw_d = 3.2;
sc_pilot_d = 2.65;
sc_head_d = 6.2;
sc_head_depth = 1.0;
sc_screw_x = sc_base_l / 2;
sc_screw1_y = sc_post_zone_w / 2;
sc_screw2_y = sc_base_w - sc_post_zone_w / 2;
sc_lid_press_rib_drop = 0.12;
sc_lid_rib_w = sc_w - 1.0;

module sc_rounded_rect_2d(size=[10,10], r=1) {
    offset(r=r)
        offset(delta=-r)
            square(size, center=false);
}

module sc_rounded_cube(size=[10,10,10], r=1) {
    linear_extrude(height=size[2])
        sc_rounded_rect_2d([size[0], size[1]], r);
}

module sc_screw_locations() {
    for (y = [sc_screw1_y, sc_screw2_y])
        translate([sc_screw_x, y, 0]) children();
}

module sc_holder_base_integrated() {
    difference() {
        union() {
            sc_rounded_cube([sc_base_l, sc_base_w, sc_base_h], r=0.8);
            sc_screw_locations()
                cylinder(d=sc_post_d, h=sc_base_h);
        }

        for (yc = sc_slot_y_centers) {
            // Narrow body channel, open through both X ends and top.
            translate([-0.10, yc - sc_slot_w/2, sc_bottom_thick])
                cube([sc_base_l + 0.20, sc_slot_w, sc_slot_h + 0.30]);

            // Center flange pocket for side-only SC flange.
            translate([sc_flange_x0, yc - sc_flange_pocket_w/2, sc_bottom_thick - 0.02])
                cube([sc_flange_pocket_l, sc_flange_pocket_w, sc_slot_h + 0.35]);
        }

        // M3 self-tapping pilot holes in the holder posts.
        sc_screw_locations()
            translate([0,0,sc_bottom_thick])
                cylinder(d=sc_pilot_d, h=sc_base_h + 0.50);
    }
}

module sc_holder_lid_preview() {
    difference() {
        union() {
            sc_rounded_cube([sc_base_l, sc_base_w, sc_lid_t], r=0.8);
            for (yc = sc_slot_y_centers) {
                translate([0.60, yc - sc_lid_rib_w/2, -sc_lid_press_rib_drop])
                    cube([sc_base_l - 1.20, sc_lid_rib_w, sc_lid_press_rib_drop]);
            }
        }
        sc_screw_locations()
            translate([0,0,-0.50])
                cylinder(d=sc_screw_d, h=sc_lid_t + 1.20);
        sc_screw_locations()
            translate([0,0,sc_lid_t - sc_head_depth])
                cylinder(d=sc_head_d, h=sc_head_depth + 0.20);
    }
}

module sc_connector_mock_2p85(show_front_detail=true) {
    difference() {
        union() {
            translate([0, -sc_w/2, -sc_h/2])
                cube([sc_l, sc_w, sc_h]);
            translate([sc_l/2 - sc_flange_t/2, -sc_flange_total_w/2, -sc_h/2])
                cube([sc_flange_t, sc_side_flange_each, sc_h]);
            translate([sc_l/2 - sc_flange_t/2, sc_w/2, -sc_h/2])
                cube([sc_flange_t, sc_side_flange_each, sc_h]);
        }

        if (show_front_detail) {
            front_inner_square = 6.4;
            front_opening_d = 3.2;
            recess_depth = 0.45;
            translate([-0.02, -front_inner_square/2, -front_inner_square/2])
                cube([recess_depth + 0.04, front_inner_square, front_inner_square]);
            translate([-0.04, 0, 0])
                rotate([0,90,0])
                    cylinder(d=front_opening_d, h=recess_depth + 0.08);
        }
    }
}

// Places the SC holder in the center of the inside bottom.
// Origin is adjusted so the holder is centered in the box.
// X = 180 mm long box direction. The SC connector ends point along X.
module centered_sc_holder_in_box() {
    translate([-sc_base_l/2, -sc_base_w/2, BottomTopThickness]) {
        sc_holder_base_integrated();

        if (ShowSCConnectorMocks) {
            for (yc = sc_slot_y_centers) {
                color("gray", 0.55)
                    translate([sc_base_l/2 - sc_l/2, yc, sc_bottom_thick + sc_h/2])
                        sc_connector_mock_2p85(show_front_detail=true);
            }
        }

        if (ShowSCHolderLidPreview) {
            translate([0,0,sc_base_h])
                sc_holder_lid_preview();
        }
    }
}


//===============================================================================
//                  B O T T O M   C A B L E   H O L E S   +   C L A M P   P O S T S
//===============================================================================

// Current split clamp reference:
// split_1_2in_wire_clamp_like_reference_v4_short_block.scad
// Box orientation used here:
// X = 180 mm long upright direction.
// The bottom cable-entry side is the negative-X short wall.
// Cable/clamp direction is along X, with clamp block inside the box.

// Internal variable aliases used by the clamp geometry.
clamp_box_hole_d      = Clamp_Box_Hole_D;
clamp_plug_d          = Clamp_Round_Shaft_D;
clamp_plug_len        = Clamp_Round_Shaft_Stickout;
clamp_cable_hole_d    = Clamp_Wire_Hole_D;
clamp_screw_hole_d    = Clamp_Screw_Hole_D;
clamp_entry_chamfer   = Clamp_Round_Shaft_Entry_Chamfer;
clamp_block_l         = Clamp_Square_Length_Inside;
clamp_screw_y_offset  = Clamp_Screw_Y_Offset_Fixed;
clamp_screw_x         = Clamp_Screw_X_Fixed;

// V17: square block is centered on the fixed screw X line so the screws keep lining up.
// Reducing Clamp_Square_Length_Inside now trims the wall-facing edge away from the 1/2 inch hole.
clamp_block_start_x   = max(Clamp_Square_Back_From_Wall, clamp_screw_x - clamp_block_l/2);
clamp_block_end_x     = clamp_screw_x + clamp_block_l/2;
clamp_block_center_x  = (clamp_block_start_x + clamp_block_end_x)/2;
clamp_block_actual_l  = clamp_block_end_x - clamp_block_start_x;

// V19: the block may be set back from the wall, but the round plug must still touch it.
// This extends only the round cylinder inward to the square block start.
clamp_round_total_l   = clamp_plug_len + clamp_block_start_x;
clamp_round_center_x  = (clamp_block_start_x - clamp_plug_len)/2;

clamp_block_w         = Clamp_Square_Width;
clamp_block_h         = Clamp_Square_Height;
clamp_corner_r        = Clamp_Square_Corner_R;

// Hole/post placement.
// Two cable entries are centered on the lower short wall, separated along the 120 mm width.
clamp_y_positions     = [-16, 16];
clamp_z_center        = 14.0;       // center of the 1/2 inch holes above the print-bed bottom

// Local-to-box placement. Local clamp x=0 is where the round plug meets the block.
clamp_inner_wall_x    = -Caselength/2 + SideWallThickness;
clamp_origin_x        = clamp_inner_wall_x;   // plug goes outward, block goes inward

// Screw posts under each clamp block.
clamp_post_d          = 6.5;
clamp_post_pilot_d    = 2.65;       // M3 self-tapping starting pilot
clamp_post_floor_z    = BottomTopThickness;
clamp_post_top_z      = clamp_z_center - clamp_block_h/2;
clamp_post_h          = max(0.1, clamp_post_top_z - clamp_post_floor_z);

// Clearance through the printed box wall. Adjust Clamp_Box_Hole_Print_Clearance if the real clamp plug is too tight/loose.
box_hole_print_clearance = Clamp_Box_Hole_Print_Clearance;
box_hole_cut_d       = clamp_box_hole_d + box_hole_print_clearance;

module bottom_cable_hole_cuts() {
    if (AddBottomCableHoles) {
        for (cy = clamp_y_positions) {
            translate([-Caselength/2 - 0.10, cy, clamp_z_center])
                rotate([0,90,0])
                    cylinder(d=box_hole_cut_d, h=SideWallThickness + 0.80, center=false);
        }
    }
}

module clamp_screw_post_locations() {
    for (cy = clamp_y_positions) {
        for (sy = [-1, 1]) {
            translate([clamp_origin_x + clamp_screw_x,
                       cy + sy*clamp_screw_y_offset,
                       clamp_post_floor_z])
                children();
        }
    }
}

module clamp_screw_posts() {
    if (AddClampScrewPosts) {
        clamp_screw_post_locations()
            cylinder(d=clamp_post_d, h=clamp_post_h, center=false);
    }
}

module clamp_screw_post_pilot_cuts() {
    if (AddClampScrewPosts) {
        clamp_screw_post_locations()
            translate([0,0,-0.05])
                cylinder(d=clamp_post_pilot_d, h=clamp_post_h + 0.40, center=false);
    }
}


// Rounded rectangular block helper used by the clamp preview.
// This was missing in V5, which caused OpenSCAD errors when ShowClampPreview=true.
module rounded_cube_xy(size=[10,10,10], r=1, center=false) {
    x = size[0];
    y = size[1];
    z = size[2];

    translate(center ? [0,0,0] : [x/2,y/2,z/2])
        hull() {
            for (sx=[-1,1], sy=[-1,1])
                translate([sx*(x/2-r), sy*(y/2-r), 0])
                    cylinder(r=r, h=z, center=true);
        }
}

// Round plug helper. Axis is X. The chamfer is only on the outside/bottom/leading end
// of the plug, so the inside end still meets the square block cleanly.
module clamp_round_plug_x(d, h, chamfer=0, center=true) {
    ch = min(max(chamfer, 0), h/2 - 0.01);
    start_x = center ? -h/2 : 0;

    if (ch <= 0) {
        rotate([0,90,0]) cylinder(d=d, h=h, center=center);
    } else {
        translate([start_x, 0, 0]) {
            union() {
                // Tapered lead-in chamfer at the outside/bottom end.
                hull() {
                    translate([0,0,0])
                        rotate([0,90,0])
                            cylinder(d=max(0.2, d - 2*ch), h=0.02, center=false);
                    translate([ch,0,0])
                        rotate([0,90,0])
                            cylinder(d=d, h=0.02, center=false);
                }

                // Full-size round plug from the chamfer to the square block.
                translate([ch,0,0])
                    rotate([0,90,0])
                        cylinder(d=d, h=h - ch, center=false);
            }
        }
    }
}

module clamp_preview_solid() {
    // Assembled clamp preview only. Do not export with ShowClampPreview=true.
    difference() {
        union() {
            // rectangular block inside box. V17: length is centered around the fixed screw line
            // so shortening it improves clearance near the 1/2 inch hole without moving screw alignment.
            translate([clamp_block_center_x, 0, 0])
                rounded_cube_xy([clamp_block_actual_l, clamp_block_w, clamp_block_h], r=clamp_corner_r, center=true);

            // round plug filling 1/2 inch wall hole. V19: extended inward to touch square block.
            translate([clamp_round_center_x, 0, 0])
                clamp_round_plug_x(d=clamp_plug_d, h=clamp_round_total_l, chamfer=clamp_entry_chamfer, center=true);

            // V18/V19: no extra square neck; the round plug itself now contacts the square block.
        }

        // wire center channel
        translate([(clamp_block_end_x - clamp_plug_len)/2, 0, 0])
            rotate([0,90,0])
                cylinder(d=clamp_cable_hole_d, h=clamp_block_end_x + clamp_plug_len + 4, center=true);

        // two M3 screw holes in clamp body
        for (sy = [-1, 1])
            translate([clamp_screw_x, sy*clamp_screw_y_offset, 0])
                cylinder(d=clamp_screw_hole_d, h=clamp_block_h + 4, center=true);
    }
}

module clamp_previews_in_box() {
    if (ShowClampPreview) {
        for (cy = clamp_y_positions) {
            color("orange", 0.45)
                translate([clamp_origin_x, cy, clamp_z_center])
                    clamp_preview_solid();
        }
    }
}



//===============================================================================
//             B L U E   V 2   W E D G E   B O X - S I D E   H I N G E
//===============================================================================
// Source reference: imported_tray_with_v2_wedge_box_hinge_v6_bracket_behind.scad
// Placement used here:
//   - wire holes are on the bottom side of the box, negative X
//   - hinge is on the right inside wall, positive Y
//   - hinge pin/hole axis runs along X, the 180 mm long direction
//   - barrel/wide hole side faces inward into the box
//   - tapered wedge side goes back into/against the right wall

blue_hinge_enable_color = true;

blue_pin_hole_d          = 2.20;
blue_knuckle_od          = 6.50;
blue_barrel_len          = 10.0;
blue_side_gap            = 0.70;
blue_center_access_gap   = BlueHingeSpacingPreset == "Close - 8mm gap" ? 8.0 :
                           BlueHingeSpacingPreset == "Wide - 25mm gap" ? 25.0 :
                           BlueHingeSpacingPreset == "Custom numeric gap" ? BlueHingeCustomGap :
                           15.0;
blue_hinge_z_offset      = BlueHingeHeightPreset == "Lower - 6mm" ? -6.0 :
                           BlueHingeHeightPreset == "Lower - 3mm" ? -3.0 :
                           BlueHingeHeightPreset == "Raise +3mm" ? 3.0 :
                           BlueHingeHeightPreset == "Raise +6mm" ? 6.0 :
                           BlueHingeHeightPreset == "Custom numeric offset" ? BlueHingeCustomZOffset :
                           0.0;
blue_wedge_anchor_y_t    = 1.5;
blue_wedge_wall_overlap  = 0.55;
blue_wedge_anchor_z_h    = 18.0;

// Right inside wall face of the box.
blue_right_inner_wall_y  = CaseWidth/2 - SideWallThickness;

// The barrel center sits slightly inside the box so the round hole/wide end is visible and usable.
blue_axis_y              = blue_right_inner_wall_y - blue_knuckle_od/2 - 0.60;

// CutFromTop is the lid depth; the bottom box reaches CaseHeight - CutFromTop.
// V25 intentionally allows positive offsets above this split line for hinge fit testing.
blue_lid_split_z         = CaseHeight - CutFromTop;
blue_axis_z_at_split     = blue_lid_split_z - blue_knuckle_od/2;
blue_axis_z_requested    = blue_axis_z_at_split + blue_hinge_z_offset;
blue_axis_z_min          = BottomTopThickness + blue_knuckle_od/2;
blue_axis_z              = max(blue_axis_z_requested, blue_axis_z_min);
blue_hinge_top_z         = blue_axis_z + blue_knuckle_od/2;
blue_hinge_above_split   = blue_hinge_top_z - blue_lid_split_z;

// If this is too close/far from the right wall, tune this value.
blue_anchor_y            = blue_right_inner_wall_y - blue_wedge_wall_overlap/2;

blue_hinge_span = 4*blue_barrel_len + 2*blue_side_gap + blue_center_access_gap;
blue_box_side_barrel_center_spacing = blue_barrel_len + blue_center_access_gap;

echo(str("Blue hinge spacing preset: ", BlueHingeSpacingPreset,
         "; gap between box-side barrels = ", blue_center_access_gap, " mm",
         "; box-side barrel center spacing = ", blue_box_side_barrel_center_spacing, " mm",
         "; height preset: ", BlueHingeHeightPreset,
         "; requested hinge wall Z offset = ", blue_hinge_z_offset, " mm",
         "; requested hinge axis Z = ", blue_axis_z_requested, " mm",
         "; final hinge axis Z = ", blue_axis_z, " mm",
         "; lid split Z = ", blue_lid_split_z, " mm",
         "; hinge top above split = ", blue_hinge_above_split, " mm"));

function blue_barrel_x(i) =
    let(start = -blue_hinge_span/2)
    i == 0 ? start + blue_barrel_len/2 :
    i == 1 ? start + blue_barrel_len + blue_side_gap + blue_barrel_len/2 :
    i == 2 ? start + 2*blue_barrel_len + blue_side_gap + blue_center_access_gap + blue_barrel_len/2 :
             start + 3*blue_barrel_len + 2*blue_side_gap + blue_center_access_gap + blue_barrel_len/2;

// The blue box-side hinge owns the inner two barrels, matching the uploaded blue wedge hinge.
function blue_wall_owns_barrel(i) = (i == 1 || i == 2);

module blue_cyl_x(len, d, center=true) {
    rotate([0,90,0]) cylinder(h=len, d=d, center=center);
}

module blue_v2_wedge_barrel_segment(i) {
    x = blue_barrel_x(i);

    module blue_solid_shape() {
        hull() {
            // Narrow/tapered anchor side sits back against the right inside wall.
            // V9: flipped vertically so the tapered/pointed side runs the opposite direction.
            translate([x, blue_anchor_y, blue_axis_z - blue_wedge_anchor_z_h/2 + blue_knuckle_od/2])
                cube([blue_barrel_len,
                      blue_wedge_anchor_y_t + blue_wedge_wall_overlap,
                      blue_wedge_anchor_z_h], center=true);

            // Wide round hinge end with the hole, facing inward into the box.
            translate([x, blue_axis_y, blue_axis_z])
                blue_cyl_x(blue_barrel_len, blue_knuckle_od, center=true);
        }
    }

    difference() {
        blue_solid_shape();
        translate([x, blue_axis_y, blue_axis_z])
            blue_cyl_x(blue_barrel_len + 3.0, blue_pin_hole_d, center=true);
    }
}

module blue_box_side_v2_wedge_hinge_in_box() {
    if (AddBlueWedgeBoxHinge) {
        if (blue_hinge_enable_color)
            color("royalblue")
                union() {
                    for (i=[0:3])
                        if (blue_wall_owns_barrel(i))
                            blue_v2_wedge_barrel_segment(i);
                }
        else
            union() {
                for (i=[0:3])
                    if (blue_wall_owns_barrel(i))
                        blue_v2_wedge_barrel_segment(i);
            }
    }
}

module blue_hinge_sealing_surface_relief_cut() {
    if (AddBlueWedgeBoxHinge && BlueHingeReliefAboveSplit) {
        // Cut only the wall-side/back side of the hinge above the lid split.
        // The barrel can still be raised above the split, but the rectangular/wedge
        // anchor area that would occupy the lid sealing surface is removed.
        cut_start_y = blue_axis_y + blue_knuckle_od/2 - BlueHingeReliefExtraY;
        groove_inner_edge_y = CaseWidth/2 - OuterBorder - GrooveWidth;
        cut_end_y = groove_inner_edge_y - BlueHingeReliefGrooveClearance;
        cut_center_y = (cut_start_y + cut_end_y) / 2;
        cut_depth_y = max(0.1, cut_end_y - cut_start_y);
        cut_start_z = blue_lid_split_z;
        cut_end_z = CaseHeight + max(0, blue_hinge_z_offset) + blue_knuckle_od + 4;
        cut_center_z = (cut_start_z + cut_end_z) / 2;
        cut_height_z = max(0.1, cut_end_z - cut_start_z);

        for (i=[0:3])
            if (blue_wall_owns_barrel(i))
                translate([blue_barrel_x(i), cut_center_y, cut_center_z])
                    cube([blue_barrel_len + 2*BlueHingeReliefXClearance,
                          cut_depth_y,
                          cut_height_z], center=true);
    }
}

ShowSizes(); // Show the calculated sizes

//===============================================================================
//                                    M A I N
//===============================================================================

// Output selector notes:
//   DisplayItem = "All"     shows the stacked box/lid layout like V11.
//   DisplayItem = "Box"     exports only the bottom box with internal features.
//   DisplayItem = "Top"     exports only the top/lid.
//   DisplayItem = "Clamp"   exports the current two-piece 1/2 inch cable clamp.
//   DisplayItem = "SCCover" exports only the SC holder cover/lid, flipped flat for printing.

module printable_box_bottom() {
    difference(){
        union(){
            BodyBottom();
            if (AddCenteredSCHolder) centered_sc_holder_in_box();
            clamp_screw_posts();
            clamp_previews_in_box();
            blue_box_side_v2_wedge_hinge_in_box();
            // **** Add your bottom case additions here ****
        }
        bottom_cable_hole_cuts();
        clamp_screw_post_pilot_cuts();
        blue_hinge_sealing_surface_relief_cut();
        // **** Add your bottom case cuts here ****
    }
}

module printable_top_lid() {
    difference(){
        union(){
            BodyTop();
            // **** Add your top case additions here ****
        }
        // **** Add your top case cuts here ****
    }
}

module printable_sc_cover_on_bed() {
    // SC cover has small underside ribs below local Z=0.
    // Flip it so the large flat outside face sits directly on the print bed.
    translate([0, 0, sc_lid_t])
        rotate([180, 0, 0])
            sc_holder_lid_preview();
}

// Current two-piece split 1/2 inch clamp, print-ready.
// This matches split_1_2in_wire_clamp_like_reference_v4_short_block.scad.
clamp_pin_d         = 2.0;
clamp_pin_h         = 1.2;
clamp_pin_x         = clamp_block_end_x - 2.4;
clamp_pin_y_offset  = 3.2;
clamp_pin_clearance = 0.18;
clamp_screw_head_d  = 6.2;
clamp_screw_head_depth = 1.8;
clamp_layout_gap    = 10;

module clamp_screw_cut(include_head=false) {
    for (sy=[-1, 1])
        translate([clamp_screw_x, sy*clamp_screw_y_offset, 0])
            cylinder(d=clamp_screw_hole_d, h=clamp_block_h+4, center=true);

    if (include_head) {
        for (sy=[-1, 1])
            translate([clamp_screw_x, sy*clamp_screw_y_offset, clamp_block_h/2 - clamp_screw_head_depth/2 + 0.01])
                cylinder(d=clamp_screw_head_d, h=clamp_screw_head_depth+0.04, center=true);
    }
}

module full_split_clamp_solid() {
    union() {
        translate([clamp_block_center_x, 0, 0])
            rounded_cube_xy([clamp_block_actual_l, clamp_block_w, clamp_block_h], r=clamp_corner_r, center=true);

        translate([clamp_round_center_x, 0, 0])
            clamp_round_plug_x(d=clamp_plug_d, h=clamp_round_total_l, chamfer=clamp_entry_chamfer, center=true);

        // V18/V19: no extra square neck; the round plug itself now contacts the square block.
    }
}

module full_split_clamp_cut() {
    difference() {
        full_split_clamp_solid();

        translate([(clamp_block_end_x - clamp_plug_len)/2, 0, 0])
            rotate([0,90,0])
                cylinder(d=clamp_cable_hole_d, h=clamp_block_end_x + clamp_plug_len + 4, center=true);

        clamp_screw_cut(include_head=true);
    }
}

module clamp_lower_half_raw() {
    difference() {
        intersection() {
            full_split_clamp_cut();
            translate([(clamp_block_end_x - clamp_plug_len)/2, 0, -clamp_block_h/4])
                cube([clamp_block_end_x + clamp_plug_len + 4, clamp_block_w + 4, clamp_block_h/2 + 0.02], center=true);
        }

        for (sy=[-1, 1])
            translate([clamp_pin_x, sy*clamp_pin_y_offset, 0.01])
                cylinder(d=clamp_pin_d + clamp_pin_clearance, h=clamp_pin_h + 0.08, center=false);
    }
}

module clamp_upper_half_raw() {
    union() {
        intersection() {
            full_split_clamp_cut();
            translate([(clamp_block_end_x - clamp_plug_len)/2, 0, clamp_block_h/4])
                cube([clamp_block_end_x + clamp_plug_len + 4, clamp_block_w + 4, clamp_block_h/2 + 0.02], center=true);
        }

        for (sy=[-1, 1])
            translate([clamp_pin_x, sy*clamp_pin_y_offset, -0.01])
                cylinder(d=clamp_pin_d, h=clamp_pin_h, center=false);
    }
}

module clamp_lower_half_print() {
    translate([0,0,clamp_block_h/2])
        clamp_lower_half_raw();
}

module clamp_upper_half_print() {
    translate([0,0,clamp_block_h/2])
        mirror([0,0,1])
            clamp_upper_half_raw();
}

module printable_clamp_on_bed() {
    translate([0, -(clamp_block_w/2 + clamp_layout_gap/2), 0])
        clamp_lower_half_print();
    translate([0,  (clamp_block_w/2 + clamp_layout_gap/2), 0])
        clamp_upper_half_print();
}

//===============================================================================
//                                    M A I N
//===============================================================================

if (DisplayItem == "Box") {
    translate([0,0,0]) printable_box_bottom();
}
else if (DisplayItem == "Top") {
    translate([0,0,Z_TopHigh]) rotate([0,Y_TopRotation,0]) printable_top_lid();
}
else if (DisplayItem == "Clamp") {
    printable_clamp_on_bed();
}
else if (DisplayItem == "SCCover") {
    printable_sc_cover_on_bed();
}
else {
    // Original V11 stacked layout.
    translate([0,Y_ObjectPosition,0]) printable_box_bottom();
    translate([0,-Y_ObjectPosition,Z_TopHigh]) rotate([0,Y_TopRotation,0]) printable_top_lid();
}

//===============================================================================
//                                  M O D U L E S
//===============================================================================

module BodyBottom () {
    if(ShowBottom)
    {
        difference(){
            union()
            {
                rotate([  0,  0,  0]) BodyQuarterBottom(Caselength,CaseWidth,CaseHeight-CutFromTop,CaseRoundingRadius,SideWallThickness);
                rotate([  0,  0,180]) BodyQuarterBottom(Caselength,CaseWidth,CaseHeight-CutFromTop,CaseRoundingRadius,SideWallThickness);
                mirror([  0,  1,  0]) BodyQuarterBottom(Caselength,CaseWidth,CaseHeight-CutFromTop,CaseRoundingRadius,SideWallThickness);
                mirror([  1,  0  ,0]) BodyQuarterBottom(Caselength,CaseWidth,CaseHeight-CutFromTop,CaseRoundingRadius,SideWallThickness);      
            
                if (EnableMountHolder)
                {
                    color("SteelBlue")
                        MountHolderPlacementSet(MountHolderThickness, MountHolderHoleDiameter);
                }
                if (ShowDeviceHolder)
               {
                   
                    translate([DeviceHolder_X_Distance/2+Offset_X,DeviceHolder_y_Distance/2+Offset_Y,-0.01]) DeviceHolder();
                    translate([-DeviceHolder_X_Distance/2+Offset_X,-DeviceHolder_y_Distance/2+Offset_Y,-0.01]) DeviceHolder();
                    translate([DeviceHolder_X_Distance/2+Offset_X,-DeviceHolder_y_Distance/2+Offset_Y,-0.01]) DeviceHolder();
                    translate([-DeviceHolder_X_Distance/2+Offset_X,DeviceHolder_y_Distance/2+Offset_Y,-0.01]) DeviceHolder();

                }
            }
            if (SeeNutCut)           { color("red") translate([0,0,CaseHeight/2+CaseHeight-CutFromTop-NutSink]) cube([Caselength+0.1,CaseWidth+0.1,CaseHeight],center=true);}
            if (SeeGrooveRidgeScrew) { color("red") translate([CaseRoundingRadius+50,0,(CaseHeight+0.1)/2-0.05])   cube([Caselength+0.1,CaseWidth*2+0.1,CaseHeight+0.1],center=true);}
            if (ShowSideWallHoles)
            {
                color("Yellow")
                if(SideWallHolesOn_X)
                {
                    
                    if ((CountOfSideWallHoles==1)||(CountOfSideWallHoles==3)&&(!XAdditionalScrew))
                    {
                        if ((CountOfSideWallHoles==1)&&(!XAdditionalScrew))
                        {
                            translate([0,CaseWidth/2-SideWallThickness/2,SiedWallHoleOffset_Z+ BottomTopThickness+(CaseHeight-CutFromTop-BottomTopThickness)/2 ]) rotate([90,0,0]) cylinder(h=SideWallThickness+0.04,d=SideWallHoleDiameter,center = true);
                        }
                        if ((CountOfSideWallHoles==3)&&(!XAdditionalScrew))
                        {
                            translate([0,CaseWidth/2-SideWallThickness/2,SiedWallHoleOffset_Z+ BottomTopThickness+(CaseHeight-CutFromTop-BottomTopThickness)/2 ]) rotate([90,0,0]) cylinder(h=SideWallThickness+0.04,d=SideWallHoleDiameter,center = true);
                        }

                    }
                    
                    
                    if ((CountOfSideWallHoles==1)&&(XAdditionalScrew))
                    {
                        translate([Caselength/4-CaseRoundingRadius/2,CaseWidth/2-SideWallThickness/2,SiedWallHoleOffset_Z+ BottomTopThickness+(CaseHeight-CutFromTop-BottomTopThickness)/2 ]) rotate([90,0,0]) cylinder(h=SideWallThickness+0.04,d=SideWallHoleDiameter,center = true);
                    }



                    if ((CountOfSideWallHoles==2)||(CountOfSideWallHoles==3))
                    {
                        translate([Caselength/4-CaseRoundingRadius/2,CaseWidth/2-SideWallThickness/2,SiedWallHoleOffset_Z+ BottomTopThickness+(CaseHeight-CutFromTop-BottomTopThickness)/2 ]) rotate([90,0,0]) cylinder(h=SideWallThickness+0.04,d=SideWallHoleDiameter,center = true);
                        translate([-Caselength/4+CaseRoundingRadius/2,CaseWidth/2-SideWallThickness/2,SiedWallHoleOffset_Z+ BottomTopThickness+(CaseHeight-CutFromTop-BottomTopThickness)/2 ]) rotate([90,0,0]) cylinder(h=SideWallThickness+0.04,d=SideWallHoleDiameter,center = true);
                    }

                }
                else
                {
                    if ((CountOfSideWallHoles==1)||(CountOfSideWallHoles==3)&&(!YAdditionalScrew))
                    {
                        if ((CountOfSideWallHoles==1)&&(!YAdditionalScrew))
                        {
                            translate([Caselength/2-SideWallThickness/2,0,SiedWallHoleOffset_Z+ BottomTopThickness+(CaseHeight-CutFromTop-BottomTopThickness)/2 ]) rotate([90,0,90]) cylinder(h=SideWallThickness+0.04,d=SideWallHoleDiameter,center = true);
                        }

                        if ((CountOfSideWallHoles==3)&&(!YAdditionalScrew))
                        {
                            translate([Caselength/2-SideWallThickness/2,0,SiedWallHoleOffset_Z+ BottomTopThickness+(CaseHeight-CutFromTop-BottomTopThickness)/2 ]) rotate([90,0,90]) cylinder(h=SideWallThickness+0.04,d=SideWallHoleDiameter,center = true);
                        }



                    }


                    if ((CountOfSideWallHoles==1)&&(YAdditionalScrew))
                    {
                        translate([Caselength/2-SideWallThickness/2,-CaseWidth/4+CaseRoundingRadius/2,SiedWallHoleOffset_Z+ BottomTopThickness+(CaseHeight-CutFromTop-BottomTopThickness)/2 ]) rotate([90,0,90]) cylinder(h=SideWallThickness+0.04,d=SideWallHoleDiameter,center = true);
                    }



                    if ((CountOfSideWallHoles==2)||(CountOfSideWallHoles==3))
                    {
                        translate([Caselength/2-SideWallThickness/2,CaseWidth/4-CaseRoundingRadius/2,SiedWallHoleOffset_Z+ BottomTopThickness+(CaseHeight-CutFromTop-BottomTopThickness)/2 ]) rotate([90,0,90]) cylinder(h=SideWallThickness+0.04,d=SideWallHoleDiameter,center = true);
                        translate([Caselength/2-SideWallThickness/2,-CaseWidth/4+CaseRoundingRadius/2,SiedWallHoleOffset_Z+ BottomTopThickness+(CaseHeight-CutFromTop-BottomTopThickness)/2 ]) rotate([90,0,90]) cylinder(h=SideWallThickness+0.04,d=SideWallHoleDiameter,center = true);
                    }
                }
            }
        }
    }
}

module BodyTop () {
    if (ShowTop)
    {
        difference(){
            union(){
                rotate([  0,  0,  0]) BodyQuarterTop(Caselength,CaseWidth,CutFromTop,CaseRoundingRadius,SideWallThickness);
                rotate([  0,  0,180]) BodyQuarterTop(Caselength,CaseWidth,CutFromTop,CaseRoundingRadius,SideWallThickness);
                mirror([  0,  1,  0]) BodyQuarterTop(Caselength,CaseWidth,CutFromTop,CaseRoundingRadius,SideWallThickness);
                mirror([  1,  0  ,0]) BodyQuarterTop(Caselength,CaseWidth,CutFromTop,CaseRoundingRadius,SideWallThickness);
            }
            if (SeeGrooveRidgeScrew) { color("red") translate([-CaseRoundingRadius-50,0,(CaseHeight+0.1)/2-0.05]) cube([Caselength+0.1,CaseWidth+0.1,CaseHeight+0.1],center=true);}
        }
    }
}


// Places wall mount holders based on the selected side option.
// Coordinate convention for this box:
//   cable holes are on the bottom short end: negative X
//   TopBottom mounts are on negative X and positive X ends
//   LeftRight mounts are on negative Y and positive Y sides
module MountHolderPlacementSet(Thick, Hole) {
    if ((MountHolderPlacement == "LeftRight") || (MountHolderPlacement == "All")) {
        if (MountHolderStyle != 5) {
            translate([0, CaseWidth/2, 0])
                MountHolder(Thick, Hole, Span=Caselength, PairDistance=CaseWidth);
            rotate([0,0,180])
                translate([0, CaseWidth/2, 0])
                    MountHolder(Thick, Hole, Span=Caselength, PairDistance=CaseWidth);
        } else {
            translate([0, CaseWidth/2, 0])
                MountHolder(Thick, Hole, Span=Caselength, PairDistance=CaseWidth);
        }
    }

    if ((MountHolderPlacement == "TopBottom") || (MountHolderPlacement == "All")) {
        if (MountHolderStyle != 5) {
            rotate([0,0,-90])
                translate([0, Caselength/2, 0])
                    MountHolder(Thick, Hole, Span=CaseWidth, PairDistance=Caselength);
            rotate([0,0,90])
                translate([0, Caselength/2, 0])
                    MountHolder(Thick, Hole, Span=CaseWidth, PairDistance=Caselength);
        } else {
            rotate([0,0,-90])
                translate([0, Caselength/2, 0])
                    MountHolder(Thick, Hole, Span=CaseWidth, PairDistance=Caselength);
        }
    }
}

module MountHolder (Thick,Hole, Span=Caselength, PairDistance=CaseWidth) {
    
    translate([0,0,0.005]) difference(){  
       
        if (MountHolderStyle==1){
            $fn=40; 
           roundedBox([Span, MountHolderLenght*2, Thick*2], Thick/3, 0);
        }
        if (MountHolderStyle==2){
            $fn=60;
           roundedBox([Span, MountHolderLenght*2, Thick*2],CaseRoundingRadius , 1);
        }
        if (MountHolderStyle==3){
            roundedBox([Span, MountHolderLenght*2, Thick*2],0 , 2);
        }      
        if((MountHolderStyle>0)&&(MountHolderStyle<4)){
            translate([0,0,-Thick/2-0.02]) cube([Span+0.02,MountHolderLenght*2+0.02,Thick+0.04],center=true);
            translate([0,-MountHolderLenght/2-CaseRoundingRadius,Thick/2+0.02]) cube([Span+0.02,MountHolderLenght+0.02,Thick+0.08],center=true);
            translate([0,-MountHolderLenght/2,Thick/2+0.02]) cube([Span-2*CaseRoundingRadius+0.02,MountHolderLenght+0.02,Thick+0.08],center=true);
            translate([0,-CaseRoundingRadius,MountHolderThickness/2-0.02]) translate(ScrewAddYPos) cylinder(h=MountHolderThickness+0.06,d=ScrewHoleDia,center = true);
            mirror([  1,  0,  0]) translate([0,-CaseRoundingRadius,MountHolderThickness/2-0.02]) translate(ScrewAddYPos) cylinder(h=MountHolderThickness+0.06,d=ScrewHoleDia,center = true);

            if (CountOfMountHolderHoles>1){
                translate([Span/2-Hole-Thick/3,Hole*1.5,MountHolderThickness/2-0.02]) cylinder(h=MountHolderThickness+0.06,d=Hole,center = true); 
                translate([-Span/2+Hole+Thick/3,Hole*1.5,MountHolderThickness/2-0.02]) cylinder(h=MountHolderThickness+0.06,d=Hole,center = true);  
            }
            if (CountOfMountHolderHoles!=2){
                translate([0,Hole*1.5,MountHolderThickness/2-0.02]) cylinder(h=MountHolderThickness+0.06,d=Hole,center = true);   
            }
        }



    }
    if (MountHolderStyle==4){
        HolderRad=Hole/2;
        HolderWidth=4*Hole;
        translate([0,MountHolderLenght,0]) difference(){
            union(){        
                translate([0,-MountHolderLenght+HolderRad,0]) roundedBox([HolderWidth, MountHolderLenght*2, Thick*2],HolderRad , 0);
                translate([-HolderWidth/2+HolderRad,0,0]) rotate([0,0,-45]) translate([HolderWidth-HolderRad,-MountHolderLenght+HolderRad,0]) roundedBox([2*HolderWidth, MountHolderLenght*2, Thick*2],HolderRad , 0);
                translate([ HolderWidth/2-HolderRad,0,0]) rotate([0,0,45]) translate([-HolderWidth+HolderRad,-MountHolderLenght+HolderRad,0]) roundedBox([2*HolderWidth, MountHolderLenght*2, Thick*2],HolderRad , 0);
            }
            translate([0,-(3*HolderWidth)/2-MountHolderLenght,-0.02]) cube([10*HolderWidth,3*HolderWidth,Thick*2+0.06],center=true);
            translate([0,-(3*HolderWidth)/2,-Thick-0.02]) cube([4*HolderWidth,4*HolderWidth,Thick*2],center=true);
            translate([0,-MountHolderLenght+Hole*1.8,MountHolderThickness/2-0.02]) cylinder(h=MountHolderThickness+0.06,d=Hole,center = true);  
        }
    }



    if (MountHolderStyle==5){
        HolderRad=Hole/2;
        HolderWidth=4*Hole;
        translate([0,MountHolderLenght,0]) difference()
        {
            union(){      
                $fn=40;  
                translate([0,-MountHolderLenght+HolderRad,0]) roundedBox([HolderWidth, MountHolderLenght*2, Thick*2],HolderRad , 0);
                translate([-HolderWidth/2+HolderRad,0,0]) rotate([0,0,-45]) translate([HolderWidth-HolderRad,-MountHolderLenght+HolderRad,0]) roundedBox([2*HolderWidth, MountHolderLenght*2, Thick*2],HolderRad , 0);
                translate([ HolderWidth/2-HolderRad,0,0]) rotate([0,0,45]) translate([-HolderWidth+HolderRad,-MountHolderLenght+HolderRad,0]) roundedBox([2*HolderWidth, MountHolderLenght*2, Thick*2],HolderRad , 0);
            }
            translate([0,-(3*HolderWidth)/2-MountHolderLenght,-0.02]) cube([10*HolderWidth,3*HolderWidth,Thick*4+0.06],center=true);
            translate([0,-(3*HolderWidth)/2,-Thick-0.02]) cube([4*HolderWidth,4*HolderWidth,Thick*2],center=true);
            hull(){
                translate([-Hole/1.1,-MountHolderLenght+Hole*1.6,MountHolderThickness/2-0.02]) cylinder(h=MountHolderThickness+0.06,d=Hole,center = true);  
                translate([+Hole/1.1,-MountHolderLenght+Hole*1.6,MountHolderThickness/2-0.02]) cylinder(h=MountHolderThickness+0.06,d=Hole,center = true);  
            }
        }

        rotate([0,0,180]) translate([0,MountHolderLenght+PairDistance,0]) difference()
        {
            union(){  
                $fn=40;       
                translate([0,-MountHolderLenght+HolderRad,0]) roundedBox([HolderWidth, MountHolderLenght*2, Thick*2],HolderRad , 0);
                translate([-HolderWidth/2+HolderRad,0,0]) rotate([0,0,-45]) translate([HolderWidth-HolderRad,-MountHolderLenght+HolderRad,0]) roundedBox([2*HolderWidth, MountHolderLenght*2, Thick*2],HolderRad , 0);
                translate([ HolderWidth/2-HolderRad,0,0]) rotate([0,0,45]) translate([-HolderWidth+HolderRad,-MountHolderLenght+HolderRad,0]) roundedBox([2*HolderWidth, MountHolderLenght*2, Thick*2],HolderRad , 0);
            }
            translate([0,-(3*HolderWidth)/2-MountHolderLenght,-0.02]) cube([10*HolderWidth,3*HolderWidth,Thick*2+0.06],center=true);
            translate([0,-(3*HolderWidth)/2,-Thick-0.02]) cube([4*HolderWidth,4*HolderWidth,Thick*2],center=true);
            hull(){
                    translate([0,-MountHolderLenght+Hole*1.6+Hole/1.8,MountHolderThickness/2-0.02]) cylinder(h=MountHolderThickness+0.06,d=Hole,center = true);  
                    translate([0,-MountHolderLenght+Hole*1.6-Hole/1.8,MountHolderThickness/2-0.02]) cylinder(h=MountHolderThickness+0.06,d=Hole,center = true);  
            }
        }       
        
    }


}

module ShowSizes () {
    echo ();
    echo (str(" Stable and waterproof OpenSCAD case by pbtec V6.0"));
    echo ();
    echo (str(" Render quality : ",$fn));
    echo ();
    echo (str(" --> Case outer dimensions: "));
    echo (str(" Length : ",Caselength,"mm "));
    echo (str(" Width : ",CaseWidth,"mm "));
    echo (str(" High : ",CaseHeight,"mm "));
    echo (str(" Top (upper piece) high : ",CutFromTop,"mm "));
    echo (str(" Bottom (lower piece) high : ",CaseHeight-CutFromTop,"mm "));
    echo (str(" Side wall thickness : ",SideWallThickness,"mm "));
    echo (str(" Bottom & top wall thickness : ",BottomTopThickness,"mm "));
    echo (str(" Case rounding radius : ",CaseRoundingRadius,"mm "));
    echo ();
    echo (str(" --> Case inner dimensions : "));
    echo (str(" X : Wall to wall : ",Caselength-2*SideWallThickness,"mm "));
    echo (str(" X : Screw cylinder to screw cylinder : ",Caselength-4*CaseRoundingRadius,"mm "));
    echo (str(" Y : Wall to wall : ",CaseWidth-2*SideWallThickness,"mm "));
    echo (str(" Y : Screw cylinder to screw cylinder : ",CaseWidth-4*CaseRoundingRadius,"mm "));
    echo (str(" Top to bottom  : ",CaseHeight-2*BottomTopThickness,"mm "));
    echo ();
    echo (str(" <b>Screw dimensions : "));
    echo (str(" Metric Screw size: m",CountersinkScrew));
    echo (str(" Screw hole diameter : ",ScrewHoleDia,"mm "));
    echo (str(" Screw head diameter : ",ScrewHeadDia,"mm "));
    echo (str(" X : Additional screw (3rd)) : ",XAdditionalScrew));
    echo (str(" Y : Additional screws (3rd) : ",YAdditionalScrew));
    echo (str(" --> Check if you have screws within the following size : "));
    echo (str(" --> Screw m",CountersinkScrew , " max length : ",CaseHeight-BottomTopThickness, "mm"));
    if(UseSquareNutInsteadOfNut) { echo (str(" --> Screw m",CountersinkScrew , " min length : ",CutFromTop+NutSink+SquareNutHigh, "mm")); }
    else                         { echo (str(" --> Screw m",CountersinkScrew , " min length : ",CutFromTop+NutSink+NutHigh, "mm")); }
}

module GrooveStraight (length) {
   color("orange") translate([length/2,0,-(GrooveDepth+AddGrooveDepthForSealing)/2]) cube([length,GrooveWidth,GrooveDepth+AddGrooveDepthForSealing],center=true);
}

module GrooveCurved (Angle,Rad) {
    color("orange") difference(){
        translate([0,0,-(GrooveDepth+AddGrooveDepthForSealing)]) pie(Rad+(GrooveWidth)/2, Angle, GrooveDepth+AddGrooveDepthForSealing, spin=0);
        translate([-0.01,-0.01,-(GrooveDepth+AddGrooveDepthForSealing+0.02)]) pie(Rad-(GrooveWidth)/2, Angle, GrooveDepth+AddGrooveDepthForSealing+0.04, spin=0);
    }
}

module RidgeStraight (length) {
    color("orange") translate([length/2,0,(RidgeHeight)/2]) cube([length,RidgeWidth,RidgeHeight],center=true);
}

module RidgeCurved (Angle,Rad) {
    color("orange") difference(){
        translate([0,0,0])         pie(Rad+(RidgeWidth)/2, Angle, RidgeHeight, spin=0);
        translate([-0.01,-0.01,-0.02]) pie(Rad-(RidgeWidth)/2, Angle, RidgeHeight+0.04, spin=0);
    }
}

module BodyQuarterBottom (Caselength,CaseWidth,CutFromTop,CaseRoundingRadius,SideWallThickness) {
    difference(){
        union(){
            color("SteelBlue")BodyQuarter(Caselength,CaseWidth,CutFromTop,CaseRoundingRadius,SideWallThickness);

            translate([CaseRoundingRadius+ScrewHoleDia/2-0.01,CaseWidth/2-OuterBorder-GrooveWidth/2-0.01,CutFromTop+0.01])  translate([0,0,0]) rotate([0,0,0])  RidgeStraight(Caselength/2-3*CaseRoundingRadius-ScrewHoleDia+0.03);          
            translate([Caselength/2-OuterBorder-GrooveWidth/2-0.01,CaseRoundingRadius+ScrewHoleDia/2-0.02,CutFromTop+0.01]) translate([0,0,0]) rotate([0,0,90]) RidgeStraight(CaseWidth/2-3*CaseRoundingRadius-ScrewHoleDia+0.04);          
            translate([0,0,CutFromTop+0.01]) translate(ScrewCornerPos) rotate([0,0,180]) RidgeCurved(90,ScrewHoleDia/2+OuterBorder+GrooveWidth/2);
            translate([-ScrewHoleDia-SideWallThickness+0.02,-0.01,CutFromTop+0.01]) translate(ScrewCornerPos) rotate([0,0,0]) RidgeCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);
            translate([-0.01,-ScrewHoleDia-SideWallThickness+0.00,CutFromTop+0.01]) translate(ScrewCornerPos) rotate([0,0,0]) RidgeCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);



            if (XAdditionalScrew){
                translate([0,0,CutFromTop+0.01]) translate(ScrewAddXPos)   rotate([0,0,180])                                RidgeCurved(180,ScrewHoleDia/2+OuterBorder+GrooveWidth/2);
                translate([-ScrewHoleDia-SideWallThickness+0.04,-0.01,CutFromTop+0.01]) translate(ScrewAddXPos) rotate([0,0,0]) RidgeCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);
                translate([ScrewHoleDia+SideWallThickness,-0.01,CutFromTop+0.01]) translate(ScrewAddXPos) rotate([0,0,90])     RidgeCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);
            }
            else{
                translate([-0.01,CaseWidth/2-OuterBorder-GrooveWidth/2-0.01,CutFromTop+0.01])  translate([0,0,0]) rotate([0,0,0]) RidgeStraight(Caselength/2-2*CaseRoundingRadius-ScrewHoleDia/2+0.05);
            }
            if (YAdditionalScrew){
                translate([0,0,CutFromTop+0.01]) translate(ScrewAddYPos)   rotate([0,0,90])  RidgeCurved(180,ScrewHoleDia/2+OuterBorder+GrooveWidth/2);
                translate([-0.01,-ScrewHoleDia-SideWallThickness-0.01,CutFromTop+0.01]) translate(ScrewAddYPos) rotate([0,0,0]) RidgeCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);
                translate([-0.01,ScrewHoleDia+SideWallThickness-0.01,CutFromTop+0.01]) translate(ScrewAddYPos) rotate([0,0,270]) RidgeCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);
            }  
            else{translate([Caselength/2-OuterBorder-GrooveWidth/2-0.01,-0.01,CutFromTop+0.01])  translate([0,0,0]) rotate([0,0,90]) RidgeStraight(CaseWidth/2-2*CaseRoundingRadius-ScrewHoleDia/2+0.05);}  
        }


        if(UseSquareNutInsteadOfNut)
        {
            if (EdgeSquareNutInsertFrom_X) {translate(ScrewCornerPos) translate([0,0,CutFromTop+0.01]) rotate([0,0, 0]) SquareNutCut(CutFromTop,SquareNutHigh,SquareNutSize);}
            else                           {translate(ScrewCornerPos) translate([0,0,CutFromTop+0.01]) rotate([0,0,90]) SquareNutCut(CutFromTop,SquareNutHigh,SquareNutSize);}
        }
        else {translate(ScrewCornerPos) translate([0,0,CutFromTop+0.01]) NutCut(CutFromTop,NutHigh,NutDia);}





        if (XAdditionalScrew){
            if(UseSquareNutInsteadOfNut) {translate(ScrewAddXPos) translate([0,0,CutFromTop+0.01]) rotate([0,0,90]) SquareNutCut(CutFromTop,SquareNutHigh,SquareNutSize);}
            else                         {translate(ScrewAddXPos) translate([0,0,CutFromTop+0.01]) NutCut(CutFromTop,NutHigh,NutDia);}
        }
        if (YAdditionalScrew){
            if(UseSquareNutInsteadOfNut) {translate(ScrewAddYPos) translate([0,0,CutFromTop+0.01]) SquareNutCut(CutFromTop,SquareNutHigh,SquareNutSize);}
            else                         {translate(ScrewAddYPos) translate([0,0,CutFromTop+0.01]) NutCut(CutFromTop,NutHigh,NutDia);}
        }
    }
}

module BodyQuarterTop (Caselength,CaseWidth,CutFromTop,CaseRoundingRadius,SideWallThickness) {

    difference()
    {
        union(){
            color("DarkCyan")BodyQuarter(Caselength,CaseWidth,CutFromTop,CaseRoundingRadius,SideWallThickness);
        }
        translate(ScrewCornerPos) ScrewCut(CountersinkScrew,CutFromTop+0.01,0);
        if (XAdditionalScrew){
            translate(ScrewAddXPos) ScrewCut(CountersinkScrew,CutFromTop+0.01,0);
        }
        if (YAdditionalScrew){
            translate(ScrewAddYPos) ScrewCut(CountersinkScrew,CutFromTop+0.01,0);
        }
        translate([CaseRoundingRadius+ScrewHoleDia/2-0.01,CaseWidth/2-OuterBorder-GrooveWidth/2-0.01,CutFromTop+0.01])  translate([0,0,0]) rotate([0,0,0]) GrooveStraight(Caselength/2-3*CaseRoundingRadius-ScrewHoleDia+0.03);          
        translate([Caselength/2-OuterBorder-GrooveWidth/2-0.01,CaseRoundingRadius+ScrewHoleDia/2-0.02,CutFromTop+0.01])  translate([0,0,0]) rotate([0,0,90]) GrooveStraight(CaseWidth/2-3*CaseRoundingRadius-ScrewHoleDia+0.04);          
        translate([0,0,CutFromTop+0.01]) translate(ScrewCornerPos) rotate([0,0,180]) GrooveCurved(90,ScrewHoleDia/2+OuterBorder+GrooveWidth/2);
        translate([-ScrewHoleDia-SideWallThickness+0.02,-0.01,CutFromTop+0.01]) translate(ScrewCornerPos) rotate([0,0,0]) GrooveCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);
        translate([-0.01,-ScrewHoleDia-SideWallThickness+0.0,CutFromTop+0.01]) translate(ScrewCornerPos) rotate([0,0,0]) GrooveCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);
        if (XAdditionalScrew){
            translate([0,0,CutFromTop+0.01]) translate(ScrewAddXPos)   rotate([0,0,180])                                GrooveCurved(180,ScrewHoleDia/2+OuterBorder+GrooveWidth/2);
            translate([-ScrewHoleDia-SideWallThickness+0.04,-0.01,CutFromTop+0.01]) translate(ScrewAddXPos) rotate([0,0,0]) GrooveCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);
            translate([ScrewHoleDia+SideWallThickness,-0.01,CutFromTop+0.01]) translate(ScrewAddXPos) rotate([0,0,90])     GrooveCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);
        }
        else{
            translate([-0.01,CaseWidth/2-OuterBorder-GrooveWidth/2-0.01,CutFromTop+0.01])  translate([0,0,0]) rotate([0,0,0]) GrooveStraight(Caselength/2-2*CaseRoundingRadius-ScrewHoleDia/2+0.07);          
        }

        if (YAdditionalScrew){
            translate([0,0,CutFromTop+0.01]) translate(ScrewAddYPos)   rotate([0,0,90])  GrooveCurved(180,ScrewHoleDia/2+OuterBorder+GrooveWidth/2);
            translate([-0.01,-ScrewHoleDia-SideWallThickness-0.01,CutFromTop+0.01]) translate(ScrewAddYPos) rotate([0,0,0]) GrooveCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);
            translate([-0.01,ScrewHoleDia+SideWallThickness-0.01,CutFromTop+0.01]) translate(ScrewAddYPos) rotate([0,0,270]) GrooveCurved(90,ScrewHoleDia/2+InnerBorder+GrooveWidth/2);
        }
        else{
            translate([Caselength/2-OuterBorder-GrooveWidth/2-0.01,-0.01,CutFromTop+0.01])  translate([0,0,0]) rotate([0,0,90]) GrooveStraight(CaseWidth/2-2*CaseRoundingRadius-ScrewHoleDia/2+0.057);          
    
        }
    }
}

module BodyQuarter (L,W,H,Rad,Rand){   
            cube([L/2-Rad,W/2,BottomTopThickness],center=false); // Ground
            cube([L/2,W/2-Rad,BottomTopThickness],center=false); // Ground
        if (CaseRadius < CaseRoundingRadius)
            {
                translate([0,W/2-Rand,0]) cube([L/2-CaseRadius,Rand,H],center=false); // Wall
                translate([L/2-Rand,0,0]) cube([Rand,W/2-CaseRadius,H],center=false); // Wall
                translate([L/2-CaseRadius,W/2-CaseRadius,H/2]) cylinder(h=H,r=CaseRadius,center = true);
            }
            else
            {
                translate([0,W/2-Rand,0]) cube([L/2-Rad,Rand,H],center=false); // Wall
                translate([L/2-Rand,0,0]) cube([Rand,W/2-Rad,H],center=false); // Wall
            }

            translate(ScrewCornerPos) cylinder(h=H,r=Rad,center = false); // Cylinder
            translate([L/2-3*Rad+Rand,W/2-Rad,0]) rotate([0,0,  0]) HolderGap(H,Rad,Rand); // Gap between wall and Cylinder
            translate([L/2-Rad,W/2-Rad-Rand,0])   rotate([0,0,-90]) HolderGap(H,Rad,Rand); // Gap Between wall and Cylinder

            if (XAdditionalScrew)    {
                translate(ScrewAddXPos) cylinder(h=H,r=Rad,center = false); // Cylinder
                translate([Rand,W/2-Rad,0]) rotate([0,0,0]) HolderGap(H,Rad,Rand);
                translate([Rand-2*CaseRoundingRadius,W/2-Rad,0]) rotate([0,0,0]) HolderGap(H,Rad,Rand);
            }

            if (YAdditionalScrew)    {
                translate(ScrewAddYPos) cylinder(h=H,r=Rad,center = false); // Cylinder
                translate([L/2-3*Rad+2*CaseRoundingRadius,-Rand+2*CaseRoundingRadius,0]) rotate([0,0, 270]) HolderGap(H,Rad,Rand);
                translate([L/2-3*Rad+2*CaseRoundingRadius,-Rand,0]) rotate([0,0, 270]) HolderGap(H,Rad,Rand);
            }   
}

module NutCut(TotalHigh,High,Dia){
    AdditionalGap=0.3;
    translate([0,0,-(High+2*AdditionalGap)/2-NutSink]) cylinder($fn=6,h=High+2*AdditionalGap,d=2*sqrt(((Dia/2)*(Dia/2))+((Dia/4)*(Dia/4)))+Dia/26+2*AdditionalGap,center = true);
    translate([0,0,-(TotalHigh-SideWallThickness)/2]) cylinder(h=TotalHigh-SideWallThickness,d=ScrewHoleDia,center = true);
}

module SquareNutCut (TotalHigh,High,Size) {
    AdditionalGap=0.5;
    SquareNutInsertReduction= 0.2;

    translate([0,0,-(High+2*AdditionalGap)/2-NutSink])cube([Size+2*AdditionalGap,Size+2*AdditionalGap,High+2*AdditionalGap],center=true);
    translate([CaseRoundingRadius/2+0.02,0,-(High+2*AdditionalGap)/2-NutSink+SquareNutInsertReduction/2]) cube([CaseRoundingRadius+0.04,Size+2*AdditionalGap,High+2*AdditionalGap-SquareNutInsertReduction],center=true);
    translate([0,0,-(TotalHigh-SideWallThickness)/2]) cylinder(h=TotalHigh-SideWallThickness,d=ScrewHoleDia,center = true);
}

module SideWallHoles () {
    cylinder(h=20,d1=10,d2=15,center = true);
}


module ScrewCut(m,h,v){
// m = 3=M3  4=M4  5=M5 6=M6 usw...  
// h = High of the screw inkl. head
// v = if screw head is to be sunk deeper

    ScrewHeadDia=m*2; // Berechnung des Schraubenkopf Durchmessers
    //ScrewCountersink=(m+8)/14-0.7; // Leichte ScrewCountersink damit Schraube nicht vorsteht
    ScrewHoleDia=m+1; // ScrewHoleDiadurchmesser

    translate([0,0,-0.01])  union(){ // Ganze Schraube

            translate([0,0,ScrewCountersink-0.01])cylinder( h = ScrewHeadDia/4,d1=ScrewHeadDia,d2=ScrewHeadDia/2,center=false); // Kegel (Abschraegung)
            translate([0,0,0]) cylinder( h = ScrewCountersink,d=ScrewHeadDia,center=false);  // ScrewCountersink
            translate([0,0,0.01])rotate([180,0,0])cylinder(h=v,d=ScrewHeadDia,center = false); // Versenkung
            translate([0,0,0.01])cylinder( h = h,d=ScrewHoleDia,center=false); //Loch fuer Gewinde
    }
}

module HolderGap (H,Rad,Rand) {
    difference(){
        translate([0,0,0]) cube([Rad*2-2*Rand,Rad-Rand,H],center=false);
        translate([0,0,-0.02]) cylinder(h=H+0.04,r=Rad-Rand,center = false);
        translate([2*(Rad-Rand),0,-0.02]) cylinder(h=H+0.04,r=Rad-Rand,center = false);
    }
}

module DeviceHolder () {
    color("yellow")translate([0,0,ScrewCylinderHeight/2+BottomTopThickness]) difference(){
        cylinder(h=ScrewCylinderHeight,d=ScrewCylinderDiameter,center = true);
        translate([0,0,0]) cylinder(h=ScrewCylinderHeight+0.05,d=ScrewHoleDiameter,center = true);
    }

}

module pie(radius, angle, height, spin=0) {
    // Negative angles shift direction of rotation
    clockwise = (angle < 0) ? true : false;
    // Support angles < 0 and > 360
    normalized_angle = abs((angle % 360 != 0) ? angle % 360 : angle % 360 + 360);
    // Select rotation direction
    rotation = clockwise ? [0, 180 - normalized_angle] : [180, normalized_angle];
    // Render
    if (angle != 0) {
        rotate([0,0,spin]) linear_extrude(height=height)
            difference() {
                circle(radius);
                if (normalized_angle < 180) {
                    union() for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
                else if (normalized_angle != 360) {
                    intersection_for(a = rotation)
                        rotate(a) translate([-radius, 0, 0]) square(radius * 2);
                }
            }
    }
}

module roundedBox(size, radius, sidesonly) // Laenge, Breite, Hoehe, Radius, 0/1
{
  rot = [ [0,0,0], [90,0,90], [90,90,0] ];
  if (sidesonly) {
    cube(size - [2*radius,0,0], true);
    cube(size - [0,2*radius,0], true);
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2]) {
      translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
    }
  }
  else {
    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

    for (axis = [0:2]) {
      for (x = [radius-size[axis]/2, -radius+size[axis]/2],
             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
        rotate(rot[axis]) 
          translate([x,y,0]) 
          cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
      }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2],
           z = [radius-size[2]/2, -radius+size[2]/2]) {
      translate([x,y,z]) sphere(radius);
    }
  }
}

