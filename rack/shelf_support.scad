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
$fn=30;
rail_face_width    = 15.875;
mount_spacing      = 15.875;
hole_1_center      = 6.35;
hole_2_center      = hole_1_center + mount_spacing;
hole_3_center      = hole_2_center + mount_spacing;
hole_x             = rail_face_width/2;
hole_d             = 6.25; ///< M6 screw
hole_r             = hole_d/2;
plate_h            = 3
  ;

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

module mounting_sys( r, plate_thickness, points, shelf_points, shelf_dem, chmf, pad ){
    difference(){
        hull(){
            rotate([0,90,0])
                translate( shelf_points )cube( shelf_dem );
            color(rand_clr())
                rack_mount( r, plate_thickness, points, pad = pad );
        }
        mirror([0,0,1])
            translate([0,0,-50]) /// Infinite
                mounts( r, plate_thickness+100, points );
        mirror([0,0,1])
            translate( [ 0, 0, 0])
                color("pink")chamfer( chmf[0],
                                      chmf[1],
                                      50,    /// Infinite
                                      points );       
    }
    
}

module shelf_1u_mount( r, plate_thickness, points, shelf_points, shelf_dem, chmf = [ 12, 20 ], pad = 5 ){
    difference(){

        mounting_sys( r, plate_thickness, points, shelf_points, shelf_dem, chmf, pad );
        carve_out = [
                     shelf_points[ 0 ],
                     shelf_points[ 1 ]+plate_thickness,
                     shelf_points[ 2 ]-1//+plate_thickness
                     ];
        upper_extension = panel_height_mm( 1 );
        rotate([0,90,0])
            
            translate( carve_out )color("cyan") cube( [ shelf_dem[2],
                                                        shelf_dem[1]+upper_extension,
                                                        shelf_dem[2]+2 ]);
    }
}

///< Build object
shelf_1u_mount(
               r               = hole_r,
               plate_thickness = plate_h,
               points          = mount_points,
               shelf_points    = [ mount_spacing-10, hole_2_center-10, 0 ],
               shelf_dem       = [ 10, plate_h, 15 ]
               );
