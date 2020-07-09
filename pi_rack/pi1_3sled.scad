/// Sled3
use <../lib/hull.scad>;
use <../lib/basics.scad>;
use <../lib/utils.scad>;
use <../lib/tile2.scad>;
use <pi_zero_1v3_footprint.scad>
use <standoff.scad>
///< Parameters
height = 4;
width  = 61.69; ///61.77
///length = 1.5*width; ///< 92.535
length =  92.535;

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
standoff_height = 4;
standoff_radius = 3.5;

///< Finish
$fn = 60;

///< Positional data for standoffs
hole0 = [      3.5,      3.5, 0 ];
hole1 = [ 65 - 3.5,      3.5, 0 ];
hole2 = [ 65 - 3.5, 30 - 3.5, 0 ];
hole3 = [      3.5, 30 - 3.5, 0 ];

points      = [ hole0, hole1, hole2, hole3 ];
plate_height = 4;

///< Build object
translate( [ -hole1[0]/2, -hole2[1]/2,height-plate_height ] )
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

tile_radius = 6;
difference(){
    difference(){
    union(){
    import("pi1tray.stl" );
    ///< example
    translate([10-length/2,1-width/2,0])sled_fill(length-10,width-2,height);
    }
    translate([10-length/2,1-width/2,height])sled_fill(length-10,width-2,height);
    }
translate( [ -length/2 + 18,-width/2+10,0] )
tile( 5, 6, tile_radius * 2, true, rot=30 ) cylinder( r = tile_radius, h = height, $fn=6);
}

///< Def
module sled_fill( h, w, d ){
    color(rand_clr())cube([ h, w , d ]);
}
