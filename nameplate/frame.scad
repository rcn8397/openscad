///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <led_array.scad>;
include <nameplate.scad>

///< Parameters
esp8266_h = 10;

module frame( w, d, h, pad = 6.5, show_nameplate = false ){

     ///< Frame demensions
     frame_clearance = 0.01;
     frame_p = pad + frame_clearance; //< Padding
     frame_w = w + frame_p;
     frame_d = d + frame_p;
     frame_h = h + frame_p;

     frame = [ frame_w, frame_d, frame_h ];
     frame_inset = [0, frame_p/2, frame_p/2 ];
     nameplate_cut = [ ( frame_w + ( frame_p * 2.0 ) ) * 1.01,
                       d * 1.01,
                       h * 1.01 ];

     view_w = frame_w;
     view_d = d + pad;
     view_h = h - ( frame_p);
     view_cut = [ view_w, view_d, view_h ];

     ///< c-clamp
     difference(){
         color( rand_clr() )cube( frame );
         color( "orange" )translate( frame_inset )Nameplate( nameplate_cut );
         color( "red" )
             translate( [ 0, frame_d/2, frame_p ] )
             mirror( [ 0, 1, 0 ] )cube( view_cut );
         translate( [ pad/2, ( pad ), pad/2 ] )
             led_array( w, d, h );
     }

     
}

module shell( w, d, h, pad = 5 ){
     shell_w = w + pad;
     shell_d = d + pad;
     shell_h = h + pad;

     cube( [ pad, d, shell_h ] );
     translate( [ shell_w-pad, 0, 0 ] )
	  cube( [ pad, d, shell_h ] );
     translate( [ 0, d, 0 ] )
	  cube( [ shell_w, pad, shell_h ] );
     cube( [ shell_w, d, pad ] );
}

///< Build object

echo( nameplate_w, nameplate_d, nameplate_h  );
frame( nameplate_w, nameplate_d, nameplate_h  );
//translate( [ 0, nameplate_d+5, 0 ] ){
//     shell( nameplate_w, esp8266_h, nameplate_h  );}
