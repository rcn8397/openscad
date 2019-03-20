///< Triangle module
use <math.scad>

p1 = [   0,   0 ];
p2 = [ 100,   0 ];
p3 = [   0, 100 ];

     
triangle( p1, p2, p3 );

module triangle(pt1, pt2, pt3, h=1) {
     color ("red") linear_extrude (height=h)
	  polygon(points=[ p1, p2, p3 ] );
}
