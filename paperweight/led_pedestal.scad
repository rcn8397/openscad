///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/cantilever.scad>;
use <../vector-board/vector-board.scad>;
/*
Module: Paperweight Pedestal
 Simple pedestal with led, powered by a CR2032 battery and controlled by a reed relay
*/

/*
Parameters
*/
// Finish
$fn = 90;

// Pedestal Radius ( 25.4/2 = 12.7 )
ped_r       = 20.0;  // [0:1:100]
// Pedestal Height
ped_min_h   = 10;   // [0:1:100]
// Thickness
thickness   = 1.2; // [0:0.1:20]
// Print Retainer
print_led_retainer = true;
// Print Pedestal
print_pedestal = true;
// Print Battery Holder
print_battery_holder = false;
// Angled  Battery Holder
angled_battery = true;//false;

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
leads_r         = 1.25; // [0:0.01:5]
cr2032_h        = 3.25; // [0:1:100]
cr2032_r        = 10.00;// [0:1:100]
cr2032_d        = cr2032_r * 2;
led_lamp_h      = 2.0;  // [0:0.1:10]
led_lamp_d      = 4.0;  // [0:0.1:4 ]
led_rim_d       = 4.25; // [0:0.1:4 ]
led_rim_h       = 1.0;  // [0:0.1:4 ]
led_retainer_r  = thickness*2+led_rim_d/2.0+0.5;
led_h           = led_lamp_h + led_rim_h + led_lamp_d/2;

connector_r     = thickness + 1;

ped_h           = ped_min_h + cr2032_r*3/4 + thickness*2;

ang = 45;

standoffs = [[-9.95, -9.95, 0], [-9.95, 9.95, 0], [9.95, 9.95, 0], [9.95, -9.95, 0]];

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
            cylinder( h=led_h, r = led_retainer_r );
        translate( [0,0,thickness] )
            color("pink")
            cylinder( h=led_h, r = thickness+led_rim_d/2.0+0.15 );
        led_lead_hole();
        mirror([0,1,0])
            led_lead_hole();
    }
}

module batt_holder( batt_h = cr2032_h , batt_d = cr2032_d+0.5, t = thickness ){
    batt_r = batt_d/2;
    difference(){
        //< Outter shell
        cylinder( h = batt_h+t*2, d = batt_d+t );
        //< Inner shell
        translate([0,0,t])
            cylinder( h = batt_h*2, d = batt_d );

        //< Top Cutouts (right/left)
        left_cut = 0;
        for( i=[left_cut,1] )
            translate([-batt_r+i*batt_r*2,
                       0,
                       batt_h+t*2])
                cube( [batt_r, batt_d+t*2, batt_h+t], true );

        //< Negative Terminals
        for( i=[-1,1] )
            translate([ i*2.5,
                        0,
                        0] )
                cylinder( h=t, d = leads_r+0.5 );
        translate([-2.5,0,t])
            rotate([0,90,0])
            cylinder( h = 5, d = leads_r );
        translate([cr2032_r,-cr2032_r/2,t])
            rotate([0,-90,0])
            #cylinder( h = cr2032_d, d = leads_r );

        //< Positive Terminals
        for( i = [-1,1] )
            translate( [ i*2.5, batt_r-t, t+batt_h] )
                rotate([-90,0,0] )
                cylinder( h=t*2, d = leads_r  );

        //< Flex cuts
        for( i = [-1,1] )
            translate( [ -2.5*i, -batt_r, batt_h ] )
                cube( [ t, batt_r, batt_h*2 ],true );
    }
    //< Flex Tab
    difference(){
    translate([ 0,-batt_r,batt_h*2-t+t/2-0.2] )cylinder( h = t/2, d = 3.85 );
    //    translate([ 0,-batt_r,batt_h*2-.2] )rotate([-35,0,0])#cylinder( h = t, d = 20 );
    }
}

module angled_batt_holder(){
    hull(){
        cube([cr2032_r/2,cr2032_r/2,cr2032_r/3-thickness-0.1],true);
        translate([cr2032_r/4,0,cr2032_r/4])
            color("red")
            rotate([0,ang,0])
            cube([cr2032_r/3,cr2032_r/2,cr2032_r/2-thickness-0.2],true);
    }
    rotate([0,ang,0])
        translate([-cr2032_r/2,0,thickness+cr2032_r/3]){
        batt_holder(t=thickness+0.2);
    }
}

module battery_retainer( angled ){
        // Battery Holder
        if( angled ){
            translate([1 + led_retainer_r+thickness*2,0, thickness-0.15])
                angled_batt_holder();
        }
        else {
            translate([cr2032_r+led_retainer_r+thickness,0, thickness-0.1])
                batt_holder();
        }

}
module pedestal( r = ped_r, h = ped_h, t = thickness ){
    union(){
        difference(){
            union(){
                difference(){
                    cylinder( h=h, r=r );
                    translate([0,0,thickness])
                        color("cyan")
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
        for( pt = standoffs ){
            translate( pt )
                difference(){
                cylinder( h = led_h + 1, d = 3+1 );
                cylinder( h = led_h + 1, d = 3 );
            }
            echo( "pt: ", pt );
        }
        //battery_retainer( angled_battery );
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

if(print_battery_holder){
    translate([0, 40, 0] )
        battery_retainer(angled_battery);
 }

translate([0,0, led_h+1 ] )
vector_board(l = 25.4,
             w = 25.4,
             p = 2.54,
             mounts = true,
             mount_d = 3,
             padding = 1.25,
             rounded = true ); 


 
