///< Object definition
use <math.scad>;
use <utils.scad>;
use <basics.scad>;

///< Parameters
x = 0;
y = 0;
z = 0;

height = 20;
width  = 20;
depth  = 20;
wall_t = 4;

///< Modules
module hulled_box( w, d, h, t = 1 ){
    difference(){
        hulled_cube( w, d, h );
        translate( [ t/2, t/2, t+0.1  ] )
            color( rand_clr() )hulled_cube( w-t, d-t, h-t );
    }
}

module hulled_box_friction_lid( w, d, h, t = 1 ){
    union(){
        hulled_cube( w, d, t );
        translate( [ t/2, t/2, t+0.1  ] )
            color( rand_clr() )hulled_cube( w-t, d-t, h*0.1 );
    }
}


///< Build object
translate( [ x, y, z ] ) hulled_box( width, depth, height, wall_t );
translate( [ width + 5, y, z ] ) hulled_box_friction_lid( width, depth, height, wall_t );

