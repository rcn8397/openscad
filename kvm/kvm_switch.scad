///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;

///< Parameters
r = 5.00;
h = 38.50;
w = 25.75 - r;
d = 10;


pad_h = 34.10;
pad_w = 18.50;
pad_d =  1.00;
pad_offset = 2.00;

///< Modules
module kvm_switch( width, depth, height, radius,
		   pad_w, pad_d, pad_h,  pad_o ){
  color( "lime" )
    cube( [width, depth, height] );
  color( "cyan" )
    translate( [ 0, radius, 0 ] )
    cylinder( h = height, r=radius, $fn=60 );

  /// Rubber pad
  color( "pink" )
    translate( [ 0, depth,pad_o ] )
    cube( [ pad_w, pad_d, pad_h ] );
}

///< Build kvm_switch
	  kvm_switch( w, d, h, r, pad_w, pad_d, pad_h, pad_offset );

