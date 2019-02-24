//< Tile again



module tile( row, col, cw ){
     xstep = cw;
     ystep = cw;
     
     for ( i = [0:row-1] ){
	  for( j = [0:col-1] ){
	       translate( [ j * xstep, i * ystep, 0 ] )
		    children();
	  }
     }
}

$fn=30;
cube_width = 1;
tile( 2, 2, cw = cube_width ) circle( d = cube_width );
