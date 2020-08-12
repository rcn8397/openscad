///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;

$fn = 120;

///< Parameters
r = 10;

///< Modules
module object( radius ){
    difference(){
     sphere( radius );
     sphere( radius * 0.90 );
     cylinder_count = 7.0;
     for( i = [0:1:cylinder_count ] ){
         translate( [0,0,-radius/2.0 ])
         rotate_about_pt( 0.0 + i * 360.0/cylinder_count, 35, [ 0, 0, 0 ] ) 
             cylinder( h = radius * 1.90, r = radius * 0.25);
     }
    }
}

///< Build object
object( radius = r );

