///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/hull.scad>;

/*
Module: Bull ring clip
*/

/*
Parameters
*/
// Finish
$fn = 60;

//// Deflector Radius
//deflect_rad       = 1.5;   // [0:0.1:360]
// Receptacle Radius
receptacle_rad    = 10.0;  // [0:1:360]
// Receptacle Base Width
receptacle_base_w = 10.0; // [0:1:500]
// Receptacle Base Depth
receptacle_base_d = 5.0;  // [0:1:500]
// Anchor Base Width
anchor_base_w     = 10.0; // [0:1:500]
// Anchor Base Depth
anchor_base_d     = 5.0;  // [0:1:500]
// Joint Width
joint_w           = 5.0;  // [0:1:500]
// Join Depth
joint_d           = 5.0;  // [0:1:500]
// Thickness
thickness         = 1.0;   // [0:0.1:100]
// Height
height            = 10.0;  // [0:0.01:500]
// Hollow Anchor
hollow_anchor     = false;
// Show Anchor
show_anchor       = true;
// Show Receptacle
show_receptacle   = true;
// Print Mode
print_mode        = false;



///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
deflect_ang    = 45.0;     // [0:0.01:360]
deflect_x      = opposite_side_th( deflect_ang, receptacle_rad );
deflect_y      = adjacent_side_th( deflect_ang, receptacle_rad );
joint_y        = receptacle_rad-0.25-thickness*2-joint_d/4;
anchor_y       = joint_y+joint_d;
deflect_rad    = thickness*1.5;   // [0:0.1:360]


///< Modules
module receptacle(r = receptacle_rad, x = deflect_x, y = deflect_y, h = height, t = thickness ){
    ///< Note: X is not used, but included for completeness
    linear_extrude( height = h ){
        difference(){
            difference(){
                circle( r = r);
                circle( r = (r - t));
            }
            translate( [ -r, deflect_y-t/2, 0 ] )
                #square( [ r*2, r/2 ] );
        }

        translate( [ -t, -r, 0] )
            color("blue")
            square( [ t*2, t*2.125 ] );
    }
}

module receptacle_base( x = 0, y = -receptacle_rad+thickness/2, w = receptacle_base_w, d = receptacle_base_d, h = height ){
    center_line = w/2;
    color("red")
        linear_extrude( height = h ){
        translate( [ x+center_line, y, 0 ] )
            rotate( [ 0, 0, 180 ])
            square( [ w, d ] );
    }
}

module deflection( r = deflect_rad, x = deflect_x, y = deflect_y, h = height, t = thickness ){
    linear_extrude( height = h ){

            translate( [ (x-t/2), y, 0 ] )
            circle( r = r );
    }
}

module deflectors( r = deflect_rad, x = deflect_x, y = deflect_y, h = height, t = thickness ){
    color( "cyan" )
        deflection( r, x, y, h, t);
    mirror([1,,0]){
        color( "cyan" )
            deflection( r, x, y, h, t);
    }
}

module right_angle_mount( x = receptacle_rad, y = -receptacle_rad-receptacle_base_d/2, holes_diameter = 3.5, t = thickness){
    plate_diameter = holes_diameter + thickness*2;
    hole_pts = [
                [-x, y, t/2],
                [ x, y, t/2],
                ];
    plate( hole_pts, plate_diameter, t, holes_diameter);
}

module anchor( r = receptacle_rad, h = height, t = thickness ){
    color("pink")
    linear_extrude( height = h ){
            circle( r = r - t * 2 );
    }
}

module anchor_base( x = 0, y = anchor_y, w = anchor_base_w, d = anchor_base_d, h = height ){
    center_line = w/2;
    color("green")
        linear_extrude( height = h ){
        translate( [ x-center_line, y, 0 ] )
            //rotate( [ 0, 0, 180 ])
            square( [ w, d ] );
    }
}

module right_triangle(x=0, y=0, w = 5,d= 5, h=20, t=thickness){
    pts = [ [x,y],                   // 0 
            [x,y+d],                 // 1 
            [x+w,y+d],               // 2
            ];                       
                                     
    pts2=[  [x+t,y+t],               // 3
            [x+t,y+(d-t)],           // 4 
            [x+(w*(d-t))/d,y+(d-t)], // 5 
            ];
    linear_extrude( height = h ){
        if( hollow_anchor){
            difference(){
                polygon( points = pts );
                color("red")
                    translate( [0, t/2, 0 ] )
                    polygon( points = pts2 );
            }
        }
        else{
            polygon( points = pts );
        }
    }
}

module joint( x=0, y=joint_y, w = joint_w,d=joint_d,h=height,t=thickness){
    color("red")
    union(){
    right_triangle( x, y, w, d, h );
    mirror( [1,0,0])
        right_triangle( x, y, w, d, h );
    }
}

module anchor_mount( x =receptacle_rad, y = height, holes_diameter = 2.5, t = thickness){
    //plate_diameter = holes_diameter + thickness * 2;
    plate_diameter = anchor_base_w;
    z = anchor_base_d + anchor_y-t/2;
    hole_pts = [
                [-x, y/2, -z ],
                [ x, y/2, -z ],
                ];
    rotate( [ 90, 0, 0] )
        plate( hole_pts, plate_diameter, t, holes_diameter);
}

if( show_receptacle ){
    union(){
        receptacle();
        deflectors();
        receptacle_base();
        right_angle_mount();
    }
 }
if( show_anchor && !print_mode ){
    union(){
        anchor();
        joint();
        anchor_base();
        anchor_mount();
    }
 }

if( print_mode ){
    translate( [receptacle_rad*2,0,0] ){
        union(){
            anchor();
            joint();
            anchor_base();
            anchor_mount();
        }
    }
 }
    
