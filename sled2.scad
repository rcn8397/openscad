/// Sled2
use <oval.scad>;

///< example
translate()sled(10,5,1);
$fn = 30;

///< Def
module sled( w, d, h ){
     center_set = false;
     c_width  = w;
     c_depth  = d;
     c_height = h;
     c_parms = [ c_width, c_depth, c_height ];

     union(){
     color("green")
	  cube(c_parms, center=center_set);
     translate([0,0,c_height/2])
	  rotate([0,90,0])
	  cylinder(h = c_width, d = c_height, center=center_set);
     translate([0, c_depth,c_height/2])
	  rotate([0,90,0])
	  cylinder(h = c_width, d = c_height, center=center_set);
     translate([0,c_depth,c_height/2])
     rotate([90,90,0])
	  cylinder(h = c_depth, d = c_height, center=center_set);
     translate([0,0,c_height/2])
	  sphere(c_height/2);
     translate([0,c_depth,c_height/2])
	  sphere(c_height/2);
     translate([c_width,c_depth/2,0])
	  cylinder( h = c_height, d=c_depth, center=center_set);
     }
}
