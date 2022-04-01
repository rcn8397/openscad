/*
Module: Vector-Board
Parametric approach to 3d printing vector boards for fun

Based on source information found @
https://media.digikey.com/pdf/Data%20Sheets/Vector%20PDFs/8022_Web.pdf
*/

/*
Parameters
*/

$fn = 60;

/* Board Dimensions */

// Board length 3.50" (88.9mm)
board_l = 88.9; // [0:0.01:250]

// Board width 3.00" (76.2mm)
board_w = 76.2; // [0:0.01:250]

// Board thickness 0.062" (1.57mm)
board_t = 1.57; // [0:0.01:10]

// Pitch 0.100" (2.54mm)
pitch = 2.54; // [0:0.01:10]

// Hole Diameter 0.042" (1.07mm)
hole_d = 1.60; // [0:0.001:5]
///<hole_d = 1.067; // [0:0.001:5]

// Edge Padding
padding = 1.25; // [0:0.01:10]

// Rounded Corners
rounded = true;

/* Mounting Parameters */

// Mounting Holes
use_mounting_holes = true;

// Mounting Holes Diamter
mounting_hole_d = 3.0; // [0:0.01:10]


///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}


///< Modules
module hole_grid( rows = 1, columns = 1, p = pitch, d = hole_d ){
    grid_l = ( ( columns -1  ) * p )- d/2;
    grid_w = ( ( rows - 1    ) * p )- d/2;
    ///< Center the grid
    translate([-grid_w/2,
               -grid_l/2,
               0])
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
        translate( pt ) circle( d = d );
    }
}

module vector_board( l       = board_l,
                     w       = board_w,
                     t       = board_t,
                     p       = pitch,
                     mounts  = true,
                     mount_d = 3,
                     padding = 2.5,
                     rounded = true,
                     print_mnt_pts = true
                     ){

    pad     = padding + mount_d/2;
    rows    = ( ( l - padding*2 ) /p ) - 2;
    columns = ( ( w - padding*2 ) /p ) - 2;
    mounting_hole_pts = [
                         [-(l/2)+pad, -(w/2)+pad, 0],
                         [-(l/2)+pad,  (w/2)-pad, 0],
                         [ (l/2)-pad,  (w/2)-pad, 0],
                         [ (l/2)-pad, -(w/2)+pad, 0],
                         ];

    if( print_mnt_pts ){
        echo( "pts: ", mounting_hole_pts );    
    }
    linear_extrude( height = t ){
        difference(){
            board(l,w,rounded);
                #hole_grid( rows, columns );
            if( mounts ){
            #mounting_holes( pts = mounting_hole_pts, mount_d );
            }
        }
    }
}

///< Build object
vector_board(l = board_l, w = board_w, p = pitch, mounts = use_mounting_holes, mount_d = mounting_hole_d, padding = padding, rounded = rounded );
