///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/hull.scad>;
use <../lib/basics.scad>;

///< Parameters
w   = 40.00;
d   = 30.00;
h   = 2.0;
$fn = 60;

///< Hardware parameters
hw_d = 4.0;
hw_h = 100;
hw_l = 9.31;
hw_cntr = (hw_l)/2;

hw_mnts = [
          [ 4.0,                8.5, 0 ],
          [ 4.0 + hw_l + 13.13, 8.5, 0 ],
          ];

wall_mnts = [
             [ w*1/4, -d/2, -12.0 ],
             [ w*3/4, -d/2, -12.0 ],
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
        union(){
            difference(){
             cube( [width, depth, height] );
             for( p = hw_mnts ){
                 translate( p ) mounting_hole( dia = hw_d, length = hw_l, depth = hw_h );
                 }
            }
            translate([0,depth,0])
            rotate([0,180,180])  triangle( width, depth, 100);
        }
    
        for( p = wall_mnts ){
            rotate( [ 90, 0, 0 ] )
            translate( p ) cylinder( d = hw_d, h = 100, center=true);
        }

        for( p = wall_mnts ){
            rotate( [90, 0 , ] )
                translate(p)
                cylinder( d1 = hw_d*3, d2 = hw_d*2.5, h = 18, center=true );
        }

        /// Pocket
        for( p = hw_mnts ){
            translate( p )
            translate([0,-10,-height*3])color("Green")cube( [10, 15, 5] );
        }
        for( p = hw_mnts ){
            translate( p )
                translate([hw_cntr,0,0])
                cylinder( d = hw_d, h = 10, center=true);
        }


    }
}        

///< Build object
wall_mount( w, d, h );

