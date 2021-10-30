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
// Thickness
thickness       = 1.5;  // Thickness
// Dome Radius
dome_rad = 27; // [0:1:100]
// Wand head radius
head_r = 15.50/2;
// Wand head length
head_l = 10;
// Wand handle radius
handle_d = 22.25+thickness*2;
handle_r = handle_d/2;
// Wand handle length
handle_l = 15;
// Bolt Diameter
bolt_d = 6;   // [0:0.01:20]
// Thread Diameter
thread_d = 3; // [0:0.01:20]
// print cr2032 half
print_cr2032_half = false;
// print half
print_half = false;

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}

leads_r         = 1.25; // [0:0.01:5]
cr2032_h        = 3.25; // [0:1:100]
cr2032_r        = 10.50;// [0:1:100]
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
        dome( rad-thickness);
    }
}

module coupling( height, rad, bolt_r,  cut=false ){
    if( cut ){
        translate([0,0,(height/2)-thickness])
            cylinder( h = height+thickness*2, r = rad, center=true );        
    }
    else{
        translate([0,0,height/2])
            difference(){
            cylinder( h = height, r = rad, center=true );
            translate([0,0,thickness])
                cylinder( h = height, r = rad-thickness, center=true );
            cylinder( h = height + thickness*2, r = bolt_r, center = true );
        }
    }
}

module cr2032_retainer_half( rad, cut = false ){
    z = cr2032_h/4+thickness/2;
    y = cr2032_d*0.90;
    translate( [0, rad-cr2032_r-(thickness)+0.5, z ] )

    if( cut ){
        cube( [ cr2032_d + thickness*2, cr2032_d + thickness*2, cr2032_h/2+thickness ], center = true );
    }
    else {
        difference(){
            difference(){
                difference(){
                    cube( [ cr2032_d + thickness*2, y + thickness*2, cr2032_h/2+thickness ], center = true );
                    translate([ 0, thickness, -thickness ] )
                        cube( [ cr2032_d, y, cr2032_h+1.0 ], center = true );
                }
                ///< lead holes
                for( i = [ -1, 1 ] ){
                    translate([ i * ( cr2032_r * 2/5 ), 0, 0 ] )
                        cylinder( h = cr2032_h/2+thickness*2, r = 1, center=true );
                }
                length = ( cr2032_r*2/5 )*2;
                rotate([0,90,0])
                    cylinder( h = length, r = 1, center = true );
            }
            translate( [ 0, cr2032_r+cr2032_r*3/5, 0 ] )
                sphere( d = cr2032_d );
        }
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


module wand_coupler(){
    difference(){
        dome_hollow( dome_rad );
        #spdt_switch_cut();
        #coupling( dome_rad, bolt_d, thread_d,true );
        #cr2032_retainer_half( dome_rad, true );
        #adapter( head_l,   head_r-thickness,    dome_rad+thickness*2, false );
        #adapter( handle_l, handle_r-thickness, -dome_rad-thickness*2, false );
    }
    adapter( head_l,   head_r,    dome_rad+thickness*2,  true );
    adapter( handle_l, handle_r, -dome_rad-thickness*2, true );
    coupling( dome_rad, bolt_d, thread_d );
    cr2032_retainer_half(dome_rad);
}


// Build the thing
if( print_cr2032_half ){
    cr2032_retainer_half(dome_rad);
    mirror([ 0,0,1] )
        cr2032_retainer_half(dome_rad);
 }
 else{
     
     wand_coupler();
     if( !print_half ){
         translate([0,dome_rad*2+10,0])
             mirror([1,0,0])
             wand_coupler();
     }
 }

