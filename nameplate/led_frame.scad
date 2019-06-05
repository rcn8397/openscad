///< LED frame for the neo pixel array
use <../lib/math.scad>;
use <../lib/utils.scad>;
include <../lib/neo_pixel.scad>

///< Parameters
pcb_socket_d = led_assembly_d + 1;
pcb_socket_h = 1.0;
num_leds     = 10;

led_frame_w  = 150;
led_frame_d  = led_assembly_h+pcb_socket_h;
led_frame_h  = pcb_socket_d+1.5;

///< Modules
module led_frame( width, depth, height ){
     //union(){
     difference(){
          cube( [width, depth, height] );
          led_spacing_w = width/( num_leds );

          ///< Make x number of slots
          for (i = [0:num_leds]){
               offset_spacing = (( i * led_spacing_w ) + ( led_spacing_w ));
               remaining = width - offset_spacing;
               if( remaining >= led_spacing_w ){
                    translate( [ offset_spacing, (pcb_socket_h+0.1), height/2 ] )
                         rotate( [ -90, 0, 0 ])
                         color( rand_clr() )
                         neo_pixel(h=pcb_h+0.1, d=pcb_socket_d);
                    translate( [ offset_spacing, -0.5, height/2 ] )
                        rotate( [ -90, 0, 0 ])
                        color( rand_clr() )
                        cylinder( h=pcb_h+pcb_socket_h, d = pcb_socket_d );
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
