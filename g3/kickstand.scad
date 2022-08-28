///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: Name
   Preamble and description

*/

/*
Parameters
*/

// Back foot length
bk_foot_l = 10; // [0:1:100]

// Back foot height
bk_foot_h = 5; // [0:1:100]

// Front foot length
fr_foot_l = 5; // [0:1:100]

// Front foot length
fr_foot_h = 5; // [0:1:100]

// Foot depth
foot_d = 10;

// Joining space
join_w = 5;
join_h = 5;


// Thread Diameter
thread_type = "M2"; // [ M2, M2.5, M3, M3.5, M4, M5, M6 ]
through_hole_h = 5;

bk_foot_pts = [
               [ 0,         0         ],
               [ bk_foot_l, bk_foot_h ],
               [ bk_foot_l, 0         ],               
               ];

fr_foot_pts = [
               [ 0,         fr_foot_h ],
               [ fr_foot_l, 0         ],
               [ 0,         0         ],
               ];

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}

_hardware = [
             [ "M2",   2   ],
             [ "M2.5", 2.5 ],
             [ "M3",   3   ],
             [ "M3.5", 3.5 ],
             [ "M4",   4   ],
             [ "M5",   5   ],
             [ "M6",   6   ],
             ];
_through_hole_l = bk_foot_l + join_w + fr_foot_l;
_through_hole_h = through_hole_h - hardware( thread_type )/2;


///< Functions
function hardware( type = "M2" ) =
    _hardware[ search( [type], _hardware, 1, 0 )[0]][1];

///< Modules
module foot( pts, d = foot_d  ){
    linear_extrude( d )
        polygon( points = pts );
}

module joiner( w, h, d=foot_d ){
    linear_extrude( d )
       polygon( points = [[ 0,0 ], [0,h], [w,h], [w,0] ]);
}

///< Build object
difference(){
    union(){
        foot( bk_foot_pts );
        translate( [bk_foot_l,0,0] )
        joiner( join_w, join_h );
        translate( [bk_foot_l+join_w,0,0] )
           foot( fr_foot_pts );
    }
    rotate([0,90,0])
        translate( [ -foot_d/2, _through_hole_h, 0] )
            #color("pink")cylinder( h = _through_hole_l, d = hardware(thread_type), $fn = 30 );
}
