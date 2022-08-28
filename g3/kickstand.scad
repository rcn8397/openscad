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
foot_d = 5;

// Joining Width
join_w = 5; // [0:1:100]
// Joining Height
join_h = 5; // [0:1:100]


// Thread Diameter
thread_type = "M2"; // [ M1, M1.5, M2, M2.5, M3, M3.5, M4, M5, M6 ]

// Through hole height
through_hole_h = 5; // [0:1:20]

// Nut Width
nut_w = 10; // [0:1:100]

// Nut Height
nut_h = 4; // [0:1:100]


// Wall thickness
thickness = 1; // [0:1:100]

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
             [ "M1",   1   ],             
             [ "M1.5", 1.5 ],             
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
_nut_d = foot_d - thickness;
// Bezel Width
_bezz_w = join_w-thickness*2; // [0:1:100]

// Bezel Height
_bezz_h = join_h; // [0:1:100]


///< Functions
function hardware( type = "M1" ) =
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

module cutaway( w, h, d = 4 ){
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

    // Back Nut

    translate( [ bk_foot_l, thickness, thickness/2 ] )#color("red")cutaway( -1*(nut_w), nut_h, d = _nut_d );

    // Front Nut
    translate( [ (bk_foot_l+join_w), thickness, thickness/2 ] )#cutaway( nut_w, nut_h, d = _nut_d );

    // Bezzel gap
    translate( [bk_foot_l+thickness,thickness, -thickness] )
        #color( "cyan" )cutaway( _bezz_w, _bezz_h, d = foot_d + thickness * 2 );
    
}
