///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;

/*
Module: Paperweight Pedestal
 Simple pedestal with led, powered by a CR2032 battery and controlled by a spdt switch
*/

/*
Parameters
*/
// Finish
$fn = 90;

// Pedestal Radius
ped_r       = 25;  // [0:1:100]
// Pedestal Height
ped_min_h   = 0;   // [0:1:100]
// Thickness
thickness   = 1.0; // [0:0.1:20]
// Leads radiu
leads_r     = 0.75; // [0:0.01:5]
// Print Retainer
print_led_retainer = true;
// Print Pedestal
print_pedestal = true;

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
cr2032_h        = 3.12; // [0:1:100]
cr2032_r        = 10.00;// [0:1:100]
cr2032_d        = cr2032_r * 2;
led_lamp_h      = 2.0;  // [0:0.1:10]
led_lamp_d      = 4.0;  // [0:0.1:4 ]
led_rim_d       = 4.25; // [0:0.1:4 ]
led_rim_h       = 1.0;  // [0:0.1:4 ]
led_h           = led_lamp_h + led_rim_h + led_lamp_d/2;
ped_h           = ped_min_h + cr2032_r*2+thickness;
spdt_retainer_w = 7  + thickness;
spdt_retainer_h = 13.5 + thickness;
spdt_body_w = 7.5; // [0:0.1:15]
spdt_body_d = 7.0; // [0:0.1:15]
spdt_body_h = 13.5;// [0:0.1:15]
spdt_sw_w   = 6.0; // [0:0.1:15]
spdt_sw_d   = 4.0; // [0:0.1:15]
spdt_sw_h   = 4.0; // [0:0.1:15]



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

module led_retainer(){
    module led_lead_hole(){
        translate([-thickness,thickness,0])
            cube([thickness*2,thickness*2, thickness]);
    }

    difference(){
        color("orange")
            cylinder( h=led_h, r = thickness*2+led_rim_d/2.0+0.5 );
        translate( [0,0,thickness] )
            color("pink")
            cylinder( h=led_h, r = thickness+led_rim_d/2.0+0.15 );
        led_lead_hole();
        mirror([0,1,0])
            led_lead_hole();
    }
}


module terminal_pair(){
    translate( [-cr2032_r*1/4,0,0] )
        cylinder( h = thickness*2+cr2032_h, r = leads_r );
    translate( [cr2032_r*3/4,0,0] )
        cylinder( h = thickness*2+cr2032_h, r = leads_r );
}

module cr2032_clip(){
       translate([0,-cr2032_r-thickness,0])
           cube( [ thickness, thickness, cr2032_d * 0.75 ] );
}

module cr2032_half( center = true ){
    difference(){
        difference(){
            linear_extrude( height = cr2032_d*0.75 ){
                square( [ thickness, cr2032_d+thickness*2 ], center );
                translate([-thickness, thickness, 0 ] )
                    square( [thickness*2, thickness ], center );
                translate([-thickness, -thickness, 0 ] )
                    square( [thickness*2, thickness ], center );
            }
            translate([-cr2032_h-thickness,-cr2032_r/4,cr2032_d*1/2])
                rotate([90,0,90])
                terminal_pair();

            translate([thickness/2,cr2032_r/2,cr2032_d*1/2] )
                rotate([90,0,0])                
                cylinder( h = cr2032_r, d = leads_r*2 );
        }
    }
    union(){
        cr2032_clip();
        mirror([0,1,0])
            cr2032_clip();
    }
}

module cr2032_holder( center = true){
    cr2032_half(center);
    translate([cr2032_h+thickness,0,0])
    mirror([1,0,0])
        cr2032_half(center);
}

module spdt_switch(){
    tol = 0.2;
    color("silver")
        cube( [spdt_body_w, spdt_body_d+thickness+0.25, spdt_body_h] );
    translate([1.3,-spdt_sw_w,3.29])
        color("black")
        cube( [spdt_sw_d+tol,spdt_sw_w+tol, spdt_sw_h+tol ]);
    translate([1.3,-spdt_sw_w,6.6])
        color("cyan")
        cube( [spdt_sw_d+tol,spdt_sw_w+tol, spdt_sw_h+tol ]);

}

module batt_holder( batt_h = cr2032_h , batt_d = cr2032_d, t = thickness ){
    batt_r = batt_d/2;
    difference(){
        //< Outter shell
        cylinder( h = batt_h+t*2, d = batt_d+t );
        //< Inner shell
        translate([0,0,t])
            cylinder( h = batt_h*2, d = batt_d );

        //< Top Cutouts (right/left)
        left_cut = 1;
        for( i=[left_cut,1] )
            translate([-batt_r+i*batt_r*2,
                       0,
                       batt_h+t*2])
                cube( [batt_r, batt_d+t*2, batt_h+t], true );

        //< Positive Terminals
        for( i=[-1,1] )
            translate([ i*2.5,
                        0,
                        0] )
                cylinder( h=t, d = leads_r );
        translate([-2.5,0,t])
            rotate([0,90,0])
            cylinder( h = 5, d = leads_r );

        //< Negative Terminals
        for( i = [-1,1] )
            translate( [ i*2.5, batt_r-t, t+batt_h] )
                rotate([-90,0,0] )
                cylinder( h=t*2, d = leads_r  );

        //< Flex cuts
        for( i = [-1,1] )
            translate( [ -(batt_r/2)*i+(i*t*2), -batt_r, batt_h ] )
                #cube( [ t, batt_r, batt_h*2 ],true );
    }
    //< Flex Tab
    translate([ 0,-batt_r,t+batt_h] )
        cylinder( h = t, d = batt_r/4 );
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
                    color("pink")
                        cylinder( h=led_h, r = t+led_rim_d/2.0 );
                }
                translate([0,0,led_h])
                    rotate([180,0,0])
                    #led();
                    #cylinder( h=10, r=(led_rim_d/2)-1 );

            }
            translate([ped_r/3,0, thickness-0.1])
                cr2032_holder();

            union(){
            translate([-ped_r+thickness+0.5,
                       -thickness/2-spdt_body_h/2,
                       thickness] )
                cube( [spdt_retainer_w,
                       spdt_retainer_h,
                       ped_h-thickness ]);
            }
        }
        translate([-ped_r+thickness+0.5,-spdt_body_h/2, ped_h/2+thickness/2])
            rotate([0,-90,-90])
            #spdt_switch();
    }

}

///< Build object
if( print_pedestal ){
    pedestal();
 }
if( print_led_retainer ){
    translate([ped_r+10,0,0] )
        led_retainer();
 }
