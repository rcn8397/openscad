///< Object definition
use <standoff.scad>;

/*Raspberry Pi Zero, Pi Zero W, Pi Zero WH (v1.3)
  From:
  https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/README.md

  Board layout:
  https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi_MECH_Zero_1p3.pdf
*/

///< All Holes M2.5
///< The actual diameter is 2.4mm
m25_radius = 2.4/2.0;

///< Peg parameters
peg_upper_height  = 0.8;
peg_lower_height  = 2;
peg_flair_radius  = m25_radius;
peg_relief_radius = m25_radius * 0.90;
peg_gap           = 0.75;
peg_wall_percent  = 0.6;

///< Standoff parameters
standoff_height = 1;
standoff_radius = 3.5;

///< Finish
$fn = 60;

///< Positional data for standoffs
hole0 = [      3.5,      3.5, 0 ];
hole1 = [ 65 - 3.5,      3.5, 0 ];
hole2 = [ 65 - 3.5, 30 - 3.5, 0 ];
hole3 = [      3.5, 30 - 3.5, 0 ];

points      = [ hole0, hole1, hole2, hole3 ];
plate_height = 1;

///< Build object
connected_standoffs( points       = points,
		     plate_h      = plate_height,
		     standoff_h   = standoff_height,
		     standoff_r   = standoff_radius,
		     peg_outer_h  = peg_upper_height,
		     peg_lower_h  = peg_lower_height,
		     peg_flair_r  = peg_flair_radius,
		     peg_relief_r = peg_relief_radius,
		     peg_gap      = peg_gap,
                     peg_wall_per= peg_wall_percent);


