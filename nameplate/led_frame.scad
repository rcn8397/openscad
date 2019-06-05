///< LED frame for the neo pixel array
use <../lib/math.scad>;
use <../lib/utils.scad>;
include <../lib/neo_pixel.scad>

///< Parameters
pcb_socket_d = led_assembly_d + 1;
pcb_socket_h = 1.0;

led_frame_w  = 203;
led_frame_d  = led_assembly_h+pcb_socket_h;
led_frame_h  = pcb_socket_d+1.5;

///< Modules
module led_frame( w, d, h, num_leds = 10 ){
//     union(){
     difference(){
          cube( [w, d, h] );
          led_spacing_w = w/( num_leds );

          ///< Make x number of slots
          for (i = [0:num_leds]){
               offset_spacing = (( i * led_spacing_w ) + ( led_spacing_w ));
               remaining = w - offset_spacing;
               if( remaining >= led_spacing_w ){
		    translate( [ offset_spacing, (h+0.1), h/2 ] )
                         rotate( [ 90, 0, 0 ])
                         color( rand_clr() )
                         neo_pixel( h=h, d=pcb_socket_d);
               }
          }
     }
}

///< Build object
//echo( "Led_Frame height:",
//      led_frame_h,
//      "depth:",
//      led_frame_d,
//      "width:",
//      led_frame_w );
//led_frame( led_frame_w, led_frame_d, led_frame_h );
led_frame( led_frame_w, led_frame_d, led_frame_h );
