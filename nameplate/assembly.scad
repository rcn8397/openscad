///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;

///< Models
use <frame.scad>;
use <led_frame.scad>;

///< Imported parameters
include <nameplate.scad>;

///< Parameters
w = nameplate_w;
d = nameplate_d;
h = nameplate_h;

///< Build object
module assembly(){
translate( [ 0, 0, 0 ] )frame( w, d, h );
color( rand_clr() )
     mirror( [ 0, 1, 0 ] )
     translate( [ 5, 0, 5 ] )
     led_frame( w, d, h );
}

assembly();
