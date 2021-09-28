///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: Neo Queen Serenity Wand Adapter
*/

/*
Parameters
*/

// Finish
$fn=90;

// Dome Radius
dome_rad = 30; // [0:1:100]
// Wand head radius
head_r = 15;
// Wand head length
head_l = 20;
// Wand handle radius
handle_r = 20;
// Wand handle length
handle_l = 20;

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
thickness       = 1.0;  // Thickness
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

spdt_body_w     = 7.40; // [0:0.1:15]
spdt_body_d     = 5.75;  // [0:0.1:15]
spdt_body_h     = 13.25;// [0:0.1:15]
spdt_lead_w     = 1.3+0.50; // [0:0.1:15]
spdt_lead_d     = 7.0+0.50; // [0:0.1:15]
spdt_lead_h     = 1.0+0.50; // [0:0.1:15]
spdt_sw_w       = 6.0; // [0:0.1:15]
spdt_sw_d       = 4.0; // [0:0.1:15]
spdt_sw_h       = 4.0; // [0:0.1:15]


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

module spdt_switch(){
    tol = 0.0;
    color("silver")
        cube( [spdt_body_w, spdt_body_d+thickness, spdt_body_h] );
    translate([1.3,-spdt_sw_w,3.29])
        color("black")
        cube( [spdt_sw_d+tol,spdt_sw_w+tol, spdt_sw_h+tol ]);
    translate([1.3,-spdt_sw_w,6.6])
        color("cyan")
        cube( [spdt_sw_d+tol,spdt_sw_w+tol, spdt_sw_h+tol ]);

    /// Terminals
    translate([spdt_body_w/2,
               spdt_body_d+thickness+spdt_lead_d/2,
               2])
        color("gold")
        cube( [ spdt_lead_w, spdt_lead_d, spdt_lead_h ], true );
    translate([spdt_body_w/2,
               spdt_body_d+thickness+spdt_lead_d/2,
               spdt_body_h/2])
        color("gold")
        cube( [ spdt_lead_w, spdt_lead_d, spdt_lead_h ], true );
    translate([spdt_body_w/2,
               spdt_body_d+thickness+spdt_lead_d/2,
               spdt_body_h-2])
        color("gold")
        cube( [ spdt_lead_w, spdt_lead_d, spdt_lead_h ], true );

}

module dome( rad ){
    difference(){
        sphere( r = rad );
        translate([0,0,-rad/2])
        cube([rad*2, rad*2, rad], center=true);
        }
}

module dome_hollow( rad ){
    difference(){
        dome( rad );
        translate([0,0,-0.0099])
            dome( rad-thickness);
    }
}

module spdt_switch_cut(){
    translate([spdt_body_h/2,
               -dome_rad+thickness*2,
               -spdt_body_w/2])
        rotate([0,-90,0])
        spdt_switch();
}
module half_cylinder(l, r, x_offset){
    translate([x_offset,0,0]){
        rotate([0,90,0])
            difference(){
            cylinder( h = l, r = r, center=true );
            translate( [ r/2, 0, 0] )
                cube( [ r, r*2, l ], center=true );
        }
    }
}

module adapter( l, r, x_offset, hollow = true ){
    if( hollow ){
        difference(){
            half_cylinder(l,r,x_offset );
            half_cylinder(l,r-thickness, x_offset );
        }
    }
    else{
        half_cylinder(l,r,x_offset );
    }
}


///< Build object

difference(){
    dome_hollow( dome_rad );
    #spdt_switch_cut();
}
adapter( head_l,   head_r,    dome_rad+spdt_body_h/2,  true );
adapter( handle_l, handle_r, -dome_rad-spdt_body_h/2, true );
