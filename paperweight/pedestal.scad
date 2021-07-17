///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: Name
   Preamble and description

*/

/*
Parameters
*/
// Finish
$fn = 90;

// Pedestal Radius
ped_r = 5; // [0:1:100]
// Pedestal Height
ped_h = 1; // [0:1:100]
// Thickness
thickness = 1.0; // [0:1:100]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}


///< Modules
module pedestal( r = ped_r, h = ped_h, t = thickness ){
    cylinder( h=h, r=r );
}

///< Build object
pedestal();

