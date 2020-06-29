/// Sled3
use <../lib/hull.scad>;
use <../lib/basics.scad>;
use <../lib/utils.scad>;

///< Parameters
height = 4;
width  = 61.69; ///61.77
///length = 1.5*width; ///< 92.535
length =  92.535;

$fn    = 30;


echo( "length = ", length );
difference(){
union(){
import("pi1tray.stl" );
///< example
translate([10-length/2,1-width/2,0])sled_fill(length-10,width-2,height);
}
translate([10-length/2,1-width/2,height])sled_fill(length-10,width-2,height);
}
///< Def
module sled_fill( h, w, d ){
    color(rand_clr())cube([ h, w , d ]);
}
