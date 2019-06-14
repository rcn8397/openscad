///< Object definition
use <math.scad>;
use <utils.scad>;
use <basics.scad>;
///< Parameters
h = 1;
w = 1;
d = 1;

///< Modules
module clip( w, d, h, over_hang = 0 ){
     cube( w, d, h );
     translate( [ 0, -over_hang, h ] )
	  triangle( w, d+over_hang, h+over_hang );
}

///< Build clip

clip( w, d, h, 1  );
