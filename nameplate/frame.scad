///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include <nameplate.scad>

///< Parameters
module Frame( show_nameplate = false ){

     ///< Frame demensions
     frame_clearance = 0.01;
     frame_p = 5 + frame_clearance; //< Padding
     frame_w = nameplate_w + frame_p;
     frame_d = nameplate_d + frame_p;
     frame_h = nameplate_h + frame_p;

     frame = [ frame_w, frame_d, frame_h ];
     frame_inset = [0, frame_p/2, frame_p/2 ];
     frame_view  = [0, 0,         frame_p ];

     nameplate_cut = [ ( frame_w + ( frame_p * 2.0 ) ) * 1.01,
		     nameplate_d * 1.01,
		     nameplate_h * 1.01 ];

     view_w = frame_w;
     view_d = nameplate_d;
     view_h = nameplate_h - ( frame_p);
     view_cut = [ view_w, view_d, view_h ];

     if( show_nameplate ){
	  echo( nameplate );
	  color( rand_clr() )
	       translate( frame_inset ){ Nameplate( nameplate ); }
     }

     ///< Holder
     difference(){
	  color( rand_clr() )cube( frame );
	  color( rand_clr() )
	       translate( frame_inset )
	       Nameplate( nameplate_cut );
	  color( rand_clr() )
	       translate( frame_view )
	       cube( view_cut );
     }
}


///< Build object
//difference(){
     Frame( );
//     translate( [ 190, 0, 0 ] )cube( [30,50,80] );
//}
