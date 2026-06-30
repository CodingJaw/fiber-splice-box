/*
Standalone SC Connector Holder Test Piece
- Prints only the internal SC connector holder/rack.
- No enclosure, no cable holes, no lid.
- Two simplex SC coupler openings face front/back through the vertical rack.
- Adjust SC_Cutout_* values if your couplers fit too tight or too loose.
*/

$fn = 60;

/* [SC connector holder test settings] */
SC_Count                 = 2;
SC_Holder_Spacing        = 18;     // center-to-center spacing between SC couplers
SC_Cutout_Width          = 10.5;   // SC coupler body width, side-to-side
SC_Cutout_Height         = 8.0;    // SC coupler body height through bracket
SC_Cutout_Length         = 30.0;   // visual/test clearance length front-to-back
SC_Holder_Base_Height    = 5.0;    // raised base height
SC_Holder_Block_Height   = 17.0;   // vertical bracket height above base
SC_Holder_Block_Thickness= 7.0;    // front/back thickness of retaining bracket
SC_Holder_ScrewDiameter  = 3.0;    // optional base screw holes
SC_Clearance             = 0.30;   // extra clearance added to cutout width/height
Show_Test_Coupler_Ghosts = true;   // translucent reference blocks, not for export

// Derived values
holder_length = max(55, (SC_Count-1)*SC_Holder_Spacing + SC_Cutout_Width + 24);
base_width    = 34;
base_height   = SC_Holder_Base_Height;
block_height  = SC_Holder_Block_Height;
block_thick   = SC_Holder_Block_Thickness;
cut_z         = base_height + 9.5;

SCInternalElevatedHolder();

if (Show_Test_Coupler_Ghosts) {
    color([0,0,1,0.25])
    for (i=[0:SC_Count-1]) {
        x = (i - (SC_Count-1)/2) * SC_Holder_Spacing;
        translate([x, 0, cut_z])
            cube([SC_Cutout_Width, SC_Cutout_Length, SC_Cutout_Height], center=true);
    }
}

module SCInternalElevatedHolder(){
    union(){
        // Raised base platform.
        translate([0,0,base_height/2])
            roundedBox([holder_length, base_width, base_height], 2, true);

        // Vertical retaining bracket. SC adapters pass through front/back along Y.
        translate([0,0,base_height + block_height/2])
            difference(){
                roundedBox([holder_length, block_thick, block_height], 1.5, true);

                for (i=[0:SC_Count-1]) {
                    x = (i - (SC_Count-1)/2) * SC_Holder_Spacing;

                    // Main SC adapter body pass-through.
                    translate([x,0,cut_z - (base_height + block_height/2)])
                        cube([SC_Cutout_Width + SC_Clearance,
                              block_thick + 1.4,
                              SC_Cutout_Height + SC_Clearance], center=true);

                    // Top latch relief for common SC simplex couplers.
                    translate([x,0,cut_z - (base_height + block_height/2) + SC_Cutout_Height/2 + 1.1])
                        cube([SC_Cutout_Width + 1.6 + SC_Clearance,
                              block_thick + 1.6,
                              2.2], center=true);
                }
            }

        // Keeper lips on both faces to reduce rocking.
        for (y=[-block_thick/2-1.0, block_thick/2+1.0]){
            translate([0,y,base_height + block_height/2])
                difference(){
                    roundedBox([holder_length, 2.0, block_height], 0.8, true);
                    for (i=[0:SC_Count-1]) {
                        x = (i - (SC_Count-1)/2) * SC_Holder_Spacing;
                        translate([x,0,cut_z - (base_height + block_height/2)])
                            cube([SC_Cutout_Width + 2.4 + SC_Clearance,
                                  2.6,
                                  SC_Cutout_Height + 2.8 + SC_Clearance], center=true);
                    }
                }
        }

        // Optional screw pads in the base for future clamp bar testing.
        for (x=[-holder_length/2+8, holder_length/2-8]){
            translate([x, base_width/2-7, base_height])
                difference(){
                    cylinder(h=5, d=8, center=false);
                    translate([0,0,-0.1])
                        cylinder(h=5.3, d=SC_Holder_ScrewDiameter, center=false);
                }
        }
    }
}

module roundedBox(size=[10,10,10], radius=1, center=true) {
    // Simple rounded rectangular solid using hull of corner cylinders.
    x = size[0];
    y = size[1];
    z = size[2];
    translate(center ? [0,0,0] : [x/2,y/2,z/2])
        hull() {
            for (ix=[-1,1], iy=[-1,1])
                translate([ix*(x/2-radius), iy*(y/2-radius), 0])
                    cylinder(h=z, r=radius, center=true);
        }
}
