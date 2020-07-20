///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/GoPro_Mount.scad>;

///< Parameters
$fn = 60; ///Finish
ring_thickness      =  7.0;
inner_ring_diameter = 35.5;
outer_ring_diameter = inner_ring_diameter + ring_thickness ;
inner_ring_radius   = inner_ring_diameter/2;
outer_ring_radius   = outer_ring_diameter/2;

ring_height =  15.00;
gp_offset   = outer_ring_radius - 3;


///< Modules
module RingMount( height, inner_radius, outer_radius, center = true ){
    difference(){
        color( rand_clr())cylinder( h = height, r = outer_radius, center = center );
        color( rand_clr())cylinder( h = height, r = inner_radius, center = center );
    }
}


module GoProMount(){
    ///< GoPro Mount - 3 flap w/nut hole
    translate([0, 0, 10.5])
    	rotate([0, 90, 0])
    		mount3();
}
///< Build object
union(){
translate( [gp_offset,0,0] )rotate( [0,90,0] )GoProMount();
RingMount( ring_height, inner_ring_radius, outer_ring_radius );
}

