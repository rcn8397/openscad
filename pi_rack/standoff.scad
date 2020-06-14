///< Object definition
//use <../lib/math.scad>;
use <../lib/utils.scad>;
//use <../lib/hull.scad>;

///< Parameters
x = 0;
y = 0;
z = 0;

///< Peg parameters
peg_outer_cyl_h = 2;
peg_inner_cyl_h = 1;
peg_cyl_r       = 2;
peg_relief_r    = 1;
peg_gap         = 0.33;

///< Standoff parameters
standoff_h = 2;
standoff_r = peg_cyl_r;

///< Finish
$fn = 60;

///< Positional data for standoffs
points = [ [0,0,0], [0,10,0], [20,10,0], [20,0,0] ];
plate_h      = 2;

	 
plate_bar_1  = [ points[0],points[2]];
plate_bar_2  = [ points[1],points[3]];
standoff_pts = adjust_z_offset(points,plate_h );

///< Build object
union(){
     connector_plate( plate_bar_1, h = plate_h, d = standoff_r );
     connector_plate( plate_bar_2, h = plate_h, d = standoff_r );
}
foreach_translate( standoff_pts ) snap_fit_stand_off();


///< Modules
module connector_plate(points, h, d ){
     hull()
	  foreach_translate(points)
	  cylinder( h=h, r = d );

}

module snap_fit_stand_off(){
     standoff( standoff_h, standoff_r );
     translate( [ 0, 0, standoff_h ] ) peg( top_h = peg_outer_cyl_h,
					    bot_h = peg_inner_cyl_h,
					    top_r = peg_cyl_r,
					    bot_r = peg_relief_r,
					    sep_w = peg_gap );
}


module standoff( h, r ){
     ///< Named cylinder
     color( rand_clr() )cylinder( h = h, r = r );
}

module peg( top_h, bot_h, top_r, bot_r, sep_w = 0.5 ){
     ///< Peg
     tot_h = top_h + bot_h;
     sep = top_r * sep_w;

     difference(){
	 difference(){
	     union(){
		 cylinder( h = bot_h, r = bot_r );
		 translate( [0,0,bot_h] )
		     cylinder( h = top_h, r1 = top_r, r2 = bot_r );
	     }
	     translate( [ 0,0, 0.10 * tot_h + tot_h/2 ] )
		 color( rand_clr()) cube( [ sep, 2 * top_r, tot_h ], true );
	 }
	 translate( [ 0,0, 0.10 * tot_h ] )
	     color( rand_clr() )cylinder( h = tot_h, r = bot_r * 0.8 );
     }
}
