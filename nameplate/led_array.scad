///< LED frame for the neo pixel array
use <../lib/math.scad>;
use <../lib/utils.scad>;
include <../lib/neo_pixel.scad>

///< Parameters
pcb_socket_d = led_assembly_d + 1;
pcb_socket_h = 1.0;

led_array_w  = 100;
led_array_d  = led_assembly_h+pcb_socket_h;
led_array_h  = pcb_socket_d+1.5;

///< Modules
module led_array( w, d, h, num_leds = 10 ){
    led_spacing_w = (w - 0.125)/( num_leds );

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

///< Build object
led_array( led_array_w, led_array_d, led_array_h );
