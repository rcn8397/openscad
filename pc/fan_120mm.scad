///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/hull.scad>;
use <../lib/cantilever.scad>;
use <../lib/tile2.scad>;
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
fan_thickness = 2.5; // [0:1:5]

// Fan diameter
fan_diameter = 113; // [0:1:113]

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

drive_bay_5_25 = 146.1; // mm (or 5 and 3/4 inches )
wing_w = ( drive_bay_5_25 - fan_w );

///< Modules
module mounting_holes( points = mount_points ){
    for ( p = points ){
        translate( p )
            cylinder( d = mount_hole_dia, h= fan_thickness+2, center = true );
    }
}

module plate(){
    translate([-offset,-offset,0])
        resize( [ fan_w, fan_w, fan_thickness ] )
        rounded_box( points = mount_points, facets = 30 );
}

module fan(){
    cylinder( d = fan_diameter, h = fan_thickness+2, center = true );
}
module braket() {
difference(){
    plate();
    translate( [0,0,fan_thickness/2] ) mounting_holes();
    translate( [fan_w/2,fan_w/2,fan_thickness/2] )fan();
 }
}

module drive_wing(){
    difference(){
        union(){
            translate([-wing_w,0,0])
                cube( [ wing_w, fan_w, fan_thickness ] );
            translate([-wing_w,0,0])
                color("green")cube( [ fan_thickness, fan_w, 20 ] );
        }
        translate([-wing_w+fan_thickness*4,10,1])
            tile( 10, 2, 11 )
            color("red")cylinder( d = 10, h = fan_thickness+2, center = true, $fn = 6 );
    }
    
}

module drive_mounts(){
    point = [fan_w/2,120/4,10];
    rotate_about_pt( 0,90, point )
    translate(point)
        tile( 2, 1, 120/2 ){
        color("pink")
            cylinder( d = 5.0, h = ( fan_w + ( wing_w * 2.0 ) )+5, center = true );
    }
}

module drive_wings(){
    color("cyan")drive_wing();
    translate([fan_w-1,0,0])
    mirror([1,0,0])color("orange")
        drive_wing();        
}

///< Build object
braket();
difference(){
    drive_wings();
    drive_mounts();
}


