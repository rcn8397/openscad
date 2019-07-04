///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;

///< Parameters
height = 2.5;
outer = 8.2;
inner = 4;

///< Modules
module washer( h, outer_d, inner_d ){
    difference(){
    cylinder( h=h, d=outer_d, $fn=30 );
    translate([0,0,-0.01])
    cylinder( h=h+0.02, d=outer_d-inner_d, $fn=30 );
    }
}

///< Build object
washer( height, outer, inner );

