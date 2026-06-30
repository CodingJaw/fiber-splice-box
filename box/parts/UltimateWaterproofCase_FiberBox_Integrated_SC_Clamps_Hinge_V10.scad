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
// Shows the Bottom of the case
ShowBottom                = true;
// Shows the top of the case
ShowTop                   = true;
// Distance between top and bottom (if both are side by side displayed)
DistanceBetweenObjects    = 10;
// Shows the housing assembled
ShowCaseAssembled         = false;


/* [Control cuts (use only one at a time)] */

// To see the nuts inside (best view if not assembled showed)
SeeNutCut                 = false;
// To see the groove, ridge and Screw (best view if assembled showed)
SeeGrooveRidgeScrew       = false;


/* [Case settings] */

// Length of the case
Caselength                = 120;
// Width of the case
CaseWidth                 = 100;
// Height of the case
CaseHeight                = 45;
// Splitt the Case height into bottom and top, check for the needed screws in echo output (console)
CutFromTop                = 12.0;    
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
GrooveWidth               = 1.2;   // [0.8:0.1:3]

// Not less than 1mm (for stability) and not more than 3mm --> Best 2mm
GrooveDepth               = 2.0;   // [1.0:0.1:3]

// Space between Groove and Ridge for a perfect fit, usualy 0.2 or 0.3 for FDM depending on your printer quality
Space                     = 0.3;   // [0.0:0.1:0.4]

// Addtional vertical room for the pressed sealing Cord. For sealing cord 1.5mm -->0.5 // for 2mm -->0.8 // for 2.5 -->1.0 // If no sealing cord then set this parameter to 0.
AddGrooveDepthForSealing  = 0.8;   // [0.0:0.1:3]   

// Range Inside groove/ridge. Usualy 2 times or more the printer nozzle. For best stability at least 0.8
InnerBorder               = 0.8;   // [0.8:0.1:4]


// Range Outside groove/ridge . Usualy 2 times or more the printer nozzle. For best stability at least 0.8
OuterBorder               = 0.8;   // [0.8:0.1:4]

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

// Chose your desired wall mount style
MountHolderStyle          = 5;      // [1:Style 1, 2: Style 2, 3: Style 3, 4 : Style 4, 5 : Style 5]

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


/* [Fiber outdoor connection box additions] */
// Keep exterior sealed except for the two 1/2 inch bottom cable entry holes.
EnableFiberConnectionBox  = true;
// Two cable entry holes on the bottom/narrow end wall. 1/2 inch = 12.7 mm.
FiberBottomHoleDiameter   = 12.7;
FiberBottomHoleSpacing    = 30;
FiberBottomHoleCenterZ    = 12;
// Cable sheath clamp just inside the entry holes. Adjust sheath size if needed.
FiberCableSheathDiameter  = 5.2;
FiberClampScrewDiameter   = 3.0;
FiberClampScrewSpacing    = 14;
// Raised internal SC adapter holder. No exterior SC cutouts are made.
// Image-style holder: SC couplers slide front-to-back through a raised bracket,
// so the plug openings face inside the box from top/bottom side access direction, not through the box wall.
SC_Holder_Spacing         = 18;     // center-to-center spacing between two simplex SC couplers
SC_Cutout_Width           = 10.5;   // SC coupler body width, side-to-side
SC_Cutout_Height          = 8.0;    // SC coupler body height in the vertical bracket
SC_Cutout_Length          = 30.0;   // front-to-back clearance through the holder
SC_Holder_Base_Height     = 5.0;    // raised base under connector bracket
SC_Holder_Block_Height    = 17.0;   // total height of vertical connector bracket above base
SC_Holder_Block_Thickness = 7.0;    // front/back thickness of the retaining bracket
SC_Holder_End_Offset      = 70;     // from narrow cable-entry end; places mount just past the box halfway point
SC_Holder_ScrewDiameter   = 3.0;
SC_Holder_Back_Offset     = -22;    // moves SC holder toward back side to leave tray swing clearance


/* [Integrated fiber box assembly - V10] */
// Shows the removable split cable clamps installed in the two bottom holes for fit preview.
Fiber_Show_Removable_Clamps_In_Box = true;
// Adds an internal hinge rail for a future swing-out fiber tray. This does not add exterior holes.
Fiber_Add_Internal_Tray_Hinge = true;

// Removable split-bushing cable clamp settings.
Clamp_Entry_Hole_Dia       = 12.7;
Clamp_Hole_Clearance       = 0.35;
Clamp_Cable_Dia            = 5.2;
Clamp_Cable_Compression    = 0.20;
Clamp_Bushing_Protrusion   = 1.0;
Clamp_Bushing_InBox_Depth  = 5.0;
Clamp_Depth                = 17.0;
Clamp_Width                = 25.0;
Clamp_Half_Height          = 6.4;
Clamp_Screw_Dia            = 3.2;
Clamp_Lower_Pilot_Dia      = 2.6;
Clamp_Screw_Head_Dia       = 6.3;
Clamp_Screw_Head_Depth     = 1.8;
Clamp_Screw_Y              = 8.6;
Clamp_Screw_X              = 10.0;
Clamp_Align_Pin_Dia        = 2.2;
Clamp_Align_Pin_Clearance  = 0.25;
Clamp_Align_Pin_Height     = 2.0;
Clamp_Align_Pin_X          = 15.0;
Clamp_Align_Pin_Y          = 5.8;

// Corrected slide-in SC/APC holder settings, based on the external connector measurements.
SC2_Count                  = 2;
SC2_Flange_W              = 15.0;
SC2_Flange_H              = 9.3;
SC2_Flange_T              = 2.9;
SC2_Body_W                = 12.8;
SC2_Body_H                = 9.3;
SC2_Body_Depth_Y          = 27.5;
SC2_Body_Clear_W          = 13.6;
SC2_Body_Clear_H          = 10.1;
SC2_Clearance             = 0.40;
SC2_Holder_Pitch          = 24.0;
SC2_Base_Thickness        = 3.0;
SC2_Base_Depth_Y          = 28.0;
SC2_Base_Margin_X         = 5.0;
SC2_Base_End_Extra_X      = 7.0;
SC2_Bottom_Stop_H         = 1.7;
SC2_Rail_Depth_Y          = 10.0;
SC2_Rail_Outer_Wall_X     = 2.2;
SC2_Carrier_Top_Relief_Z  = 0.35;
SC2_Keeper_Thickness      = 2.6;
SC2_Keeper_Depth_Y        = 12.0;
SC2_Keeper_End_Overhang_X = 6.0;
SC2_Keeper_Clearance_Z    = 0.10;
SC2_Keeper_Screw_Dia      = 3.2;
SC2_Keeper_Head_Dia       = 6.4;
SC2_Keeper_Head_Depth     = 1.3;
SC2_Screw_Boss_Dia        = 8.5;
SC2_Screw_Pilot_Dia       = 2.4;
// Position of the SC holder inside the box. X is measured from box center.
SC2_Pos_X                 = 13;
SC2_Pos_Y                 = -22;

// Future tray hinge mount. Hinge axis is along X on the back inside wall.
Tray_Hinge_Pin_Dia        = 3.2;
Tray_Hinge_Barrel_OD      = 7.0;
Tray_Hinge_Barrel_L       = 10.0;
Tray_Hinge_Z              = 25.0;
Tray_Hinge_Y_Offset       = 6.0;
Tray_Hinge_X_Spacing      = 30.0;



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
X_ObjectPosition = ((ShowBottom)&&(ShowTop)&&(!ShowCaseAssembled)) ? Caselength/2+DistanceBetweenObjects/2:0;

// If the case is assembled showed
Y_TopRotation = ShowCaseAssembled ? 180:0;
Z_TopHigh = ShowCaseAssembled ? CaseHeight:0;

ShowSizes(); // Show the calculated sizes

//===============================================================================
//                                    M A I N
//===============================================================================

// --> Show the bottom of the case
translate([X_ObjectPosition,0,0]) rotate([0,0,0]) difference(){
    union(){
        BodyBottom();
        if (EnableFiberConnectionBox) FiberBoxBottomAdditions();
        // **** Add your bottom case additions here ****
        //cylinder(h=20,d=15,center = true); // Example
    }
    // **** Add your bottom case cuts here ****
    if (EnableFiberConnectionBox) FiberBoxBottomCuts();
    //cylinder(h=15,d=20,center = true); // Example
}

// --> Show the top of the case
translate([-X_ObjectPosition,0,Z_TopHigh+0.03]) rotate([0,Y_TopRotation,0]) difference(){
    union(){
        BodyTop();
        // **** Add your bottom top additions here ****
        //cylinder(h=18,d=10,center = true); // Example
    }
    // **** Add your top case cuts here ****
    //cylinder(h=20,d=5,center = true); // Example
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
                    if (MountHolderStyle!=5)
                    {
                    translate([0,CaseWidth/2,0]) MountHolder(MountHolderThickness,MountHolderHoleDiameter);               
                    rotate([0,0,180]) translate([0,CaseWidth/2,0]) MountHolder(MountHolderThickness,MountHolderHoleDiameter);
                    }
                    else
                    {
                        translate([0,CaseWidth/2,0]) MountHolder(MountHolderThickness,MountHolderHoleDiameter);    
                    }
                    
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

module MountHolder (Thick,Hole) {
    
    translate([0,0,0.005]) difference(){  
       
        if (MountHolderStyle==1){
            $fn=40; 
           roundedBox([Caselength, MountHolderLenght*2, Thick*2], Thick/3, 0);
        }
        if (MountHolderStyle==2){
            $fn=60;
           roundedBox([Caselength, MountHolderLenght*2, Thick*2],CaseRoundingRadius , 1);
        }
        if (MountHolderStyle==3){
            roundedBox([Caselength, MountHolderLenght*2, Thick*2],0 , 2);
        }      
        if((MountHolderStyle>0)&&(MountHolderStyle<4)){
            translate([0,0,-Thick/2-0.02]) cube([Caselength+0.02,MountHolderLenght*2+0.02,Thick+0.04],center=true);
            translate([0,-MountHolderLenght/2-CaseRoundingRadius,Thick/2+0.02]) cube([Caselength+0.02,MountHolderLenght+0.02,Thick+0.08],center=true);
            translate([0,-MountHolderLenght/2,Thick/2+0.02]) cube([Caselength-2*CaseRoundingRadius+0.02,MountHolderLenght+0.02,Thick+0.08],center=true);
            translate([0,-CaseRoundingRadius,MountHolderThickness/2-0.02]) translate(ScrewAddYPos) cylinder(h=MountHolderThickness+0.06,d=ScrewHoleDia,center = true);
            mirror([  1,  0,  0]) translate([0,-CaseRoundingRadius,MountHolderThickness/2-0.02]) translate(ScrewAddYPos) cylinder(h=MountHolderThickness+0.06,d=ScrewHoleDia,center = true);

            if (CountOfMountHolderHoles>1){
                translate([Caselength/2-Hole-Thick/3,Hole*1.5,MountHolderThickness/2-0.02]) cylinder(h=MountHolderThickness+0.06,d=Hole,center = true); 
                translate([-Caselength/2+Hole+Thick/3,Hole*1.5,MountHolderThickness/2-0.02]) cylinder(h=MountHolderThickness+0.06,d=Hole,center = true);  
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

        rotate([0,0,180]) translate([0,MountHolderLenght+CaseWidth,0]) difference()
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



//===============================================================================
//              F I B E R   O U T D O O R   C O N N E C T I O N   B O X
//===============================================================================
// Integrated assembly version:
// - only two exterior holes, both 1/2 inch on the narrow bottom end wall
// - removable split-bushing cable clamps are shown installed for fit checking
// - corrected slide-in SC/APC holder with long screw-down keeper
// - internal hinge rail added for a future swing-out splice/winder tray

module FiberBoxBottomAdditions(){
    floor_z = BottomTopThickness;
    inner_x = -Caselength/2 + SideWallThickness;
    cable_center_z = BottomTopThickness + FiberBottomHoleCenterZ;

    // Removable split-bushing clamps shown installed in the two 1/2 inch entry holes.
    // They are intentionally separate shells, not bonded to the case wall.
    if (Fiber_Show_Removable_Clamps_In_Box)
        for (y=[-FiberBottomHoleSpacing/2, FiberBottomHoleSpacing/2])
            translate([inner_x + 0.05, y, cable_center_z])
                FiberSplitCableClampAssembled();

    // Corrected internal SC/APC slide-in connector holder.
    // Connector plug direction is front/back across the box; no exterior SC openings are made.
    translate([SC2_Pos_X, SC2_Pos_Y, floor_z])
        SC2_HolderInstalled();

    // Fixed hinge rail for the future swing-out fiber tray.
    if (Fiber_Add_Internal_Tray_Hinge)
        FiberInternalTrayHingeMount();
}

module FiberBoxBottomCuts(){
    // Only exterior cuts added by this modification: two 1/2 inch cable entry holes.
    for (y=[-FiberBottomHoleSpacing/2, FiberBottomHoleSpacing/2]){
        translate([-Caselength/2 + SideWallThickness/2, y, BottomTopThickness + FiberBottomHoleCenterZ])
            rotate([0,90,0])
                cylinder(h=SideWallThickness+1.2, d=FiberBottomHoleDiameter, center=true);
    }
}

// -------------------------------------------------------------------------------
// Removable split-bushing cable clamp, installed orientation
// X axis = cable direction into the box. Z=0 in this module is the cable centerline.
// -------------------------------------------------------------------------------
Clamp_Bushing_Dia = Clamp_Entry_Hole_Dia - Clamp_Hole_Clearance;
Clamp_Cable_Groove_Dia = Clamp_Cable_Dia - Clamp_Cable_Compression;
Clamp_Bushing_Total_Depth = Clamp_Bushing_Protrusion + Clamp_Bushing_InBox_Depth;
Clamp_Total_Depth = Clamp_Bushing_Total_Depth + Clamp_Depth;

module cyl_x(d, h, center=false) {
    rotate([0,90,0]) cylinder(d=d, h=h, center=center);
}

module FiberClampCableCut(extra=1) {
    translate([-Clamp_Bushing_Protrusion-extra,0,0])
        cyl_x(d=Clamp_Cable_Groove_Dia, h=Clamp_Total_Depth + 2*extra, center=false);
}

module FiberClampBushingHalf(upper=false) {
    intersection() {
        translate([-Clamp_Bushing_Protrusion,0,0])
            cyl_x(d=Clamp_Bushing_Dia, h=Clamp_Bushing_Total_Depth, center=false);
        if (upper)
            translate([-Clamp_Bushing_Protrusion-0.1, -Clamp_Bushing_Dia/2-1, 0])
                cube([Clamp_Bushing_Total_Depth+0.2, Clamp_Bushing_Dia+2, Clamp_Bushing_Dia/2+1], center=false);
        else
            translate([-Clamp_Bushing_Protrusion-0.1, -Clamp_Bushing_Dia/2-1, -Clamp_Bushing_Dia/2-1])
                cube([Clamp_Bushing_Total_Depth+0.2, Clamp_Bushing_Dia+2, Clamp_Bushing_Dia/2+1], center=false);
    }
}

module FiberClampBodyHalf(upper=false) {
    if (upper)
        translate([Clamp_Bushing_InBox_Depth, -Clamp_Width/2, 0])
            cube([Clamp_Depth, Clamp_Width, Clamp_Half_Height], center=false);
    else
        translate([Clamp_Bushing_InBox_Depth, -Clamp_Width/2, -Clamp_Half_Height])
            cube([Clamp_Depth, Clamp_Width, Clamp_Half_Height], center=false);
}

module FiberClampUpperScrewCuts() {
    for (y=[-Clamp_Screw_Y, Clamp_Screw_Y]) {
        translate([Clamp_Bushing_InBox_Depth + Clamp_Screw_X, y, -0.2])
            cylinder(d=Clamp_Screw_Dia, h=Clamp_Half_Height+0.6, center=false);
        translate([Clamp_Bushing_InBox_Depth + Clamp_Screw_X, y, Clamp_Half_Height - Clamp_Screw_Head_Depth])
            cylinder(d=Clamp_Screw_Head_Dia, h=Clamp_Screw_Head_Depth+0.3, center=false);
    }
}

module FiberClampLowerScrewCuts() {
    for (y=[-Clamp_Screw_Y, Clamp_Screw_Y])
        translate([Clamp_Bushing_InBox_Depth + Clamp_Screw_X, y, -Clamp_Half_Height-0.3])
            cylinder(d=Clamp_Lower_Pilot_Dia, h=Clamp_Half_Height+0.6, center=false);
}

module FiberClampLowerAlignmentPins() {
    for (y=[-Clamp_Align_Pin_Y, Clamp_Align_Pin_Y])
        translate([Clamp_Bushing_InBox_Depth + Clamp_Align_Pin_X, y, 0])
            cylinder(d=Clamp_Align_Pin_Dia, h=Clamp_Align_Pin_Height, center=false);
}

module FiberClampUpperAlignmentCuts() {
    for (y=[-Clamp_Align_Pin_Y, Clamp_Align_Pin_Y])
        translate([Clamp_Bushing_InBox_Depth + Clamp_Align_Pin_X, y, -0.2])
            cylinder(d=Clamp_Align_Pin_Dia + Clamp_Align_Pin_Clearance, h=Clamp_Align_Pin_Height+0.6, center=false);
}

module FiberClampLowerHalf() {
    difference() {
        union() {
            FiberClampBushingHalf(false);
            FiberClampBodyHalf(false);
            FiberClampLowerAlignmentPins();
        }
        FiberClampCableCut(1.0);
        FiberClampLowerScrewCuts();
        translate([-Clamp_Bushing_Protrusion-0.5, -Clamp_Width/2-0.5, -0.05])
            cube([Clamp_Total_Depth+1, Clamp_Width+1, 0.10], center=false);
    }
}

module FiberClampUpperHalf() {
    difference() {
        union() {
            FiberClampBushingHalf(true);
            FiberClampBodyHalf(true);
        }
        FiberClampCableCut(1.0);
        FiberClampUpperScrewCuts();
        FiberClampUpperAlignmentCuts();
        translate([-Clamp_Bushing_Protrusion-0.5, -Clamp_Width/2-0.5, -0.05])
            cube([Clamp_Total_Depth+1, Clamp_Width+1, 0.10], center=false);
    }
}

module FiberSplitCableClampAssembled() {
    FiberClampLowerHalf();
    FiberClampUpperHalf();
}

// -------------------------------------------------------------------------------
// Corrected SC/APC slide-in flange holder with long keeper
// -------------------------------------------------------------------------------
SC2_Min_Flange_Ear_W = 0.8;
SC2_Flange_Ear_W_Raw = (SC2_Flange_W - SC2_Body_W) / 2;
SC2_Flange_Ear_W = max(SC2_Flange_Ear_W_Raw, SC2_Min_Flange_Ear_W);
SC2_Slot_Y = SC2_Flange_T + SC2_Clearance;
SC2_Slot_W_X = SC2_Flange_Ear_W + SC2_Clearance;
SC2_Rail_Block_W = SC2_Flange_Ear_W + SC2_Rail_Outer_Wall_X + SC2_Clearance;
SC2_Single_W = SC2_Flange_W + 2*SC2_Rail_Outer_Wall_X + 2*SC2_Clearance;
SC2_Array_W = (SC2_Count-1)*SC2_Holder_Pitch + SC2_Single_W;
SC2_Base_W = SC2_Array_W + 2*SC2_Base_Margin_X + 2*SC2_Base_End_Extra_X;
SC2_Flange_Bottom_Z = SC2_Base_Thickness + SC2_Bottom_Stop_H;
SC2_Flange_Top_Z = SC2_Flange_Bottom_Z + SC2_Flange_H;
SC2_Keeper_Underside_Z = SC2_Flange_Top_Z + SC2_Keeper_Clearance_Z;
SC2_Rail_Top_Z = SC2_Keeper_Underside_Z - SC2_Carrier_Top_Relief_Z;
SC2_Rail_H = SC2_Rail_Top_Z - SC2_Base_Thickness;
SC2_Boss_H = SC2_Keeper_Underside_Z - SC2_Base_Thickness;

module SC2_ScrewPositions() {
    keeper_w_local = SC2_Array_W + 2*SC2_Base_Margin_X + 2*SC2_Keeper_End_Overhang_X;
    left_x = -keeper_w_local/2 + 7.5;
    right_x = keeper_w_local/2 - 7.5;

    for (x=[left_x, right_x]) translate([x,0,0]) children();
    if (SC2_Count > 1)
        for (i=[0:SC2_Count-2]) {
            x_gap = ((i-(SC2_Count-1)/2)*SC2_Holder_Pitch + ((i+1)-(SC2_Count-1)/2)*SC2_Holder_Pitch)/2;
            translate([x_gap,0,0]) children();
        }
}

module SC2_BasePlate() {
    translate([0,0,SC2_Base_Thickness/2])
        roundedBox([SC2_Base_W, SC2_Base_Depth_Y, SC2_Base_Thickness], 1.5, 1);
}

module SC2_BottomEarStop(side=1) {
    ear_center_x = side * (SC2_Body_W/2 + SC2_Flange_Ear_W/2);
    translate([ear_center_x, 0, SC2_Base_Thickness + SC2_Bottom_Stop_H/2])
        cube([SC2_Flange_Ear_W + SC2_Clearance, SC2_Rail_Depth_Y, SC2_Bottom_Stop_H], center=true);
}

module SC2_SideCaptureRail(side=1) {
    ear_center_x = side * (SC2_Body_W/2 + SC2_Flange_Ear_W/2);
    rail_center_x = side * (SC2_Body_W/2 + SC2_Rail_Block_W/2 - SC2_Clearance/2);

    difference() {
        translate([rail_center_x, 0, SC2_Base_Thickness + SC2_Rail_H/2])
            cube([SC2_Rail_Block_W, SC2_Rail_Depth_Y, SC2_Rail_H], center=true);

        translate([ear_center_x, 0, SC2_Flange_Bottom_Z + (SC2_Rail_Top_Z - SC2_Flange_Bottom_Z)/2])
            cube([SC2_Slot_W_X, SC2_Slot_Y, SC2_Rail_Top_Z - SC2_Flange_Bottom_Z + 1.6], center=true);

        translate([side * (SC2_Body_Clear_W/4), 0, SC2_Base_Thickness + SC2_Rail_H/2])
            cube([SC2_Body_Clear_W/2 + SC2_Clearance + 1.0, SC2_Rail_Depth_Y + 1.0, SC2_Rail_H + 1.0], center=true);

        translate([ear_center_x, 0, SC2_Rail_Top_Z - 0.4])
            cube([SC2_Slot_W_X + 0.8, SC2_Slot_Y + 1.0, 1.4], center=true);
    }
}

module SC2_SingleHolder() {
    SC2_BottomEarStop(-1);
    SC2_BottomEarStop(1);
    SC2_SideCaptureRail(-1);
    SC2_SideCaptureRail(1);
}

module SC2_KeeperPlate() {
    keeper_w_local = SC2_Array_W + 2*SC2_Base_Margin_X + 2*SC2_Keeper_End_Overhang_X;
    difference() {
        roundedBox([keeper_w_local, SC2_Keeper_Depth_Y, SC2_Keeper_Thickness], 1.0, 1);
        SC2_ScrewPositions() {
            translate([0, 0, -SC2_Keeper_Thickness/2-0.1])
                cylinder(d=SC2_Keeper_Screw_Dia, h=SC2_Keeper_Thickness+0.3);
            translate([0, 0, SC2_Keeper_Thickness/2-SC2_Keeper_Head_Depth])
                cylinder(d=SC2_Keeper_Head_Dia, h=SC2_Keeper_Head_Depth+0.2);
        }
        for (i=[0:SC2_Count-1]) {
            x0 = (i-(SC2_Count-1)/2)*SC2_Holder_Pitch;
            translate([x0, 0, -SC2_Keeper_Thickness/2 + 0.45])
                cube([SC2_Body_Clear_W + 0.8, SC2_Keeper_Depth_Y+0.4, 1.0], center=true);
        }
    }
}

module SC2_ScrewBosses() {
    SC2_ScrewPositions()
        translate([0,0,SC2_Base_Thickness + SC2_Boss_H/2])
            difference() {
                cylinder(d=SC2_Screw_Boss_Dia, h=SC2_Boss_H, center=true);
                translate([0,0,-SC2_Boss_H/2-0.1])
                    cylinder(d=SC2_Screw_Pilot_Dia, h=SC2_Boss_H+0.4);
            }
}

module SC2_HolderInstalled() {
    SC2_BasePlate();
    for (i=[0:SC2_Count-1])
        translate([(i-(SC2_Count-1)/2)*SC2_Holder_Pitch, 0, 0])
            SC2_SingleHolder();
    SC2_ScrewBosses();
    translate([0,0,SC2_Keeper_Underside_Z + SC2_Keeper_Thickness/2])
        SC2_KeeperPlate();
}

// -------------------------------------------------------------------------------
// Future tray hinge mount
// -------------------------------------------------------------------------------
module FiberInternalTrayHingeMount(){
    y = CaseWidth/2 - SideWallThickness - Tray_Hinge_Y_Offset;
    z = BottomTopThickness + Tray_Hinge_Z;

    for (x=[-Tray_Hinge_X_Spacing, 0, Tray_Hinge_X_Spacing]){
        // Back-wall support web down to the floor.
        translate([x, y + Tray_Hinge_Barrel_OD/2 - 1.5, BottomTopThickness + Tray_Hinge_Z/2])
            roundedBox([Tray_Hinge_Barrel_L, 3.0, Tray_Hinge_Z], 0.8, 1);

        // Hinge barrel with horizontal pin hole along X.
        translate([x, y, z])
            rotate([0,90,0])
                difference(){
                    cylinder(d=Tray_Hinge_Barrel_OD, h=Tray_Hinge_Barrel_L, center=true);
                    cylinder(d=Tray_Hinge_Pin_Dia, h=Tray_Hinge_Barrel_L+0.8, center=true);
                }
    }
}
