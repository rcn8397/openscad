///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include<nameplate.scad>;
//include<frame.scad>;
use <../lib/basics.scad>;
use <../lib/containers.scad>;

depth = 25;
thickness = 6.5;


///< Component housing
comp_w = nameplate_w+thickness;
comp_d = nameplate_d + depth;
comp_h = nameplate_h+thickness;

///< Lid Slide
module slide_lid( through_hole = false, tolerance = 0.0, as_channel = true ){
     
     back_thickness = thickness - thickness * tolerance;
     slide_thickness = thickness - thickness * tolerance;
     gap_w = tolerance * 2 + thickness/2;
     
     ///< Backing
     color( rand_clr() ) translate( [ 0, comp_d+thickness+1.10, 0  ] )
	  cube( [ comp_w, back_thickness*0.30, comp_h ] );
     ///< Slab connection
     color( rand_clr() ) translate( [ 0, comp_d+slide_thickness-gap_w, thickness * 1.25 ] )
	  cube( [ comp_w*0.85, gap_w, comp_h*0.75 ] );
     ///< Slide
     color( rand_clr() ) translate( [ 0, comp_d*0.95, thickness/4  ] )
      	 cube( [ comp_w*0.95, slide_thickness * 0.95, comp_h * 0.95 ] );

     ///< Right Wall
     difference(){
     color( rand_clr() ) translate( [ 0, comp_d/2, 0 ] )cube( [ thickness,comp_d-thickness + 1,comp_h ] );
     ///< Wire through hole
     if( through_hole )color( rand_clr() ) translate( [ 0, comp_d/2, comp_h/2 ] )
			    rotate( [ 0, 90, 0 ] )cylinder( h = thickness*1.10 , r = comp_d/3);
     }
}


slide_lid(true, 0.10, false) ;
