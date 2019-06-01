///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include<nameplate.scad>;
use <../lib/containers.scad>;

box_depth = 50;
box_thickness = 5;
lid_thickness = 5;

module electronics_box( depth = 20, thickness = 5 ){
     ///< Component housing
     components_w = nameplate_w;
     components_d = nameplate_d + depth;
     components_h = nameplate_h;

     hulled_box( w = components_w,
                 d = components_d,
                 h = components_h,
                 t = thickness );
}

module lid( depth = 20, thickness = 5 ){
     ///< Lid
     lid_w = nameplate_w;
     lid_d = nameplate_d + depth;
     lid_h = nameplate_h;

     hulled_box_friction_lid( w = lid_w,
                              d = lid_d,
                              h = lid_h,
                              t = thickness,
                              pr = 50,
                              grip = true );
}

///< prototype
electronics_box( depth = box_depth, thickness = box_thickness );
translate( [ 0, box_depth+lid_thickness, 0 ] )lid( depth = box_depth, thickness = box_thickness );



