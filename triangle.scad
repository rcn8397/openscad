///< Triangle module
use <math.scad>

p1 = [   0,   0 ];
p2 = [   5,   0 ];
p3 = [   0,   5 ];

     
translate( [ 0 ,10, 0 ] ) tri( p1, p2, p3, h = 5 );
triangle( [p1,p2,p3], h = 3 );

module tri(pt1, pt2, pt3, h=1) {
     color( rands( 0,1,3 ) ) linear_extrude( height=h )
	  polygon( points=[ pt1, pt2, pt3 ] );
}

module triangle( pts, h=1) {
     color( rands( 0,1,3 ) ) linear_extrude( height=h )
	  polygon( points = pts );
}



