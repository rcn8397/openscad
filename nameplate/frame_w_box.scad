///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include<nameplate.scad>;
include<frame.scad>;
use <../lib/containers.scad>;
use <slide_backing.scad>;
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



module assembly(){
//union(){
difference(){
     framebox();
     color( rand_clr() )slide_lid( as_channel = true, as_key = true);
     }
}

assembly();
translate( [ 0, 50, 0 ] ) slide_lid(true) ;
