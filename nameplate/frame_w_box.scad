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
module slide_lid( through_hole = false ){
     ///< Backing
     color( rand_clr() ) translate( [ 0, comp_d+thickness+1.10, 0  ] )
	  cube( [ comp_w, thickness*0.30, comp_h ] );
     color( rand_clr() ) translate( [ 0, comp_d+thickness-2, thickness * 1.25 ] )
	  cube( [ comp_w*0.95, thickness*0.50, comp_h*0.75 ] );
     ///< Slide
     color( rand_clr() ) translate( [ 0, comp_d, thickness/4  ] )cube( [ comp_w*0.95, thickness * 0.95, comp_h * 0.95 ] );

     ///< Right Wall
     difference(){
     color( rand_clr() ) translate( [ 0, comp_d/2, 0 ] )cube( [ thickness,comp_d-thickness + 1,comp_h ] );
     ///< Wire through hole
     if( through_hole )color( rand_clr() ) translate( [ 0, comp_d/2, comp_h/2 ] )
			    rotate( [ 0, 90, 0 ] )cylinder( h = thickness*1.10 , r = comp_d/3);
     }
}

module assembly(){
//union(){
difference(){
     framebox();
     color( rand_clr() )slide_lid();
     }
}

assembly();
translate( [ 0, 50, 0 ] ) slide_lid(true) ;
