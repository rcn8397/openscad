///< Nameplate
/*
https://en.wikipedia.org/wiki/Nameplate
Excerpt:  'Although office nameplates range in size, the most popular nameplate size is 2 by 8 inches (5.08 cm × 20.32 cm)'

*/
use <../lib/math.scad>;
use <../lib/utils.scad>;

///< Parameters
nameplate_w_inches = 8;
nameplate_h_inches = 2;
nameplate_d_inches = 0.10;

nameplate_w = in2mm( nameplate_w_inches );
nameplate_h = in2mm( nameplate_h_inches );
nameplate_d = in2mm( nameplate_d_inches );

nameplate_debug = false;

if( nameplate_debug ) {
     echo( "Nameplate width: ",  nameplate_w,  "mm" );
     echo( "Nameplate height: ", nameplate_h, "mm" );
     echo( "Nameplate depth: ",  nameplate_d,  "mm" );
}

nameplate = [ nameplate_w, nameplate_d, nameplate_h ];

///< Modules
module Nameplate( size, center = false ) {
     cube( size, center = center );
}
