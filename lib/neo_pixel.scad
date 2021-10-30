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
    color( rand_clr() )cylinder( h=h, d=d, center = true, $fn = 30 );
}

module led(){
     ///< Neo pixel LED (2812b-1)
     union(){
         color( rand_clr() )cube( [ led_w, led_d, led_h ], center = true );
         color( rand_clr() )
             cylinder( h=led_h, d= led_w, center = true, $fn = 30 );
         }
}

module neo_pixel(h=pcb_h, d=pcb_d){
     ///< Assembly of the led and pcb_pad
     union(){
         translate([0,0,h-0.01])led();
          pcb(h=h, d=d);
          }

}

module pixel_clip_v1(lead_d = 1, foot_t = 2){
    width = pcb_d/2+pcb_d/2+led_w;
    zmag  = (led_h+lead_d/2);
    module retainer_qrt(){
        translate([pcb_d/2,0,0])
            cube( [ pcb_d/2, pcb_d,led_h ], center=true );
        translate([-pcb_d/2,0,0])
            cube( [pcb_d/2, pcb_d, led_h ], center=true );
    }
    translate([0,0,pcb_h])
        retainer_qrt();
    translate([0,0,-zmag ])
        retainer_qrt();

    translate([-width/2,-pcb_d/2-foot_t/2,-zmag-led_h/2 ])
        color("red")cube([width, foot_t, led_h+lead_d/2+led_h+pcb_h]);
}
///< Build object
///< Remove this when including
difference(){
    pixel_clip_v1();
    #neo_pixel();
}
