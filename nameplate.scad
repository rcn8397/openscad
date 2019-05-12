///< Nameplate
/*
https://en.wikipedia.org/wiki/Nameplate
Excerpt:  'Although office nameplates range in size, the most popular nameplate size is 2 by 8 inches (5.08 cm × 20.32 cm)'


*/
use <math.scad>;
use <utils.scad>;

///< Parameters
units = "mm";

nameplate_width_inches  = 8;  
nameplate_height_inches = 2;
nameplate_depth_inches  = 0.10;

nameplate_width  = in2mm( nameplate_width_inches );
nameplate_height = in2mm( nameplate_height_inches );
nameplate_depth  = in2mm( nameplate_depth_inches );

echo( "Nameplate width: ",  nameplate_width,  "mm" );
echo( "Nameplate height: ", nameplate_height, "mm" );
echo( "Nameplate depth: ",  nameplate_depth,  "mm" );



///< Modules
module Nameplate( width, depth, height, center = false ) {
     cube( [ width, depth, height ], center = center );
}

module object( height, width, depth ){
     cube( height, width, depth );
}


///< Build object
Nameplate( nameplate_width, nameplate_depth, nameplate_height );

