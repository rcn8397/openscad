///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: Name
   Preamble and description
*/

/*
Parameters
*/

$fn = 60;

// Race Parameters
inner_race_x = 10.0; // [0:01:100]
outter_race_x = 20.0; // [0:01:100]
race_w = 5;     // [0:01:100]
race_h = 7;     // [0:01:100]
ball_r = 3.125;   // [0:01:100]


///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}


///< Modules
module bearing( inner_race_x, outter_race_x, w, h, ball_r, num_balls = 12 ){
    race_way = (inner_race_x + (outter_race_x - inner_race_x)/2.0);
    rotate_extrude(){
        difference(){
            union(){
                translate([ inner_race_x, 0, 0 ])
                    square( [w, h], center =true );
                translate([ outter_race_x, 0, 0 ])
                    square( [w, h], center =true );
            }
        translate( [ race_way, 0, 0 ] )circle( ball_r*1.019 );
        }
    }
    ball_tot  = 360;
    ball_step = 360.0/num_balls;
    for( ball = [ 0:ball_step:ball_tot ] ){
        rotate( [ 0, 0, ball ] )
            translate([ race_way, 0, 0 ])
            color("purple")
            sphere( r = ball_r );
    }
}



///< Build bearing
bearing( inner_race_x, outter_race_x, race_w, race_h, ball_r );

