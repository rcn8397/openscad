///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include<nameplate.scad>;
use <frame.scad>;

///< Global
depth = 25;
thickness = 6.5;

///< Component housing
comp_w = nameplate_w+thickness;
comp_d = nameplate_d + depth;
comp_h = nameplate_h+thickness;

module slide_connect( w, h, f, p, k, b = 1, clearance = 0.25, origin = 0, length = 1, hide_wall = false, hide_bridge = false) {
     /*          <---(B)---> ...
       +---+     +-------
   ^   |   |     |
   |   |   |     +--+ ^
   |   |   +----+   | |
   |   | <-(P)->|   |(K)
   |   |   +----+   | |
  (H)  |   |     +--+ v
   |   |   |  ^  |
   |   |   |  |  +-----
   |   |   | (F)
   v   |   |  |
   (O) +---+  v

     <--(W)-->

     O: Origin
     H: Height
     K: Key width
     F: Key Height
     P: Key Depth
     W: Width
     B: Bridge Width
     */

     width      = w;
     height     = h;
     key_width  = k;
     key_height = f; ///< Might need to adjust this ( like safety check )
     key_depth  = p;
     points = [
	  [ origin,            origin     ],
	  [ origin,            height     ],
	  [ width,             height     ],
	  [ width,             key_height ],
	  [ width + key_depth, key_height ],
	  [ width + key_depth, key_height - key_width ],
	  [ width,             key_height - key_width ],
	  [ width,             origin ]
	  ];
     if( !hide_wall ){
     linear_extrude( height = length ){ polygon( points ); }
     }

     pad = clearance;
     origin_b = origin + ( width + pad );
     bridge_w = b - clearance;
     bridge_points = [
		      [ origin_b,             key_height + key_width             ], //a
		      [ origin_b,             key_height + pad                   ], //b
		      [ origin_b + key_depth, key_height + pad                   ], //c
		      [ origin_b + key_depth, key_height - (key_width * 1) - pad ], //d
		      [ origin_b,             key_height - (key_width * 1) - pad ], //e
		      [ origin_b,             key_height - (key_width * 2)       ], //f
		      [ origin_b + bridge_w,  key_height - (key_width * 2)       ], //g
		      [ origin_b + bridge_w,  key_height + key_width             ], //h
		     ] ;
     if( !hide_bridge ){
     color( "lime" )
     linear_extrude( height = length ){ polygon( bridge_points ); }
     }
}



module slide_box( width, height, key_w, key_h, key_d, bridge, clearance, length = 1, hide_walls = false, hide_bridge = false ){
  slide_connect( w = width, h = height, k = key_w, f = key_h, p = key_d, b = bridge, clearance = clearance, length = length, hide_wall = hide_walls, hide_bridge = hide_bridge );

  translate( [bridge*2, 0, 0] )
    mirror( [1,0,0] )
    slide_connect( w = width, h = height, k = key_w, f = key_h, p = key_d, b = bridge, clearance = clearance, length = length, hide_wall = hide_walls, hide_bridge = hide_bridge );

  if( !hide_walls ){
  ///< Bottom Wall
  color( "pink" ) translate( [ 0, 0, 0 ] )
    cube( [ bridge*2, key_h-key_w*2-0.5, width ] );
  }

  if( !hide_bridge ){
  ///< Top Wall ( This ought to have a hide so the assembly can be printed without it )
  color( "purple" ) translate( [ width+clearance, clearance, length-width ] )
    cube( [ bridge*2-(width*2+clearance*2), key_h-key_w*2-(clearance), width ] );
  }
}

height = comp_d;
key_d  = 2;
key_w  = 2;
key_h  = height-key_w;
width  = 2;
clearance = 0.5;
bridge    = comp_h/2;


hide_walls  = false;
hide_bridge = true;

if( !hide_walls ){
  frame( nameplate_w, nameplate_d, nameplate_h  );
 }
translate( [0,thickness*1.375,0] )
rotate( [0,90,0])
mirror( [1,0,0])
slide_box( width, height, key_w, key_h, key_d, bridge, clearance, length = comp_w, hide_walls = hide_walls, hide_bridge = hide_bridge );
