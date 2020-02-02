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
hole_d             = 6; ///< M6 screw
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

module shelf_1u_mount( r, plate_thickness, points, shelf_points, shelf_dem, chmf = [ 3.5, 4 ], pad = 3 ){
 difference(){
     difference(){
        hull(){
          translate( shelf_points )cube( shelf_dem );
          rack_mount( r, plate_thickness, points, pad = pad );
          }
        mounts( r, plate_thickness, points );
      translate( [ 0, 0, plate_thickness ] )
	   color("pink")chamfer( r*chmf[0], r*chmf[1], shelf_dem[2], points );
      }
     carve_out = [
	  shelf_points[ 0 ],
	  shelf_points[ 1 ]+plate_thickness,
	  shelf_points[ 2 ]+plate_thickness
	  ];
     upper_extension = panel_height_mm( 1 );
     translate( carve_out )color("cyan") cube( [ shelf_dem[ 0 ],
				    shelf_dem[1]+upper_extension,
				    shelf_dem[2] ]);
     }
}

///< Build object
shelf_1u_mount(
	       r               = hole_r,
	       plate_thickness = plate_h,
	       points          = mount_points,
	       shelf_points    = [ mount_spacing, hole_2_center, 0 ],
	       shelf_dem       = [ 35, plate_h, 20 ]
	       );
