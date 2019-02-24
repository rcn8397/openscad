///< Coster.scad
use <tile2.scad>
use <honeycomb.scad>
use <math.scad>
///< coaster parameters
module coaster( rad, height ){
          
     cell_r = 5;
     row    = 5;
     col    = 4;
     width  = cell_r*2;
     ystep  = ( a_from_hb( width, cell_r ) * (row -1 ) );
     xstep  = ( width * (col - 1) + ( ( (row-1)%2) * cell_r ) );
     translate([ xstep,ystep,0])
	  color("red")cylinder(r = 1, h = 10 );//cylinder( r=rad, height );
     xyz = mid_pt_2d( [xstep, ystep], [0,0] );
     translate(xyz)
	  color("blue")cylinder(r = 1, h = 10 );//cylinder( r=rad, height );

     tile( row, col, width, true, rot=30 ) cell(2, width/2, 1 );


}


coaster(5, 2);
