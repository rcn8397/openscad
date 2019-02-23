///< Honeycomb Generator


thickness = 1;
height    = 5;
radius    = 3;

module cell( height, radius, thickness=1, open=true ){
       h_adjust = open ? 1 : 0;
       r_adjust = ( radius == thickness ) ? ( radius - ( radius -1 ) ) : thickness;
       difference(){
	cylinder( h=height, r=radius, $fn=6 );
	color("blue",0.75)cylinder( h=height, r=radius-r_adjust, $fn=6 );
	}
}

cell( height, radius, thickness );

