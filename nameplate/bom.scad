///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <electronics_box.scad>;
use <frame.scad>;
use <nameplate.scad>;
use <led_frame.scad>;

///< Parameters

box_depth = 20;
box_thickness = 5;
lid_thickness = 5;

///< Build object
//electronics_box( depth = box_depth );

lid();

