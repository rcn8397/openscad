///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
  Rack Unit overview
  https://en.wikipedia.org/wiki/Rack_unit

  Panel Height:
  1 Rack unit is 1+3/4" ( 44.45mm )
  This less the spacing adjustment of 1/32" ( 0.794mm )

  If n is number of rack units, the ideal formula for panel height is:
  h = ( 1.75n − 0.031) for calculating in inches, and
  h = (44.45n − 0.794) for calculating in millimetres.

  Mounting Holes:
  Threaded holes conform to M6, #12-24 or #10-32

  Width of rail face:
  0.625" ( 15.875mm )

  From zero (origin) the first hole is 0.25" ( 6.35mm ) and  0.5" ( 12.7mm )
  between center points u-to-u.

  From lower mount to center mount 0.625" ( 15.875mm ) and this repeats to the
  top mounting hole.
  https://en.wikipedia.org/wiki/File:Server_rack_rail_dimensions.svg
  */

///< Functions
function panel_height_inch( n = 1 ) = (  1.75 * n - 0.031 );
function panel_height_mm  ( n = 1 ) = ( 44.45 * n - 0.794 );

///< Constants and Parameters
$fn=120;
rail_face_width    = 15.875;
mount_spacing      = 15.875;
hole_1_center      = 6.35;
hole_2_center      = hole_1_center + mount_spacing;
hole_3_center      = hole_2_center + mount_spacing;
hole_x             = rail_face_width/2;
hole_d             = 6.25; ///< M6 screw
hole_r             = hole_d/2;
plate_h            = 3;

mount_points =
     [
     [ hole_x, hole_1_center, 0 ],
     [ hole_x, hole_2_center, 0 ],
     [ hole_x, hole_3_center, 0 ],
     ];


///< Modules
module mounts( r = 1, h = 1, points, rot = [0,0,0] ){
  for( p = points ){
    translate( p ) rotate( rot )cylinder( r = r, h=h);
  }
}

module chamfer( d1, d2, h, points, rot = [0,0,0] ){
  for( p = points ){
    translate( p ) rotate( rot )cylinder(d1=d1, d2=d2, h=h);
  }
}

module rack_mount( r, h , p, pad = 1 ){
     difference(){
          hull() mounts( r = r+pad, h = h, points = p );
          mounts( r = r, h = h, points = p );
          }
}

module cutout( w, d, h, pad, center = false ){
    hull(){
        cylinder( d=w*0.90, h=d+pad, center = center );
        translate( [ 0,d,0 ] )
            cylinder( d=w*0.90, h=d+pad, center = center );
    }
}

module kvm_1u_mount( r, plate_thickness, points, w, d, h, chmf = [ 12, 20 ], pad = 2.5 ){
    shell_w = w + pad;
    shell_h = h + pad;
    shell_d = d + pad;

    difference(){
        union(){
            difference(){
                difference(){
                    color("red") cube( [ shell_w, shell_d, shell_h ] );
                    translate( [ pad/2, pad/2, pad ] )
                        color("cyan") cube( [ w, d, h ] );
                }
            }
        }
        translate( [ -pad/2, d/2, h/2 ] )
            rotate( [ 0,90,0 ] )
            cylinder( d = d*0.75, w+pad*2, true );
        translate( [ w/2+pad/2, 0, h/4-pad*2 ] )
            rotate( [-90,180,0] )
            cutout(w,d,h, pad, false);
        translate( [ w/2-r*2, d/4-pad*2, 0 ] )        
            mounts( r, pad, points );
    }
}

///< Build object
kvm_1u_mount(
               r               = hole_r,
               plate_thickness = plate_h,
               points          = mount_points,
               w = 20.00,
               d = 84.00,
               h = 75.66
               );
