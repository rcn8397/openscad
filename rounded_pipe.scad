/// Pipe that is rounded on the ends

$fn = 50;
///< example
translate()pipe(r=5, h=10);


///< Def
module pipe( r, h ){
     cylinder(r = r, h = h );

     color("blue")
     translate([0,0,h])
	  sphere(r);

     color("red")
     translate([0,0,0])
	  sphere(r);

}
