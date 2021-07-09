///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: clip0
Bull ring clip
*/

/*
Parameters
*/
// Finish
$fn = 60;

// Deflector Radius
deflect_rad    = 10.0;     // [0:0.01:1000]
// Receptacle Radius
receptacle_rad = 50.0;     // [0:0.01:1000]
// Thickness
thickness      = 5.0;      // [0:0.01:1000]
// Height
height         = 20.0;     // [0:0.01:1000]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
deflect_ang    = 45.0;     // [0:0.01:360]
deflect_x      = opposite_side_th( deflect_ang, receptacle_rad );
deflect_y      = adjacent_side_th( deflect_ang, receptacle_rad );


///< Modules
module receptacle(r = receptacle_rad, x = deflect_x, y = deflect_y, h = height, t = thickness ){
    ///< Note: X is not used, but included for completeness
    linear_extrude( height = h ){
        difference(){
            difference(){
                circle( r = r);
                circle( r = (r - t));
            }
            translate( [ -r, y, 0 ] )
                square( [ r*2, r/2 ] );
        }
    }
}

module deflection( r = deflect_rad, x = deflect_x, y = deflect_y, h = height, t = thickness ){
    linear_extrude( height = h ){

            translate( [ (x-t/2), y, 0 ] )
            circle( r = r );
    }
}

module deflectors( r = deflect_rad, x = deflect_x, y = deflect_y, h = height, t = thickness ){
    color( "cyan" )
        deflection( r, x, y, h, t);
    mirror([1,,0]){
        color( "cyan" )
            deflection( r, x, y, h, t);
    }
}

receptacle();
deflectors();

