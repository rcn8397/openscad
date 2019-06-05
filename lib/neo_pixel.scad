///< Alitovo Neo pixel RGB X000UCVKBH 2812b-1-LED-WH
use <../lib/math.scad>;
use <../lib/utils.scad>;

///< Parameters - Begin
led_assembly_h = 2.8;
led_assembly_d = 9.6;

///< Diameter of the PCB 
pcb_d = 9.6;
pcb_h = 1.2;

///< Demensions of the LED IC
led_w = 5;
led_d = led_w;
led_h = led_assembly_h - pcb_h;


///< Modules
module pcb(h = pcb_h, d = pcb_d){
     ///< LED PCB definition
     ///< The h/d parameters are passed in to
     ///< allow for socketing of the LEDs.
     color( rand_clr() )cylinder( h=h, d=d, $fn = 30 );
}

module led(){
     ///< Neo pixel LED (2812b-1)
     union(){
         color( rand_clr() )cube( [ led_w, led_d, led_h ] );
         color( rand_clr() )
              translate([led_w/2,led_d/2, 0] )
              cylinder( h=led_h, d= led_w, $fn = 30 );
         }
}

module neo_pixel(h=pcb_h, d=pcb_d){
     ///< Assembly of the led and pcb_pad
     union(){
          translate([-led_w/2,-led_d/2,h-0.01])led();
          pcb(h=h, d=d);
          }

}

///< Build object
///< Remove this when including
//neo_pixel();

