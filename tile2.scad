//< Tile again

use <math.scad>

module tile( row, col, cw, shift=true ){
     x_shift = shift ? 1 : 0;
     y_shift = a_from_hb( cw, cw/2 );
     ystep   = shift ? y_shift : cw;
     for ( i = [0:row-1] ){
	  for( j = [0:col-1] ){
	       translate( [ j * cw + ( x_shift * (i%2) * cw/2), i * ystep, 0 ] )
		    children();
	  }
     }
}

$fn=30;
cube_width = 1;
tile(2,2,cube_width,true) circle(d = cube_width);
