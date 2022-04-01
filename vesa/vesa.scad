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
$fn = 60;

// VESA modes
vesa_mode = "VESA100"; // [ VESA75, VESA100, VESA200, VESA400 ]

// Thread Diameter
thread_d = 3; // [ 0: 0.1: 10]

// Height
height = 4; // [ 0: 0.1: 30 ]

// Plate Width
plate_w = 20; // [0: 1: 50 ]

// Center Plate
center_plate = true;

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
_modes = [
          ["VESA75",   75 ],
          ["VESA100", 100 ],
          ["VESA200", 200 ],
          ["VESA400", 400 ],
          ];

_hardware = [
             [ "M2",   0 ],
             [ "M2.5", 0 ],
             [ "M3",   0 ],
             [ "M4",   0 ],
             [ "M5",   0 ],
             [ "M6",   0 ],
             ];

function variations( mode = "VESA400" )=
    _modes[ search( [mode], _modes, 1, 0)[0]][1];

module cylinders( pts, d, h ){
    for( p = pts ){
        translate( p )
            cylinder( h = h, d = d, center = true );
    }
}

module plate( pts, d, h, hole_d ){
    difference(){
        hull(){
            cylinders( pts, d, h );
            cylinders( pts, hole_d, h );
        }
    }
}

///< Modules
module vesa( mode, thread_d = thread_d,  width = plate_w, h = height, center_plate = true ){
    points = [
              /* Plate 1 */
              [ 0,    0,    0 ],
              [ mode, mode, 0 ],

              /* Plate 2 */
              [ 0,    mode, 0 ],
              [ mode, 0,    0 ],
              ];
    plate1 = [
              points[0],
              points[1]
              ];
    plate2 = [
              points[2],
              points[3]
              ];
    

    difference(){
        union(){
            plate( plate1, width, h, thread_d );
            plate( plate2, width, h, thread_d );
            if( center_plate ){
                mid = mid_pt_2d( points[2], points[3] );
                echo( "Mid", mid );
                translate([mode/2,mode/2,-h/2])
                    linear_extrude( height = h )
                    color( "cyan" ) #square( mid[0], center = true );
            }
        }
        for( pt  = points )
            translate( pt )
                translate([0,0,-h/2])
                #cylinder( h = h, d = thread_d, true );
    }
        

    
}

///< Build object
mode = variations( vesa_mode );
echo( "Variation: ", vesa_mode, mode );
vesa( variations( vesa_mode ) );

