///< Utilities

function rand_clr() = rands( 0,1,3 );

///< Length conversions
function in2mm( i ) = ( i * 25.4 ); 
function mm2in( m ) = ( m / 25.4 );

/// This is pulled from stackoverflow
/// https://stackoverflow.com/questions/45826208/openscad-rotating-around-a-particular-point

// rotate as per a, v, but around point pt
module rotate_about_pt(z, y, pt) {
    translate(pt)
        rotate([0, y, z ])
            translate(-pt)
                children();   
}

function adjust_z_offset( v, z ) = [for (i=[0:(len(v)-1)]) v[i]+[0,0,z]] ;

///< For each child, translate child by <p> point in points
module foreach_translate(points ){
	for (p=points){
		translate(p) children();
	}
}
