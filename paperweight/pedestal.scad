///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/cantilever.scad>;

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
ped_r       = 20;  // [0:1:100]
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

spdt_body_w     = 7.5; // [0:0.1:15]
spdt_body_d     = 6.5; // [0:0.1:15]
spdt_body_h     = 13.5;// [0:0.1:15]
spdt_lead_w     = 1.3; // [0:0.1:15]
spdt_lead_d     = 7.0; // [0:0.1:15]
spdt_lead_h     = 1.0; // [0:0.1:15]
spdt_sw_w       = 6.0; // [0:0.1:15]
spdt_sw_d       = 4.0; // [0:0.1:15]
spdt_sw_h       = 4.0; // [0:0.1:15]
spdt_retainer_w = spdt_body_d  + thickness;
spdt_retainer_h = spdt_body_h + thickness;

ped_h           = ped_min_h + cr2032_r*3/4 + thickness*2;

ang = 45;

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
    translate([spdt_body_w/2,
               spdt_body_d+thickness+0.25+spdt_lead_d/2,
               1.5])
        color("gold")
        cube( [ spdt_lead_w, spdt_lead_d, spdt_lead_h ], true );
    translate([spdt_body_w/2,
               spdt_body_d+thickness+0.25+spdt_lead_d/2,
               spdt_body_h/2])
        color("gold")
        cube( [ spdt_lead_w, spdt_lead_d, spdt_lead_h ], true );
    translate([spdt_body_w/2,
               spdt_body_d+thickness+0.25+spdt_lead_d/2,
               spdt_body_h-1.5])
        color("gold")
        cube( [ spdt_lead_w, spdt_lead_d, spdt_lead_h ], true );

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

module pedestal( r = ped_r, h = ped_h, t = thickness ){
    union(){
        difference(){
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
                // Switch Retainer
                translate([-ped_r+thickness+0.5,
                           -thickness/2-spdt_body_h/2,
                           thickness ] )
                    color("lime")
                    cube( [spdt_retainer_w, spdt_retainer_h, ped_h/2+thickness ]);
                translate([ -spdt_body_d-thickness*2,
                            -thickness-spdt_body_h/2,
                            /*ped_h/2+*/thickness])
                rotate([0,-90,0]){
                    cantilever(y = thickness*3/4,
                               h = thickness,
                               b = ped_h/2+spdt_body_d-thickness,
                               p = 1,
                               a = 2,
                               l = spdt_body_d);
                    translate([0,spdt_body_h+thickness*2,0])
                        mirror([0,1,0])
                        cantilever(y = thickness*3/4,
                                   h = thickness,
                                   b = ped_h/2+spdt_body_d-thickness,
                                   p = 1,
                                   a = 2,
                                   l = spdt_body_d);
                }                
    
            }
            // Switch
            translate([-ped_r+thickness+0.5,-spdt_body_h/2, ped_h/2 ])//thickness*2])
                rotate([0,-90,-90])
                #spdt_switch();
        }
        ///Lower SPDT clamps
        
                translate([-spdt_retainer_w-thickness+2,
                           -1,
                           thickness])
                rotate([90,-90,0])
                color("silver")
                    cantilever_w_fillet(y  = thickness+1,
                                        h  = thickness+0.40,
                                        b  = ped_h/2+(spdt_body_d/2)-2*thickness-1.5,
                                        p  = 2,
                                        a  = 2,
                                        l  = spdt_body_d/2,
                                        fw = 1,
                                        fh = 3,
                                        fr = 1);
                translate([-spdt_retainer_w-thickness+2,
                           1+spdt_body_d/2,
                           thickness])
                rotate([90,-90,0])
                color("silver")
                    cantilever_w_fillet(y  = thickness+1,
                                        h  = thickness+0.40,
                                        b  = ped_h/2+(spdt_body_d/2)-2*thickness-1.5,
                                        p  = 2,
                                        a  = 2,
                                        l  = spdt_body_d/2,
                                        fw = 1,
                                        fh = 3,
                                        fr = 1);
                
        // Battery Holder
        if( angled_battery ){
        translate([1 + led_retainer_r+thickness*2,0, thickness-0.15])
            angled_batt_holder();
        }
        else {
        translate([cr2032_r+led_retainer_r+thickness,0, thickness-0.1])
            batt_holder();
        }
    }
}

///< Build object
if( !print_battery_holder ){
    if( print_pedestal ){
        pedestal();
    }
    if( print_led_retainer ){
        translate([ped_r+10,0,0] )
            led_retainer();
    }
 }
 else{
     angled_batt_holder();
     //spdt_switch();
 }


    
