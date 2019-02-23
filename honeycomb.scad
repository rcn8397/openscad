///< Honeycomb Generator


thickness = 1;
height    = 5;
radius    = 1;

module cell( height, radius, thickness=1, open=true ){
       h_adjust = open ? 1 : 0;
       difference(){
	cylinder( h=height, r=radius, $fn=6 );
	color("blue")cylinder( h=height, r=radius-thickness, $fn=6 );
	}
}

///cell( height, radius, thickness );

cell( 1, 2, 1 );