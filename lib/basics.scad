///< Basics module
use <math.scad>;
use <utils.scad>;
use <hull.scad>;

module triangle( w, d, h ){
     difference(){
	  hyp = hyp_from_sides( d, h );
	  color( "red" )cube( [w, d, h] );
	  rotate( [ 45, 0, 0 ] )
	       translate( [ -0.01, 0, 0 ] )
	       color( "green" )cube( [w+0.2, hyp, h] );
     }
}

module tri_xy(pt1, pt2, pt3, h=1) {
     color( rands( 0,1,3 ) ) linear_extrude( height=h )
	  polygon( points=[ pt1, pt2, pt3 ] );
}

module triangle_xy( pts, h=1) {
     color( rands( 0,1,3 ) ) linear_extrude( height=h )
	  polygon( points = pts );
}

module oval(w,l, height, center = false, fn = 30) {
 scale([1, l/w, 1]) cylinder(h=height, r=w, center=center, $fn = fn);
}

module pipe( outer, inner, height, fn = 60 ){
     offset_percent = 0.25;
     inner_h = height + (offset_percent * 2 );
     difference(){
     ///< Debug with union(){
	  cylinder(r=outer, h = height, $fn = fn );
	  translate([0,0,-offset_percent]){
	       color("green",0.5)cylinder(r=inner, h = inner_h, $fn = fn );
	  }
     }
}

module rounded_pipe( r, h, fn = 60 ){
     cylinder(r = r, h = h, $fn = fn );

     color("blue")
     translate([0,0,h])
	  sphere(r, $fn = fn );

     color("red")
     translate([0,0,0])
	  sphere(r, $fn = fn );
}

/// Stackoverflow example module for a line
/// https://stackoverflow.com/questions/49533350/is-that-possible-to-draw-a-line-using-openscad-by-joining-different-points
module line(start, end, thickness = 1, fn = 30) {
    hull() {
	translate(start) sphere(thickness, $fn = fn);
	translate(end) sphere(thickness, $fn = fn);
    }
}


/*
Hulled box:

Parameterized box with rounded corners. This uses the hull.scad
to hull four cylinders around four point in space. This variation
offsets the box to zero/zero and takes in w,d,h to mesh better
with tuples.
*/
module hulled_cube( w, d, h, r = 1 ){
    points = [
	[ 0, 0, 0 ],
	[ w, 0, 0 ],
	[ 0, w, 0 ],
	[ w, w, 0 ],
	];
    resize( [w,d,h]){
	translate( [r, r,0] ){
	    rounded_box( points, radius = r, height=h );
	}
    }
}
