///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include<nameplate.scad>;
//include<frame.scad>;
use <../lib/basics.scad>;
use <../lib/chnl_fit.scad>;

depth = 25;
thickness = 6.5;

///< Component housing
comp_w = nameplate_w+thickness;
comp_d = nameplate_d + depth;
comp_h = nameplate_h+thickness;

///< Lid Slide
module slide_lid( through_hole = false, as_channel = true ){
     
  back_thickness  = thickness;
  slide_thickness = thickness;
  channel_w       = 2;
  rake            = 5;
  separation      = comp_h- ( channel_w * 2 ) - ( rake*2 );
  
     ///< Backing
     color( rand_clr() ) translate( [ 0, comp_d+thickness+1.10, 0  ] )
	  cube( [ comp_w, back_thickness*0.30, comp_h ] );
     ///< Slide
     color( rand_clr() ) translate( [ 0, comp_d+1.10, channel_w  ] )
       cube( [ comp_w*0.95, slide_thickness, separation+(rake*2) ] );
     translate( [ 0, comp_d+thickness+1.10, -channel_w  ] )
     rotate( [0,-90,-180])mirror([0,0,0])
       mirrored_channel_pairs( width      = channel_w,
			       height     = 10,
			       length     = comp_w*0.95,			
			       separation = separation,
			       clearance  = 0.7,
			       rake = 5,
			       Q = 2,
			       O = 2,
			       S = 2,
			       hide_key = as_channel );
     ///< Right Wall
     difference(){
     color( rand_clr() ) translate( [ 0, comp_d/2, 0 ] )cube( [ thickness,comp_d-thickness + 1,comp_h ] );
     ///< Wire through hole
     if( through_hole )color( rand_clr() ) translate( [ 0, comp_d/2, comp_h/2 ] )
			    rotate( [ 0, 90, 0 ] )cylinder( h = thickness*1.10 , r = comp_d/3);
     }
}


slide_lid(true, false) ;
