///< Utilities

function rand_clr() = rands( 0,1,3 );

///< Length conversions
function in2mm( i ) = ( i * 25.4 ); 
function mm2in( m ) = ( m / 25.4 );

/// This is pulled from stackoverflow
/// https://stackoverflow.com/questions/45826208/openscad-rotating-around-a-particular-point

// rotate as per a, v, but around point pt
module rotate_about_pt(a, v, pt) {
    translate(pt)
        rotate(a,v)
            translate(-pt)
                children();   
}

///< For each child, translate child by <p> point in points
module foreach_translate(points ){
	for (p=points){
		translate(p) children();
	}
}
