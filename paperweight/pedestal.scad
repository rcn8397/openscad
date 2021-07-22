///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: Name
   Preamble and description

*/

/*
Parameters
*/
// Finish
$fn = 90;

// Pedestal Radius
ped_r = 25; // [0:1:100]
// Pedestal Height
ped_min_h = 2; // [0:1:100]
// Thickness
thickness = 1.0; // [0:0.1:20]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
cr2032_h   = 3.12; // [0:1:100]
cr2032_r   = 10.00;// [0:1:100]
led_lamp_h = 2.0;  // [0:0.1:10]
led_lamp_d = 3.00; // [0:0.1:4 ]
led_rim_d  = 3.25; // [0:0.1:4 ]
led_rim_h  = 1.0; // [0:0.1:4 ]
led_h = led_lamp_h + led_rim_h + led_lamp_d/2;
ped_h    = ped_min_h + cr2032_r+thickness;

///< Modules
module pedestal( r = ped_r, h = ped_h, t = thickness ){
    union(){
        difference(){
            cylinder( h=h, r=r );
            translate([0,0,thickness])
                color("red")
                cylinder( h=h, r=r-t);
        }
    cylinder( h=led_h-thickness, r = t+led_rim_d/2.0 );
    }
}

module led(){
    translate([0,0,led_rim_h+led_lamp_h])
        color("white")
        sphere( r = led_lamp_d/2.0 );
    translate([0,0,led_rim_h])
        color("white")
        cylinder( h = led_lamp_h, r = led_lamp_d/2.0 );
    color("white")
    cylinder( h = led_rim_h, r = led_rim_d/2.0 );
}

///< Build object
difference(){
pedestal();
translate([0,0,led_h-thickness])
rotate([180,0,0])
#led();
}
