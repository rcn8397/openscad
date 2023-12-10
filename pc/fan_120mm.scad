///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/hull.scad>;


/*
Module: P12 Series Arctic 120mm fan

2D drawing:
https://support.arctic.de/products/p12-tc/techdocs/P12%20Series%20-%202D%20Drawing.pdf

*/

/*
Parameters
*/

$fn = 60;

// Fan width
fan_w = 120; // [0:1:120]

// Fan height
fan_h = 120; // [0:1:120]

// Fan depth
fan_d = 25; // [0:1:25]

// Fan thickness
fan_thickness = 5; // [0:1:5]

fan_cutout = 113; // [0:1:113]

// distance from the center of mounting holes
hole_offset = 105; // [0:1:105]

// mounting hole diamater
mount_hole_dia = 4.40; // [0:0.1:5]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}

offset = 7.5;
x = offset;
y = offset;
mount_points = [
                [x,               y,               0],
                [x + hole_offset, y,               0],
                [x,               y + hole_offset, 0],
                [x + hole_offset, y + hole_offset, 0],
                ];

///< Modules
module mounting_holes( points = mount_points ){
    for ( p = points ){
        translate( p )
            cylinder( d = mount_hole_dia, h= fan_thickness+2, center = true );
    }
}


module bracket(){
    translate([-offset,-offset,0])
        resize( [ fan_w, fan_w, fan_thickness ] )
        rounded_box( points = mount_points, facets = 30 );
}

///< Build object


difference(){
bracket();
translate( [0,0,fan_thickness/2] ) mounting_holes();
}

