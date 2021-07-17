///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: CR2032 Battery Holder/Switch
   Preamble and description
*/

/*
Parameters
*/
// Finish
$fn = 90;

// Pedestal Radius
ped_r = 5; // [0:1:100]
// Pedestal Height
ped_h = 1; // [0:1:100]
// Thickness
thickness = 1.0; // [0:1:100]
// Terminal Wire Radius
term_r   = 0.5;    // [0:0.1:100]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
holder_w = (ped_r*2)+thickness;
holder_d = (ped_r*2)+thickness;
holder_h = (ped_h+thickness*2);

term_l   = (ped_r*2)+thickness*2;

///< Modules
module cr2032( r = ped_r, h = ped_h, t = thickness ){
    color("silver")
        cylinder( h=h, r=r, true );
}

module holder( w=holder_w, d=holder_d, h=holder_h, t = thickness ){
    translate([0,0,t/2])
    difference(){
        cube( [ w, d, h ], true );
        translate([0,0,h/2])
            cube( [ w, d/3, h ], true );
    }
}

module terminal( r = term_r, l = term_l ){
    cylinder( h = l, r = r );
}


///< Build object
difference(){
    difference(){
        holder();
        hull(){
            cr2032();
            translate([thickness+ped_r*1/2,0,0])
                cr2032();
        }
    }
    translate( [ -ped_r-thickness, 0, -thickness/2 ] )
        rotate( [0,90,0] )
    terminal();
    translate( [ -ped_r+thickness/2, -ped_r+thickness, thickness/2 ] )
            rotate( [ -90, 0, 0 ] )
        terminal();
    
}

