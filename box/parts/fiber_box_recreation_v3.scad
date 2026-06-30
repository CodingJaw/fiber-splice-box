/*
  Fiber box recreation v3
  Rebuilt to match the supplied top-view reference orientation:
  - lid/cover on LEFT
  - loose clamp/hinge blocks in CENTER
  - open box body on RIGHT
  - SC connector holder protrudes from FRONT/BOTTOM of body

  Units: mm.  This is still a visual/parametric recreation until exact dimensions are supplied.
*/

$fn = 48;

PART = "assembly"; // assembly, lid, body, loose, printable_lid, printable_body
EXPLODED = true;
SHOW_CAVITY_COLOR = true;

// -------------------- dimensions --------------------
wall = 4;
corner_r = 8;

lid_L = 132;
lid_W = 70;
lid_T = 5;

body_L = 132;
body_W = 72;
body_H = 28;
body_floor = 4;

rim_w = 2.2;
rim_h = 1.6;

hole_d = 2.8;
head_d = 5.4;

// assembly placement
lid_x  = -92;
body_x =  92;
part_gap_x = 0;

// -------------------- helpers --------------------
module rounded_rect_2d(L,W,R){
    hull(){
        translate([ L/2-R,  W/2-R]) circle(r=R);
        translate([-L/2+R,  W/2-R]) circle(r=R);
        translate([ L/2-R, -W/2+R]) circle(r=R);
        translate([-L/2+R, -W/2+R]) circle(r=R);
    }
}

module rounded_box(L,W,H,R){
    linear_extrude(height=H)
        rounded_rect_2d(L,W,R);
}

module screw_hole_stack(z0=-1, h=50){
    cylinder(d=hole_d, h=h, center=false);
    translate([0,0,3]) cylinder(d=head_d, h=h, center=false);
}

module obround_hole(L,D,H=20){
    hull(){
        translate([-L/2+D/2,0,0]) cylinder(d=D,h=H,center=true);
        translate([ L/2-D/2,0,0]) cylinder(d=D,h=H,center=true);
    }
}

module screw_pattern(L,W,z=-1,h=20){
    positions = [
        [-L/2+9, -W/2+8], [ L/2-9, -W/2+8],
        [-L/2+9,  W/2-8], [ L/2-9,  W/2-8],
        [-20, -W/2+8], [20, -W/2+8],
        [-20,  W/2-8], [20,  W/2-8]
    ];
    for(p=positions) translate([p[0],p[1],z]) cylinder(d=hole_d,h=h);
}

module shallow_groove_frame(L,W,z=0.2){
    // visible thin rectangular recessed/double-line groove on lid/body top
    translate([0,0,z]) difference(){
        linear_extrude(0.35) rounded_rect_2d(L,W,4);
        translate([0,0,-0.1]) linear_extrude(1) rounded_rect_2d(L-4,W-4,3);
    }
}

module raised_frame(L,W,z=0){
    translate([0,0,z]) difference(){
        rounded_box(L,W,rim_h,4);
        translate([0,0,-0.1]) rounded_box(L-2*rim_w,W-2*rim_w,rim_h+0.3,3);
    }
}

// -------------------- lid --------------------
module cable_cutout_negative(x){
    // front edge is negative Y.  This makes the squared-in notch plus rounded rear.
    translate([x,-lid_W/2+2,-1]) cube([15,16,lid_T+4],center=true);
    translate([x,-lid_W/2+10,-1]) cylinder(d=15,h=lid_T+4,center=true);
}

module lid_guide_pair(x){
    // raised U-looking cable guides at front edge of lid
    guide_h = 14;
    guide_w = 5;
    guide_z = lid_T;
    translate([x-9,-lid_W/2+9,guide_z]) rounded_box(4,18,guide_h,1.8);
    translate([x+9,-lid_W/2+9,guide_z]) rounded_box(4,18,guide_h,1.8);
    translate([x,-lid_W/2+18,guide_z]) rounded_box(19,4,guide_h,1.8);
}

module lid_piece(){
    difference(){
        union(){
            rounded_box(lid_L,lid_W,lid_T,corner_r);
            // thin raised inner detail and front inner rail
            translate([0,0,lid_T]) shallow_groove_frame(lid_L-16,lid_W-14,0);
            translate([0,-lid_W/2+12,lid_T]) cube([lid_L-28,2.2,1.4],center=true);
            translate([0,lid_W/2-12,lid_T]) cube([lid_L-28,2.2,1.4],center=true);
            lid_guide_pair(-33);
            lid_guide_pair(33);
        }
        screw_pattern(lid_L,lid_W,-1,lid_T+20);
        // corner/edge holes visible on original lid
        for(x=[-lid_L/2+10,lid_L/2-10])
            for(y=[-lid_W/2+8,lid_W/2-8])
                translate([x,y,-1]) cylinder(d=head_d,h=2.2);
        cable_cutout_negative(-33);
        cable_cutout_negative(33);
    }
}

// -------------------- body --------------------
module inner_cavity_negative(){
    translate([0,0,body_floor]) rounded_box(body_L-2*wall,body_W-2*wall,body_H+3,corner_r-wall);
}

module internal_post(x,y,w=9,d=7,h=6){
    translate([x,y,body_floor]) rounded_box(w,d,h,1.6);
}

module standoff(x,y){
    translate([x,y,body_floor]) difference(){
        rounded_box(9,8,5,2);
        translate([0,0,-1]) cylinder(d=2.5,h=8);
    }
}

module side_mount_tab(x,y,rot=0){
    translate([x,y,2]) rotate([0,0,rot]) difference(){
        rounded_box(18,13,7,3);
        translate([0,0,-1]) obround_hole(7,4,12);
    }
}

module sc_holder(){
    // protruding connector clamp/SC holder at front of main body
    y0 = -body_W/2 - 13;
    translate([0,y0,0]) difference(){
        union(){
            rounded_box(68,20,10,3);
            translate([0,7,8]) rounded_box(56,8,15,2);       // rear raised wall
            translate([-36,6,0]) rounded_box(8,18,18,3);      // side pillar
            translate([36,6,0]) rounded_box(8,18,18,3);       // side pillar
            translate([-25,15,0]) rounded_box(8,12,8,2);      // small side foot
            translate([25,15,0]) rounded_box(8,12,8,2);
        }
        // large round front screw/relief hole
        translate([0,-2,-1]) cylinder(d=12,h=15);
        // rectangular slots in front base
        for(x=[-24,-12,12,24])
            translate([x,-6,-1]) cube([5,10,14],center=false);
        // small top screw hole
        translate([0,7,14]) cylinder(d=hole_d,h=10,center=true);
        // vertical windows on raised face
        for(x=[-22,-11,11,22])
            translate([x,2,11]) cube([4,14,8],center=true);
    }
}

module front_inner_brackets(){
    translate([-48,-body_W/2+8,body_floor]) rotate([0,0,-18]) rounded_box(6,18,14,1.5);
    translate([48,-body_W/2+8,body_floor]) rotate([0,0,18]) rounded_box(6,18,14,1.5);
    translate([0,-body_W/2+17,body_floor]) rounded_box(42,5,9,1.5);
    translate([0,-body_W/2+23,body_floor]) rounded_box(46,3,6,1.2);
}

module body_piece(){
    difference(){
        union(){
            rounded_box(body_L,body_W,body_H,corner_r);
            // external tabs as in screenshot
            side_mount_tab(-body_L/2-9, -6, 0);
            side_mount_tab(-body_L/2-9,  20, 0);
            side_mount_tab( body_L/2+9, -6, 0);
            side_mount_tab( body_L/2+9,  20, 0);
            sc_holder();
        }
        inner_cavity_negative();
        screw_pattern(body_L,body_W,body_H-2,8);
        // little side cable/window cutout on right interior wall
        translate([body_L/2-2,10,14]) cube([8,28,9],center=true);
    }

    // top rim/gasket ledges
    raised_frame(body_L-10,body_W-10,body_H);
    raised_frame(body_L-22,body_W-22,body_H+1.7);

    // internal blocks/standoffs matching visible top view positions
    internal_post(-42, 18,9,7,6);
    internal_post(-18, -4,9,7,6);
    internal_post( 12,  8,9,7,6);
    internal_post( 42, 18,9,7,6);
    internal_post( 38,-12,9,7,6);
    standoff(-52,-20);
    standoff( 52,-20);
    front_inner_brackets();
    // upright small tab in middle/right of cavity
    translate([26,1,body_floor]) rotate([0,0,10]) difference(){
        rounded_box(9,15,15,1.5);
        translate([0,-3,7]) rotate([90,0,0]) cylinder(d=3,h=20,center=true);
    }
}

// -------------------- loose center parts --------------------
module loose_tab(){
    difference(){
        rounded_box(17,12,7,3);
        translate([0,0,-1]) obround_hole(7,4,12);
    }
}

module loose_long_clamp(){
    difference(){
        union(){
            rounded_box(18,46,8,3);
            translate([0,-19,8]) rounded_box(20,7,7,3);
            translate([0, 19,8]) rounded_box(20,7,7,3);
        }
        for(y=[-14,14]) translate([0,y,-1]) cylinder(d=hole_d,h=20);
    }
}

module loose_parts(){
    translate([0,22,0]) loose_tab();
    translate([0,-22,0]) loose_tab();
    translate([18,-8,0]) loose_long_clamp();
    translate([42,18,0]) loose_tab();
    translate([42,-22,0]) loose_tab();
}

// -------------------- assembly / exports --------------------
module assembly(){
    color("gold") translate([lid_x,0,0]) lid_piece();
    color("yellowgreen") translate([body_x,0,0]) body_piece();
    color("gold") loose_parts();
}

if(PART=="assembly") assembly();
if(PART=="lid") lid_piece();
if(PART=="body") body_piece();
if(PART=="loose") loose_parts();
if(PART=="printable_lid") rotate([180,0,0]) lid_piece();
if(PART=="printable_body") body_piece();
