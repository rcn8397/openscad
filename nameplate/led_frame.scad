///< LED frame for the neo pixel array
use <../lib/math.scad>;
use <../lib/utils.scad>;
include <../lib/neo_pixel.scad>

///< Parameters
frame_w = 150;
frame_d = led_assembly_h-led_assembly_h*0.2;
frame_h = led_assembly_d+1;

num_leds = 10;

///< Modules
module led_frame( width, depth, height ){
     difference(){
          cube( [width, depth, height] );
          led_spacing_w = width/( num_leds );

          for (i = [0:num_leds]){
               offset_spacing = (( i * led_spacing_w ) + ( led_spacing_w ));
               remaining = width - offset_spacing;
               if( remaining >= led_spacing_w ){
                    translate( [ offset_spacing, -0.1, height/2 ] )
                         rotate( [ -90, 0, 0 ])
                         color( rand_clr() )
                         neo_pixel();
               }
          }
     }
}

///< Build object
led_frame( frame_w, frame_d, frame_h );
