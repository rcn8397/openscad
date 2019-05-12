///< Coster.scad
use <../lib/tile2.scad>
use <../lib/math.scad>

$fn=60;

///< Cellular pattern params
cell_rows   = 10;
cell_cols   = 9;
cell_radius = 5;

///< coaster parameters
coaster_r   = 40;
coaster_h   = 4;
coaster_c   = [cell_radius, cell_rows, cell_cols];
coaster_l   = 2;

coaster(coaster_r, coaster_h, coaster_c, coaster_l);

//ring( coaster_r, coaster_h );

module lip_ring( rad, height ){
    difference(){
    cylinder( r = rad, h = height );
    translate([0,0,-0.0009])color([1,0,0])cylinder( r = rad-1, h = height+1 );
    }
}

///< Module
module coaster( rad, height, cellular = [5,10,10], lip_height=2 ){
          
     cell_r = cellular[0];
     row    = cellular[1];
     col    = cellular[2];
     width  = cell_r*2;
     ystep  = ( a_from_hb( width, cell_r ) * (row -1 ) );
     xstep  = ( width * (col - 1) + ( ( (row-1)%2) * cell_r ) );

     ///< Place the cylinder in the center of the grid
     xyz = mid_pt_2d( [xstep, ystep], [0,0] );

     union(){
         translate(xyz - [0,0,+height])rotate([180,0,0])
            lip_ring( rad, lip_height );
         
         difference(){
    	  translate(xyz)rotate([180,0,0])
    	       color("red")cylinder( r = rad, h = height );
    	  translate( xyz - [0,0,height] )
             	  color("blue",0.5)cylinder(r = rad-1, h = height-1 );
         }
         translate([0,0,-height])
         difference(){
    	  translate( xyz )
    	       color("green")cylinder(r = rad, h = height);
             tile( row, col, width, true, rot=30 ) cylinder( r = width/2, h = height, $fn=6);
         }
     }
}


