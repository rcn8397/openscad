///< Nameplate
/*
https://en.wikipedia.org/wiki/Nameplate
Excerpt:  'Although office nameplates range in size, the most popular nameplate size is 2 by 8 inches (5.08 cm × 20.32 cm)'


*/
use <math.scad>;
use <utils.scad>;

///< Parameters
nameplate_w_inches  = 8;  
nameplate_h_inches = 2;
nameplate_d_inches  = 0.10;

nameplate_w  = in2mm( nameplate_w_inches );
nameplate_h = in2mm( nameplate_h_inches );
nameplate_d  = in2mm( nameplate_d_inches );

echo( "Nameplate width: ",  nameplate_w,  "mm" );
echo( "Nameplate height: ", nameplate_h, "mm" );
echo( "Nameplate depth: ",  nameplate_d,  "mm" );

nameplate = [ nameplate_w, nameplate_d, nameplate_h ];

///< Modules
module Nameplate( size, center = false ) {
     cube( size, center = center );
}

module Frame( show_nameplate = false ){
     
     ///< Frame demensions
     frame_p = 5;
     frame_w = nameplate_w + frame_p;
     frame_d = nameplate_d + frame_p;
     frame_h = nameplate_h + frame_p;

     frame = [ frame_w, frame_d, frame_h ];
     frame_inset = [0, 0, frame_p/2 ];

     nameplate_t = [  ( frame_w + ( frame_p * 2.0 ) ) * 1.01,
		      nameplate_d * 1.01, nameplate_h * 1.01 ];
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

	       Nameplate( nameplate_t );
   }
}

///< Build object
Frame(  );

