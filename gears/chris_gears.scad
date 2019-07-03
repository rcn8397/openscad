///< Object definition
use <../third_party/MCAD/gears.scad>;
use <../lib/math.scad>;
use <../lib/utils.scad>;

///< Parameters
teeth  = 42;
hole_d = 4.5;
height = 4;

///< Diameter
///< d = c/pi
width  = 21; ///< 22 original?
pi     = 3.14159;
///< Thus circumfrence = d * pi or 2piR
circ_mm = width * pi; ///< in mm
circ_in = mm2in( circ_mm );
echo( circ_in, circ_mm );
pitch_diameter  = 20;
diametral_pitch = teeth/pitch_diameter;

///< Quality
$fn = 60;

module chris_gear( h, w, teeth, hole_d )
{
    ///< Chris' gear
    difference(){
    union(){
	linear_extrude(height = h, center = false, convexity = 10, twist = 0)
	     gear(number_of_teeth=teeth,
		  diametral_pitch=diametral_pitch);

	wall_thickness = 2;
	translate([0, 0, h])
	     cylinder( h = h, d = hole_d + wall_thickness );
    }
    cylinder( h=10+.01, d = 5 );
    }
}

///< Build object
chris_gear( height, width, teeth, hole_d);
