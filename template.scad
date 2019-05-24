///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;

///< Parameters
x = 1;
y = 1;
z = 1;

h = 1;
w = 1;
d = 1;

///< Modules
module object( height, width, depth ){
     translate( [ x, y, z ] ) cube( [width, depth, height] );
}

///< Build object
object( w, d, h );

