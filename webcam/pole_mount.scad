///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/GoPro_Mount.scad>;

///< Parameters
$fn = 60; ///Finish
ring_radius =  35.30;
ring_height =  15.00;
gp_offset   = ring_radius - 01.50;


///< Modules
module RingMount( height, radius, thickness = 4, center = true ){
    difference(){
        color( rand_clr())cylinder( h = height, r = radius, center = center );
        color( rand_clr())cylinder( h = height, r = radius - thickness, center = center );
    }
}


module GoProMount(){
    ///< GoPro Mount - 3 flap w/nut hole
    translate([0, 0, 10.5])
    	rotate([0, 90, 0])
    		mount3();
}
///< Build object
///
union(){
translate( [gp_offset,0,0] )rotate( [0,90,0] )GoProMount();
RingMount( ring_height, ring_radius );
}

