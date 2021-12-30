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

// finish
$fn = 60;

// Num switches
num_switches = 5;

// Switch Hole Radius
sw_hole_r = 1.5; // [0:0.1:100]

// Rotation 
rot_x = 10; // [-90:0.1:90] 

// Padding
pad = 1; // [0:0.1:25]

// Thickness
thickness = 1;   // [0:1:10]

// Legend Height
legend_h = 1.0;  // [0:1:10]

// Foot depth
foot_depth = 4;  // [0:1:25]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
rot_y = 0; // [-360:0.1:360]
rot_z = 0; // [-360:0.1:360]


///< Modules

module rotate_about(a, v, p=[0,0,0]) {
    // Credit: thehans
    // https://forum.openscad.org/Rotate-about-user-defined-axis-td27737.html
     translate(p) rotate(a,v) translate(-p) children();
} 

module object( r = sw_hole_r, pad = pad, /* rot = [rot_x, rot_y, rot_z],*/  t = thickness, lh = legend_h, fd = foot_depth ){
    cut = 100;
    w = r*2 + pad;
    h = r*2 + pad;
    d = t;
    ph = d+pad;
    z_offset = h/2;
    difference(){
    
        hull(){
            rotate_about( -rot_x, v = [1,0,0], p = [0,0,0] )
                translate([0,0,z_offset+lh/2])
                cube( [ w, d, h ], center = true );
            translate([0,0,0])
                color("green")
                cube( [w, d, lh], true );
        }
        rotate_about( -rot_x, v = [1,0,0], p = [0,0,0] )
            translate([0,cut/2,z_offset+lh/2])
            translate([0,d/2,0])
            rotate([90,0,0])
            cylinder( d = sw_hole_r * 2, h = cut );
    }

    //< Foot
    translate([0,(fd/2)-d/2,0])
        difference(){
        color("pink")
            cube( [w, fd, t], true );
        for( i = [ 0 : 1 ] ){
            x = ( ( i * w/2) - 1 );
            color("cyan")
                translate( [ x, fd*.10, 0 ] ){
                cube( [w/4, fd/2, 10 ],true );
            }
        }
    }

    //< Legend TODO

}


///< Build object

for( i = [0:num_switches-1] ){
    r = sw_hole_r;
    w = ( r * 2 + pad )*i;
    p = [ w, 0, 0 ];
    translate( p )
        object();
 }

