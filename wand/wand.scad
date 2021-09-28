///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: Neo Queen Serenity Wand Adapter
*/

/*
Parameters
*/

// X Position
x = 1; // [0:1:100]
// Y Position
y = 1; // [0:1:100]
// Z Position
z = 1; // [0:1:100]
// Width
w = 1; // [0:1:100]
// Depth
d = 1; // [0:1:100]
// Height
h = 1; // [0:1:100]

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


///< Build object
spdt_switch();
