/*
Module: Vector-Board
Parameteric approach to 3d printing vector boards for fun
*/

/*
Parameters
*/

function in2mm( i ) = ( i * 25.4 ); 
function mm2in( m ) = ( m / 25.4 );

$fn = 90;

// Board length 3.50" (88.9mm)
board_l = 88.9; // [0:0.01:500]
// Board width 3.00" (76.2mm)
board_w = 76.2; // [0:0.01:500]
// Board thickness 0.062" (1.57mm)
board_t = 1.57; // [0:0.01:10]

// Pitch 0.100" (2.54mm)
pitch = 2.54; // [0:0.01:10]


// Hole Diameter 0.042" (1.07mm)
hole_d = 1.07; // [0:0.01:10]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}


///< Modules
module grid( rows = 1, columns = 1, p = pitch, d = hole_d, t = board_t, center = true ){
    for( col = [0:columns-1] ){
        for( row = [0:rows-1] ){
            y = ( col * pitch );
            x = ( row * pitch );
            translate( [ x, y, 0 ] )
                cylinder( h = t, d = d, center = center );
        }
    }
}

module board( l = board_l, w = board_w, t = board_t, center = true ){
    cube( [l, w, t], center = center );
    x = l/2;
    y = w/2;
    rows = (board_l/pitch)-1;
    columns = (board_w/pitch)-1;
    translate([-x+pitch,-y+pitch,board_t])grid( rows, columns );
}

///< Build object
board(); 

//grid(3, 3);
