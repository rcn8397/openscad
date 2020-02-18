///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/cantilever.scad>;

///< Parameters
r = 5.00;
w = 25.72 - r;
d = 10;
h = 38.50;

///< Rubber pad
pad_w = 18.50;
pad_d =  1.00;
pad_h = 34.10;
pad_offset = 2.00;

///< Dock
dock_wall_thickness = 1.0;
dock_w = w + dock_wall_thickness * 2 + r;
dock_d = d + dock_wall_thickness * 2;
dock_h = h + dock_wall_thickness * 2;

///< Modules
module kvm_switch( width, depth, height, radius,
		   pad_w, pad_d, pad_h,  pad_o ){
  translate( [ radius, 0 , 0 ] ){
  color( "lime" )
    cube( [width, depth, height] );
  color( "cyan" )
    translate( [ 0, radius, 0 ] )
    cylinder( h = height, r=radius, $fn=60 );

  /// Rubber pad
  color( "pink" )
    translate( [ 0, depth,pad_o ] )
    cube( [ pad_w, pad_d, pad_h ] );
  }
}

module kvm_dock_substrate( width, depth, height, round_r = 1 ) {
     rot = [ 0, 0, 0 ];
     points = [
	  [ 0,         0, 0 ],
	  [ 0,     depth, 0 ],
	  [ width, depth, 0 ],
	  [ width,     0, 0 ],
	  ];
     color( "orange" )
     hull(){
     for( p = points ){
	  translate( p ) rotate( rot )cylinder( r = round_r, h=h, $fn = 60 );
     }
     cube( [ width, depth, 1 ] );
   }
}

module kvm_dock(){
     difference(){
	  ///< Build kvm switch
	  kvm_dock_substrate( dock_w, dock_d, dock_h );

	  ///< Build kvm_switch
	  translate( [ dock_wall_thickness, -dock_wall_thickness, dock_wall_thickness * 2.5 ] )
	       kvm_switch( w, d, h, r, pad_w, pad_d, pad_h, pad_offset );
     }
}

module snap_joint( w, h, c ){
     wo = w - c;
     p  = w * 0.70;
     d2 = 0.90;
     $fn = 90;
     points = [
	  [ 0,  0     ],
	  [ 0,  h     ],
	  [ wo, h     ],
	  [ w,  h-c   ],
	  [ w,  h-c*2 ],
	  [ wo, h-c*3 ],
	  [ p,  h-c*3 ],
	  [ p,  0     ],
	  ];

     inner_points = [
	  [ 0,        0       ],
	  [ 0,     h*d2       ],
	  [ wo*d2, h*d2       ],
	  [ w*d2,  (h-c)*d2   ],
	  [ w*d2,  (h-c*2)*d2 ],
	  [ wo*d2, (h-c*3)*d2 ],
	  [ p*d2,  (h-c*3)*d2 ],
	  [ p*d2,  0          ],
	  ];


     difference(){
	  rotate_extrude()
	       polygon( points );

	  translate( [ 0, 0, h-h*d2+0.1 ] )
	       color( "red" )
	       rotate_extrude()
	       polygon( inner_points );
     }
}

//kvm_dock();

cube( [ 2, 9.8, 9.8 ] );
translate( [ 0, 9.8-2, 0 ] )cantilever(y = 1, h = 2, b = 9.8, p = 2, a = 2, l = 9.8 );
mirror( [0,1,0] )
cantilever(y = 1, h = 2, b = 9.8, p = 2, a = 2, l = 9.8 );

///< Snap button
//translate( [ dock_w/2, dock_d+1, dock_h/2 ] )rotate( [ -90, 0 , 0 ] )
//snap_joint( w = 5, h = 2, c = 0.5 );

