///< Coster.scad
use <tile2.scad>
use <honeycomb.scad>
use <math.scad>
///< coaster parameters
debug=false;

///< Module
module coaster( rad, height, open = true ){
          
     cell_r = 2;
     row    = 7;
     col    = 7;
     width  = cell_r*2;
     ystep  = ( a_from_hb( width, cell_r ) * (row -1 ) );
     xstep  = ( width * (col - 1) + ( ( (row-1)%2) * cell_r ) );
     if( debug ){
     translate([ xstep,ystep,0])
	  color("red")cylinder(r = 1, h = 10 );
     }
     ///< Place the cylinder in the center of the grid
     xyz = mid_pt_2d( [xstep, ystep], [0,0] );
     difference(){
	  translate(xyz)
	       color("red")cylinder( r = rad, h = height );
         difference(){
	  translate( xyz - [0,0,2] )
         	  color("blue")cylinder(r = rad-1, h = height-1 );
             tile( row, col, width, true, rot=30 ) cell(5, width/2, 1, open );
         }
     }
}


coaster(10, 5, true);
