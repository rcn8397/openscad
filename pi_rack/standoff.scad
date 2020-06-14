///< Object definition
use <../lib/utils.scad>;

///< Peg parameters
peg_upper_height  = 2;
peg_lower_height  = 1;
peg_flair_radius  = 2;
peg_relief_radius = 1;
peg_gap           = 0.33;

///< Standoff parameters
standoff_height = 2;
standoff_radius = peg_flair_radius;

///< Finish
$fn = 60;

///< Positional data for standoffs
points      = [ [0,0,0], [0,10,0], [20,10,0], [20,0,0] ];
plate_height = 2;

///< Build object
connected_standoffs( points       = points,
		     plate_h      = plate_height,
		     standoff_h   = standoff_height,
		     standoff_r   = standoff_radius,
		     peg_outer_h  = peg_upper_height,
		     peg_lower_h  = peg_lower_height,
		     peg_flair_r  = peg_flair_radius,
		     peg_relief_r = peg_relief_radius,
		     peg_gap      = peg_gap );


///< Modules
module connected_standoffs( points,
			    plate_h,
			    standoff_h,
			    standoff_r, 
			    peg_outer_h,
			    peg_lower_h,
			    peg_flair_r,
			    peg_relief_r,
			    peg_gap = 0.33 ){
     ////< Pulling it together
     plate_bar_1  = [ points[0],points[2]];
     plate_bar_2  = [ points[1],points[3]];
     standoff_pts = adjust_z_offset(points,plate_h );
     union(){
	  connector_plate( plate_bar_1, h = plate_h, d = standoff_r );
	  connector_plate( plate_bar_2, h = plate_h, d = standoff_r );
     }
     foreach_translate( standoff_pts )
	  snap_fit_standoff( stand_off_h     = standoff_h,
			     stand_off_pad_r = standoff_r,
			     peg_upper_h     = peg_outer_h,
			     peg_lower_h     = peg_lower_h,
			     peg_upper_r     = peg_flair_r,
			     peg_lower_r     = peg_relief_r,
			     peg_gap         = peg_gap );
}


///< Create a plate from point to point
module connector_plate(points, h, d ){
     hull()
	  foreach_translate(points)
	  cylinder( h=h, r = d );
}

///< Snapfit stand off
module snap_fit_standoff(stand_off_h,
			 stand_off_pad_r,
			 peg_upper_h,
			 peg_lower_h,
			 peg_upper_r,
			 peg_lower_r,
			 peg_gap = 0.33 ){
     standoff( stand_off_h, stand_off_pad_r );
     translate( [ 0, 0, stand_off_h ] ) peg( top_h = peg_upper_h,
					    bot_h = peg_lower_h,
					    top_r = peg_upper_r,
					    bot_r = peg_lower_r,
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
