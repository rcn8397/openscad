///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;

///< Parameters
x = 0;
y = 0;
z = 0;

h = 10;
w = 50;
d = 2;

num_leds = 10;
led_pad  = 5;
led_rad  = 2;

///< Modules
module led_frame( width, depth, height ){
     difference(){
     translate( [ x, y, z ] ) cube( [width, depth, height] );
     led_spacing_w = width/( num_leds );
       
     for (i = [0:num_leds]){
	  offset_spacing = (( i * led_spacing_w ) + ( led_spacing_w ));
	  remaining = width - offset_spacing;
	  if( remaining >= led_spacing_w ){
	       translate( [ offset_spacing, 0, height/2 ] )
		    rotate( [ -90, 0, 0 ])
		    color( rand_clr() )
		    cylinder( h = led_pad, d = led_rad * 2, $fn = 30);
	  }
     }
     }
}

///< Build object
led_frame( w, d, h );

