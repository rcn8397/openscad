/*
Module: WS2812B LED strip
BTF Lighting WS2812b 5050smd LED 3.3ft 144 (2x72) pixel strips
https://www.amazon.com/gp/product/B01CDTEJR0/

https://cdn-shop.adafruit.com/datasheets/WS2812.pdf
*/

/*
Parameters
*/

// Finish/Quality
$fn = 90; // [0:90:120]

// Number of LEDs in the strip
num_leds  = 4; // [0:1:72]

// Pitch of the LEDs
led_pitch = 1.92; // [0:0.01:25]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}

// WS2812B
ws2812b_w = 5.0;
ws2812b_d = 5.0;
ws2812b_h = 1.57;

solder_pad_w = 1.5;
solder_pad_d = 1.0;
solder_pad_h = 0.25;

ws2812_package_w = 5.4;
pad_span_d       = 4.2;
pad_pitch        = 0.6;
pad_x_offset     = ( ws2812_package_w - ws2812b_w )/2;
pad_x            = ( ws2812b_w/2 ) - ( solder_pad_w/2 ) + pad_x_offset;
pad_y_offset     = ( ws2812b_d-pad_span_d );
pad_y            = ws2812b_d/2-pad_y_offset;


// Strip Width
strip_d = 12;   // [0:0.01:15]
strip_h = 2.13 - ws2812b_h; // [0:0.01:5]

///< Modules
module ws2812b(center = true, show_pads = true ){
    color("white")cube( [ws2812b_w, ws2812b_d, ws2812b_h], center = center );
    color("yellow")cylinder( h = ws2812b_h, d = ws2812b_w*0.90, center = center );

    module pad(){
        color("silver")cube( [ solder_pad_w, solder_pad_d, solder_pad_h ], center = center );
    }

    module pads(side = 1){
        //< Side 1 or -1
        translate([side * pad_x ,pad_y, -ws2812b_h/2]) pad();
        translate([side * pad_x ,0,     -ws2812b_h/2]) pad();
        translate([side * pad_x ,-pad_y,-ws2812b_h/2]) pad();
    }

    if( show_pads ){
        pads();
        pads(-1);
    }
}


function ribbon_w( n = 1, p = 1 ) = ( (n+1)*p ) + (n*ws2812b_w) ;

module strip( n = num_leds, pitch = 1, center = true ){

    for( i = [0:n-1] ){
        x = i * ( pitch + ws2812b_w );
        translate([x,0,solder_pad_h])
            ws2812b(center);
    }
    strip_w = ribbon_w(n, pitch);
    adjust  = strip_w/2 - ws2812b_w;
    translate([ adjust, 0, -ws2812b_h/2 ] )
        color("black")cube( [ strip_w, strip_d, strip_h ], center = center );
}

///< Build object
strip(num_leds, led_pitch);

