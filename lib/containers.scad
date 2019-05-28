///< Object definition
use <math.scad>;
use <utils.scad>;
use <basics.scad>;

///< Parameters
x = 0;
y = 0;
z = 0;

height = 40;
width  = 20;
depth  = 20;
wall_t = 4;

///< Modules
module hulled_box( w, d, h, t = 1, r = 1 ){
    difference(){
        hulled_cube( w, d, h, r = r );
        translate( [ t/2, t/2, t+0.1  ] )
            color( rand_clr() )hulled_cube( w-t, d-t, h-t, r = r );
    }
}

module hulled_box_friction_lid( w, d, h, t = 1, r = 1, pr = 1 ){
    ///< Friction control
    fric = ( t + 0.1 );
    union(){
        hulled_cube( w, d, t, r=r  );
        translate( [ t/2, t/2, t+0.1  ] )
            color( rand_clr() )hulled_cube( w-fric, d-fric, h*0.1, r=pr );
    }
}


///< Build object
translate( [ x, y, z ] ) hulled_box( width, depth, height, wall_t );
translate( [ width + 10, y, z ] ) hulled_box_friction_lid( width, depth, height, wall_t, pr = 20 );
