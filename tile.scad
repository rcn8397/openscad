///< Tile generator
use <math.scad>;
use <honeycomb.scad>;

///< obj_parmaters
width     = 8;
radius    = width/2;
///< Modules
module tile( rows, cols, d, pack=1, angle=90 ) {
     size = d * pack;
     for( i = [0:rows-1] ){
	  for( j = [0:cols-1] ){
	       translate( [ ( j * size ) + ( i % 2 ) * (size/2 ), i * ( size ), 0 ] )
		    rotate( [0, 0, angle ] ) 
		    children();
	  }
     }
}

///< Proto type
tile( 2, 2, width, pack=1) cell( 1, radius, radius * 0.2 );
//tile( 2, 2, radius*2) circle(radius, true );
///tile( 2, 2, width+1 )cube( width, true );
