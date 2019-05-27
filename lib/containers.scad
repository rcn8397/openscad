///< Object definition
use <math.scad>;
use <utils.scad>;
use <basics.scad>;

///< Parameters
x = 0;
y = 0;
z = 0;

height = 10;
width  = 10;
depth  = 10;

///< Modules
module hulled_box( w, d, h, t = 1 ){
//    union(){
    difference(){
        hulled_cube( w, d, h );
        translate( [ t/2, t/2, t+0.1  ] )
            color( rand_clr() )hulled_cube( w-t, d-t, h-t );
    }
}


///< Build object
translate( [ x, y, z ] ) hulled_box( width, depth, height );

