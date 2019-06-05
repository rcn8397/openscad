///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <led_frame.scad>;
include <nameplate.scad>

///< Parameters
module frame( w, d, h, pad = 5, show_nameplate = false ){

     ///< Frame demensions
     frame_clearance = 0.01;
     frame_p = pad + frame_clearance; //< Padding
     frame_w = w + frame_p;
     frame_d = d + frame_p;
     frame_h = h + frame_p;

     frame = [ frame_w, frame_d, frame_h ];
     frame_inset = [0, frame_p/2, frame_p/2 ];
     frame_view  = [0, 0,         frame_p ];

     nameplate_cut = [ ( frame_w + ( frame_p * 2.0 ) ) * 1.01,
		     d * 1.01,
		     h * 1.01 ];

     view_w = frame_w;
     view_d = d;
     view_h = h - ( frame_p);
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
     translate( [ pad/2, ( d + pad - 0.1 ), pad/2 ] )
	  mirror( [ 0, 1, 0 ] )
	  led_frame( w, d + pad, h );
}

///< Build object
echo( nameplate_w, nameplate_d, nameplate_h  );
frame( nameplate_w, nameplate_d, nameplate_h  );
