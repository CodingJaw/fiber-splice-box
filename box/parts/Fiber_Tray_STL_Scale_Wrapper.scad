/*
Fiber tray STL scale wrapper
- Imports Tray.stl and scales it to fit inside the fiber connection box.
- Put this .scad file in the same folder as Tray.stl, or update Tray_File.
- Default target is based on the 120 x 100 mm outdoor box with clearance around the tray.
*/

$fn = 64;

/* [Source STL measured bounds] */
Tray_File = "Tray.stl";
Original_X = 103.3;
Original_Y = 86.1;
Original_Z = 8.0;
Original_Min_X = 0.3;
Original_Min_Y = -96.4;
Original_Min_Z = 28.4;

/* [Target fit] */
Target_X = 100.0;     // maximum tray length inside box
Target_Y = 82.0;      // maximum tray width inside box
Keep_XY_Uniform = true;
Scale_Z_With_XY = true;
Manual_Scale_X = 1.0;
Manual_Scale_Y = 1.0;
Manual_Scale_Z = 1.0;
Center_On_Origin = true;

/* [Preview] */
Show_Target_Footprint = true;
Footprint_Thickness = 0.4;

xy_scale = min(Target_X / Original_X, Target_Y / Original_Y);
SX = Keep_XY_Uniform ? xy_scale : (Target_X / Original_X);
SY = Keep_XY_Uniform ? xy_scale : (Target_Y / Original_Y);
SZ = Scale_Z_With_XY ? xy_scale : 1;

Final_X = Original_X * SX * Manual_Scale_X;
Final_Y = Original_Y * SY * Manual_Scale_Y;
Final_Z = Original_Z * SZ * Manual_Scale_Z;

module scaled_reference_tray() {
    translate(Center_On_Origin ? [-Final_X/2, -Final_Y/2, 0] : [0,0,0])
        scale([SX * Manual_Scale_X, SY * Manual_Scale_Y, SZ * Manual_Scale_Z])
            translate([-Original_Min_X, -Original_Min_Y, -Original_Min_Z])
                import(Tray_File, convexity=10);
}

if (Show_Target_Footprint) {
    color([0.8,0.8,0.8,0.25])
        translate([-Target_X/2, -Target_Y/2, -Footprint_Thickness])
            cube([Target_X, Target_Y, Footprint_Thickness]);
}

scaled_reference_tray();

echo(str("Tray final X: ", Final_X, " mm"));
echo(str("Tray final Y: ", Final_Y, " mm"));
echo(str("Tray final Z: ", Final_Z, " mm"));
echo(str("Uniform XY scale: ", xy_scale));
