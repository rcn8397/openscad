///< Object definition
use <../third_party/MCAD/gears.scad>;

///< Parameters

module chris_gear()
{
    ///< Chris' gear
    difference(){
    union(){
	linear_extrude(height = 5, center = false, convexity = 10, twist = 0)
            gear(number_of_teeth=40,diametral_pitch=1);
        
    	translate([0, 0, 5])
            linear_extrude(height = 5, center = false, convexity = 10, twist = 0)
            gear(number_of_teeth=20,diametral_pitch=1);
    }
    cylinder( h=10+.01, d = 5 );
    }
}


///< Build object
chris_gear();

