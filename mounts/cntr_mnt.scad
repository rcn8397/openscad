///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/hull.scad>;

///< Parameters
w   = 40.00;
d   = 30.00;
h   = 2.0;
$fn = 60;

///< Hardware parameters
hw_d = 4.0;
hw_h = 100;
hw_l = 9.31;

hw_mnts = [
          [ 4.0,               8.5, 0 ],
          [ 4.0 + hw_l + 13.13, 8.5, 0 ],
          ];

module mounting_hole( dia, length, depth ){
       hull(){
        cylinder( d = dia, h = depth, center = true );
        translate( [ length, 0 , 0 ] )
                   cylinder( d = dia, h = depth, center = true );
       }
}

///< Modules
module wall_mount( width, depth, height ){
    difference(){
     cube( [width, depth, height] );
     for( p = hw_mnts ){
         translate( p ) mounting_hole( dia = hw_d, length = hw_l, depth = hw_h );
         }
    }
}        

///< Build object
wall_mount( w, d, h );

