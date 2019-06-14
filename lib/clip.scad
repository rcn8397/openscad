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
     cube( [w, d, h] );
     translate( [ 0, -over_hang, h ] )
	  triangle( w, d+over_hang, h+over_hang );
}


module rclip( w, d, h, over_hang = 0 ){
     hull()
     {
     translate( [ 0, d*2, h ] )rotate( [0, 90, 0] )cylinder( d = h*1.5, h = d, $fn = 30 );
     triangle( w, d, h );
     translate( [ 0, d, 0 ] )color( "purple")cube( [ w, d*2, h ] );
     }
}
///< Build clip

rclip( w, d, h, 1  );
