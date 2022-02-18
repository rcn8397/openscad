/*
Module: Vector-Board
Parameteric approach to 3d printing vector boards for fun
*/

/*
Parameters
*/

function in2mm( i ) = ( i * 25.4 ); 
function mm2in( m ) = ( m / 25.4 );

$fn = 60;

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

// Edge Padding
padding = 1.0; // [0:0.01:10]

// Mounting Holes
use_mounting_holes = true;

// Mounting Holes Diamter
mounting_hole_d = 3.0; // [0:0.01:10]

// Rounded Corners
rounded = true;

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}


///< Modules
module hole_grid( rows = 1, columns = 1, p = pitch, d = hole_d, t = board_t ){
    for( col = [0:columns-1] ){
        for( row = [0:rows-1] ){
            y = ( col * pitch );
            x = ( row * pitch );
            translate( [ x, y, 0 ] )
                circle( d = d );
        }
    }
}

module board( l, w, rounded ){
    if( rounded ){
        offset(3) offset(-3)square( [ l, w ], center = true );
    }else{
        square( [ l, w ], center = true );
    }
}

module mounting_holes( pts, d = 3 ){
    for( pt = pts ){
        translate( pt ) circle( d );
    }
}

module vector_board( l       = board_l,
                     w       = board_w,
                     t       = board_t,
                     p       = pitch,
                     mounts  = true,
                     mount_d = 3,
                     padding = 2.5,
                     rounded = true
                     ){

    pad     = padding + mount_d;
    x       = ( ( l - pad*2 -p ) /2 );
    y       = ( ( w - pad*2 -p ) /2 );
    rows    = ( ( l - pad*2 ) /p ) - 2;
    columns = ( ( w - pad*2 ) /p ) - 2;
    mounting_hole_pts = [
                         [-(l/2)+pad, -(w/2)+pad, 0],
                         [-(l/2)+pad,  (w/2)-pad, 0],
                         [ (l/2)-pad,  (w/2)-pad, 0],
                         [ (l/2)-pad, -(w/2)+pad, 0],
                         ];

    linear_extrude( height = t ){
        difference(){
            board(l,w,rounded);
            translate([-x+pitch,-y+pitch,0])
                hole_grid( rows, columns  );
            if( mounts ){
            #mounting_holes( pts = mounting_hole_pts, mount_d );
            }
        }
    }
}

///< Build object
vector_board(l = board_l, w = board_w, p = pitch, mounts = use_mounting_holes, mount_d = mounting_hole_d, padding = padding, rounded = rounded );

//hole_grid(3, 3);
