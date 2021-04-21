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

// X Position
x = 1; // [0:1:100]

// Y Position
y = 1; // [0:1:100]

// Z Position
z = 1; // [0:1:100]

// Width
w = 1; // [0:1:100]

// Depth
d = 1; // [0:1:100]

// Height
h = 1; // [0:1:100]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}


///< Modules
module object( height, width, depth ){
     translate( [ x, y, z ] ) cube( [width, depth, height] );
}

///< Build object
object( w, d, h );

