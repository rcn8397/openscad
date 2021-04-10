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

module mounting_sys( r, plate_thickness, points, pad ){
    difference(){
        color(rand_clr())
            rack_mount( r, plate_thickness, points, pad = pad );
        mirror([0,0,1])
            translate([0,0,-50]) /// Infinite
                mounts( r, plate_thickness+100, points );
    }
}

module xcross( w, d, h, pad = 5 ){
    pad2  = pad * 2;
    a     = w+pad2;
    b     = d+pad2;
    hyp   = hyp_from_sides( a, b );
    b_hyp = b/hyp;
    anga   = asin( b_hyp );
    angb   = 90 - anga;

    translate( [ 0, 0 , pad ] )
    rotate( [0,0,-angb])
        color( "pink" )cube( [ pad, hyp, h ] );
    translate( [ w, 0 , pad ] )
        rotate( [0,0,angb])
        color( "pink" )cube( [ pad, hyp, h ] );


}

module cutout( w, h, l ){
    linear_extrude( l )
        resize([w,h])circle(d=h);
}

module faces( w, d, h, pad = 5, inf = 100 ){
    width = w-pad*2;
    depth = d-pad*2;
    
    /// First face
    translate( [ 0, pad+depth/2, h/2+pad/2 ] )
        rotate( [90, 0, 90] )
        color("pink")
        cutout( depth, h-pad*2, inf );
    
    /// Second face
    translate( [ pad+width/2, 0, h/2+pad/2 ] )
        rotate( [-90, 0, 0] )
        color("purple")
        cutout( width, h-pad*2, inf );

}

module kvm_1u_mount( r, plate_thickness, points, w, d, h, chmf = [ 12, 20 ], pad = 2.5 ){
    
    difference(){
        union(){
            shell_w = w + pad;
            shell_h = h + pad;
            shell_d = d + pad;
                difference(){   
                    difference(){
                        color("red") cube( [ shell_w, shell_d, shell_h ] );
                        translate( [ pad/2, pad/2, pad ] )
                            color("cyan") cube( [ w, d, h ] );           
                    }
                    faces( w, d, h, pad );
                }
        }
        translate( [ w/2+pad/2, d/2+pad/2, 0 ] )
            cylinder( r = 35, h*2, true );
    }
    translate( [w+pad, d/4-pad*2, 0 ] ) 
        mounting_sys( r, plate_thickness, points, pad=5 );
    
}

///< Build object
kvm_1u_mount(
               r               = hole_r,
               plate_thickness = plate_h,
               points          = mount_points,
               w = 83.95,
               d = 75.66,
               h = 20.0
               );
