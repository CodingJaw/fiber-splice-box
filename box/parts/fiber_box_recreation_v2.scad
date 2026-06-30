/*
  fiber_box_recreation_v2.scad
  OpenSCAD visual/printable starting model based on the supplied Tinkercad screenshots.

  Units: mm
  Target: closer to the drawing layout, not a finished dimensioned production file.

  Change PART to export individual STLs:
    "assembly"   = body + lid + loose blocks laid out like the screenshot
    "body"       = main enclosure body only
    "lid"        = flat cover only
    "loose"      = loose clamp/hinge blocks only
*/

$fn = 64;
PART = "assembly";      // "assembly", "body", "lid", "loose"

// ---------------- main scale ----------------
body_L = 150;
body_W = 78;
body_H = 27;
wall   = 5;
floor  = 3;
R      = 8;

lid_L  = 150;
lid_W  = 78;
lid_T  = 4.2;

// front connector section
front_plate_W = 74;
front_plate_D = 19;
front_plate_H = 6;
front_block_W = 55;
front_block_D = 13;
front_block_H = 17;

screw_d = 3.0;
head_d  = 6.2;

// assembly spacing
GAP = 31;

// ---------------- utility geometry ----------------
module rr2(l,w,r){
    offset(r=r) square([l-2*r,w-2*r], center=true);
}

module rbox(l,w,h,r){
    linear_extrude(height=h) rr2(l,w,r);
}

module slot2d(l,w){
    hull(){
        translate([-l/2+w/2,0]) circle(d=w);
        translate([ l/2-w/2,0]) circle(d=w);
    }
}

module vhole(d,h=80){ cylinder(d=d,h=h,center=true); }

module screw_pattern(l,w){
    // 10 perimeter holes: corners, side middles, and long-side centers like the screenshot.
    pts = [
        [-l/2+9, -w/2+8], [ l/2-9, -w/2+8],
        [-l/2+9,  w/2-8], [ l/2-9,  w/2-8],
        [-l/2+48,-w/2+8], [0,-w/2+8], [l/2-48,-w/2+8],
        [-l/2+48, w/2-8], [0, w/2-8], [l/2-48, w/2-8]
    ];
    for(p=pts) translate([p[0],p[1],0]) children();
}

module ring(l,w,thick,h,r){
    difference(){
        rbox(l,w,h,r);
        translate([0,0,-.05]) rbox(l-2*thick,w-2*thick,h+.1,max(r-thick,1));
    }
}

module small_rect_post(x,y,l=11,w=6,h=6){
    translate([x,y,floor]) rbox(l,w,h,1.4);
}

module screw_boss(x,y,d=9,h=9){
    translate([x,y,floor])
    difference(){
        cylinder(d=d,h=h);
        translate([0,0,h/2]) vhole(screw_d,h+2);
    }
}

module slotted_loose_block(l=16,w=12,h=7,slot_l=8,slot_w=4){
    difference(){
        rbox(l,w,h,2.3);
        translate([0,0,h/2]) linear_extrude(height=h+2,center=true) slot2d(slot_l,slot_w);
    }
}

// ---------------- body ----------------
module body_main_shell(){
    difference(){
        union(){
            // main outer shell
            rbox(body_L,body_W,body_H,R);

            // raised flat rim land on top
            translate([0,0,body_H]) ring(body_L-7, body_W-7, 5.0, 2.0, R-2);

            // narrow gasket/inner rail visible inside rim
            translate([0,0,body_H+2.0]) ring(body_L-18, body_W-18, 1.5, 1.2, R-5);
        }

        // hollow internal cavity, leaving floor and thick wall
        translate([0,0,floor]) rbox(body_L-2*wall, body_W-2*wall, body_H+8, R-wall);

        // front wall large mouth for connector bay
        translate([0,-body_W/2,13]) cube([61,18,22],center=true);

        // right-side long rounded slot in wall
        translate([body_L/2-1.5,12,16]) rotate([90,0,90]) linear_extrude(height=8,center=true) slot2d(28,6);

        // screw holes through rim/body
        screw_pattern(body_L,body_W){
            translate([0,0,body_H/2]) vhole(screw_d,body_H+12);
            translate([0,0,body_H+2.15]) cylinder(d=head_d,h=1.4,center=true);
        }
    }
}

module body_inside_features(){
    // Rectangular internal pads/posts on the floor, matched to visible layout.
    small_rect_post(-52, 22, 10, 6, 5);
    small_rect_post( 54, 20, 10, 6, 5);
    small_rect_post(-54,-14, 10, 6, 5);
    small_rect_post( 49,-18, 10, 6, 5);
    small_rect_post(  0,-27, 11, 6, 5);
    small_rect_post(-15,  2, 11, 6, 5);

    // small angled standing clip in the center/right of cavity
    translate([27,-2,floor])
    difference(){
        union(){
            rbox(13,8,12,1.5);
            translate([0,0,10]) rotate([0,-18,0]) rbox(13,3.2,12,0.8);
        }
        translate([0,-5,8]) rotate([90,0,0]) cylinder(d=3.2,h=12,center=true);
    }

    // front internal triangular braces beside the front bay opening
    translate([-38,-body_W/2+5,floor]) rotate([0,0,0]) linear_extrude(height=14)
        polygon([[0,0],[8,0],[8,18]]);
    translate([ 38,-body_W/2+5,floor]) mirror([1,0,0]) linear_extrude(height=14)
        polygon([[0,0],[8,0],[8,18]]);
}

module front_connector_bay(){
    y0 = -body_W/2 - front_plate_D/2 + 1;
    difference(){
        union(){
            // lower shelf sticking out from box front
            translate([0,y0,0]) rbox(front_plate_W,front_plate_D,front_plate_H,3);

            // taller SC-connector holder block
            translate([0,y0+3,front_plate_H]) rbox(front_block_W,front_block_D,front_block_H,2);

            // side rounded guide cheeks/ears
            translate([-front_block_W/2-9,y0+1,front_plate_H/2]) rbox(10,front_plate_D,10,2.5);
            translate([ front_block_W/2+9,y0+1,front_plate_H/2]) rbox(10,front_plate_D,10,2.5);

            // small top cap/ledge on holder
            translate([0,y0+3,front_plate_H+front_block_H]) rbox(front_block_W+6,7,3,1.5);
        }

        // large round front/shelf hole
        translate([0,y0-4,front_plate_H/2]) rotate([90,0,0]) cylinder(d=10,h=front_plate_D+4,center=true);

        // rectangular slots on front holder face
        for(x=[-22,-12,12,22])
            translate([x,y0-4,front_plate_H+6]) cube([3.0,9,11],center=true);

        // two rectangular shelf cutouts
        for(x=[-24,24])
            translate([x,y0-5,front_plate_H/2]) cube([8,10,front_plate_H+2],center=true);

        // small screw hole on top face of block
        translate([0,y0+3,front_plate_H+front_block_H+1.6]) vhole(3.0,8);
    }
}

module outside_tabs_body(){
    // small loose-looking side mounting tabs attached near the body side/front as visible in reference
    translate([-54,-body_W/2-13,0]) slotted_loose_block(17,13,7,9,4);
    translate([ 54,-body_W/2-13,0]) slotted_loose_block(17,13,7,9,4);

    // rear/side small body tabs on the left side of body, as in screenshot between parts
    translate([-body_L/2-9,-12,0]) slotted_loose_block(13,17,7,8,4);
    translate([-body_L/2-9, 22,0]) slotted_loose_block(13,17,7,8,4);
}

module body_complete(){
    body_main_shell();
    body_inside_features();
    front_connector_bay();
    outside_tabs_body();
}

// ---------------- lid ----------------
module lid_cable_cut_pair(){
    // two U/semicircular cable reliefs at the front edge of lid
    for(x=[-35,35]){
        translate([x,-lid_W/2,lid_T/2]) rotate([90,0,0]) cylinder(d=17,h=20,center=true);
        translate([x,-lid_W/2+1,lid_T/2]) cube([17,15,lid_T+2],center=true);
    }
}

module u_tower(x){
    // rounded U shaped raised blocks flanking the semicircular cable cutouts
    translate([x,-lid_W/2+8,lid_T])
    difference(){
        rbox(15,13,15,2);
        translate([0,-4,8]) rotate([90,0,0]) cylinder(d=10,h=18,center=true);
        translate([0,-8,8]) cube([14,15,18],center=true);
    }
}

module lid_complete(){
    difference(){
        union(){
            rbox(lid_L,lid_W,lid_T,R);
            // raised rectangular rim/gasket detail on lid face
            translate([0,0,lid_T]) ring(lid_L-18,lid_W-17,1.2,1.2,R-5);
            translate([0,0,lid_T+1.2]) ring(lid_L-25,lid_W-24,1.0,0.8,R-7);
        }

        screw_pattern(lid_L,lid_W){
            translate([0,0,lid_T/2]) vhole(screw_d,lid_T+8);
            translate([0,0,lid_T+.2]) cylinder(d=head_d,h=1.2,center=true);
        }

        lid_cable_cut_pair();
    }

    u_tower(-35);
    u_tower(35);
}

// ---------------- loose parts between lid/body ----------------
module loose_parts(){
    // long center hinge/clamp block
    translate([0,0,0])
    difference(){
        union(){
            rbox(20,46,8,3);
            translate([0,-18,8]) rbox(22,10,5,2.3);
            translate([0, 18,8]) rbox(22,10,5,2.3);
        }
        translate([0,-14,4]) vhole(3.2,14);
        translate([0, 14,4]) vhole(3.2,14);
    }

    translate([-36,-30,0]) slotted_loose_block(17,13,7,9,4);
    translate([-36, 32,0]) slotted_loose_block(17,13,7,9,4);
    translate([ 36,-30,0]) slotted_loose_block(17,13,7,9,4);
    translate([ 36, 32,0]) slotted_loose_block(17,13,7,9,4);
}

// ---------------- layout ----------------
module assembly(){
    translate([ lid_L/2 + GAP/2, 0, 0]) body_complete();
    translate([-body_L/2 - GAP/2,0, 0]) lid_complete();
    translate([0,0,0]) loose_parts();
}

if(PART == "body") body_complete();
else if(PART == "lid") lid_complete();
else if(PART == "loose") loose_parts();
else assembly();
