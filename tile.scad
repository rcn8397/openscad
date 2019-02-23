///< Honeycomb Generator
use <math.scad>;

///< Cell parameters mm
cell_thickness = 1;
cell_height    = 1;
cell_radius    = 5;

///< Comb parameters mm


///< Modules
module cell( height, radius, thickness=1, open=true ){
       h_adjust = open ? 1 : 0;
       r_adjust = ( radius == thickness ) ? ( radius - ( radius -1 ) ) : thickness;
       difference(){
	cylinder( h=height, r=radius, $fn=6 );
	color("blue",0.75)cylinder( h=height, r=radius-r_adjust, $fn=6 );
	}
}

module tile( rows=1, cols=1, obj_r = 1, pack=true ) {
       ///< Simple HCP latice
       ///< ( https://en.wikipedia.org/wiki/Close-packing_of_equal_spheres#Simple_hcp_lattice )
       cellsize = pack ? obj_r - obj_r * 0.1 : obj_r ;
       
       offset = hyp_from_sides( (cellsize * 2), cellsize );
       for( i = [0:rows-1] ){
       	    for( j = [0:cols-1] ){
	    	 translate( [ ( j * offset ) + ( i % 2 ) * (offset/2 ), i * ( cellsize * 1.5 ), 0 ] )
		 rotate( [0, 0, 90 ] ) ///< Rotate the cells so they are aligned
		 children();
		 }
	}
}



///< Proto type
tile( 3, 2, cell_radius, true) cell( cell_height, cell_radius, cell_thickness );
///< Tile
