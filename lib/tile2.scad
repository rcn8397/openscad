//< Tile again
use <math.scad>

module tile( row, col, cw, pack=false, rot=0, xpad=0, ypad=0 ){
     x_shift = pack ? 1 : 0;
     y_shift = a_from_hb( cw, cw/2 );
     ystep   = pack ? y_shift : cw;
     for ( i = [0:row-1] ){
	  for( j = [0:col-1] ){
	       translate( [ j * (cw + xpad) + ( x_shift * (i%2) * cw/2), i * ( ystep + ypad), 0 ] )
		    rotate([0,0,rot])
		    children();
	  }
     }
}

width = 1;
tile(2,2,width+0.5) {
     difference() {
	  cylinder(width);
	  cube(width,true);
     }
}
