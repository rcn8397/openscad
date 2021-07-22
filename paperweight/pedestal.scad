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
ped_min_h = 0; // [0:1:100]
// Thickness
thickness = 1.0; // [0:0.1:20]
// Leads radiu
leads_r   = 0.5; // [0:0.1:5]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
cr2032_h    = 3.12; // [0:1:100]
cr2032_r    = 10.00;// [0:1:100]
cr2032_d    = cr2032_r * 2;
led_lamp_h  = 2.0;  // [0:0.1:10]
led_lamp_d  = 3.00; // [0:0.1:4 ]
led_rim_d   = 3.25; // [0:0.1:4 ]
led_rim_h   = 1.0;  // [0:0.1:4 ]
led_h       = led_lamp_h + led_rim_h + led_lamp_d/2;
ped_h       = ped_min_h + cr2032_r*2+thickness;
spdt_body_w = 6.75; // [0:0.1:15]
spdt_body_d = 6.5;  // [0:0.1:15]
spdt_body_h = 12.75;// [0:0.1:15]
spdt_sw_w   = 5.3;  // [0:0.1:15]
spdt_sw_d   = 3.88; // [0:0.1:15]
spdt_sw_h   = 3.89; // [0:0.1:15]

///< Modules

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

module terminal_pair(){
    cylinder( h = thickness*2+cr2032_h, r = leads_r );
    translate( [cr2032_r/2,0,0] )
        cylinder( h = thickness*2+cr2032_h, r = leads_r );
}

module cr2032_half( center = true ){
       difference(){
        linear_extrude( height = cr2032_d ){
            square( [ thickness, cr2032_d ], center );
            translate([-thickness, thickness, 0 ] )
                square( [thickness*2, thickness ], center );
            translate([-thickness, -thickness, 0 ] )
                square( [thickness*2, thickness ], center );
        }
        translate([-cr2032_h-thickness,-cr2032_r/4,cr2032_d*2/3])
        rotate([90,0,90])
            terminal_pair();
    }
}

module cr2032_holder( center = true){
    cr2032_half(center);
    translate([cr2032_h-0.1,0,0])
    mirror([1,0,0])
        cr2032_half(center);
}

module spdt_switch(){
    color("silver")
        cube( [spdt_body_w, spdt_body_d+thickness+5, spdt_body_h] );
    translate([1.3,-spdt_sw_w,3.29])
        color("black")
        cube( [spdt_sw_d,spdt_sw_w, spdt_sw_h ]);
    translate([1.3,-spdt_sw_w,6.6])
        color("cyan")
        cube( [spdt_sw_d,spdt_sw_w, spdt_sw_h ]);

}

module pedestal( r = ped_r, h = ped_h, t = thickness ){
    difference(){
        //union(){
        union(){
            difference(){
                union(){
                    difference(){
                        cylinder( h=h, r=r );
                        translate([0,0,thickness])
                            color("red")
                            cylinder( h=h, r=r-t);
                    }
                    cylinder( h=led_h-thickness, r = t+led_rim_d/2.0 );
                }
                translate([0,0,led_h-thickness])
                    rotate([180,0,0])
                    led();
            }
            translate([ped_r/3,0, thickness-0.1])
                cr2032_holder();
            translate([-ped_r+thickness,
                   -thickness/2-spdt_body_h/2,
                   ped_h/2])
            cube( [spdt_body_w+thickness,
                   spdt_body_h+thickness,
                   spdt_body_d+thickness ] );
        }
        translate([-ped_r+thickness,-spdt_body_h/2, ped_h/2+thickness/2])
            rotate([0,-90,-90])
            spdt_switch();
    }

}

///< Build object
pedestal();

