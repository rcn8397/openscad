///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include<nameplate.scad>;
include<frame.scad>;
use <../lib/containers.scad>;

depth = 25;
thickness = 6.5;


///< Component housing
comp_w = nameplate_w+thickness;
comp_d = nameplate_d + depth;
comp_h = nameplate_h+thickness;

module framebox(){
difference(){
     translate( [0, thickness*1.2, 0] )cube([ comp_w, comp_d, comp_h ], false );
     translate( [thickness/2, 0, thickness/2] )
	  color( rand_clr() )cube([ comp_w-thickness,
				    (comp_d+thickness)*1.5,
				    comp_h-thickness ], false );
     }
}


///< Lid Slide
module slide_lid(){
     ///< Backing
     color( rand_clr() ) translate( [ 0, comp_d+thickness+1.10, 0  ] )
	  cube( [ comp_w, thickness*0.10, comp_h ] );
     ///< Slide
     color( rand_clr() ) translate( [ 0, comp_d, thickness/3   ] )
	  cube( [ comp_w*0.95, thickness * 0.95, comp_h * 0.95 ] );
     ///< Right Wall
     color( rand_clr() ) translate( [ 0, comp_d/2, 0 ] )cube( [ thickness,comp_d-thickness + 1,comp_h ] );
}

//union(){
difference(){
     framebox();
     slide_lid();
     }
