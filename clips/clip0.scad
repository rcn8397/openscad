///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: clip0
Bull ring clip
*/

/*
Parameters
*/
// Finish
$fn = 60;

// Deflector Radius
deflect_rad       = 7.0;   // [0:1:360]
// Receptacle Radius
receptacle_rad    = 50.0;  // [0:1:360]
// Receptacle Base Width
receptacle_base_w = 100.0; // [0:1:500]
// Receptacle Base Depth
receptacle_base_d = 10.0;  // [0:1:500]
// Anchor Base Width
anchor_base_w     = 100.0; // [0:1:500]
// Anchor Base Depth
anchor_base_d     = 10.0;  // [0:1:500]
// Joint Width
joint_w           = 50.0;  // [0:1:500]
// Join Depth
joint_d           = 50.0;  // [0:1:500]
// Thickness
thickness         = 5.0;   // [0:1:100]
// Height
height            = 20.0;  // [0:0.01:500]



///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
deflect_ang    = 45.0;     // [0:0.01:360]
deflect_x      = opposite_side_th( deflect_ang, receptacle_rad );
deflect_y      = adjacent_side_th( deflect_ang, receptacle_rad );
joint_y        = receptacle_rad-0.25-thickness*2-joint_d/4;
anchor_y       = joint_y+joint_d;

///< Modules
module receptacle(r = receptacle_rad, x = deflect_x, y = deflect_y, h = height, t = thickness ){
    ///< Note: X is not used, but included for completeness
    linear_extrude( height = h ){
        difference(){
            difference(){
                circle( r = r);
                circle( r = (r - t));
            }
            translate( [ -r, y, 0 ] )
                square( [ r*2, r/2 ] );
        }
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
        difference(){
            polygon( points = pts );
            color("red")
                translate( [0, t/2, 0 ] )
                polygon( points = pts2 );
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


union(){
    receptacle();
    deflectors();
    receptacle_base();
}
union(){
    anchor();
    joint();
    anchor_base();
}
