///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include<nameplate.scad>;
//include<frame.scad>;

depth = 25;
thickness = 6.5;


///< Component housing
comp_w = nameplate_w+thickness;
comp_d = nameplate_d + depth;
comp_h = nameplate_h+thickness;

module framebox(){
difference(){
     translate( [0, thickness*1.2, 0] )cube([ comp_w, comp_d, comp_h ], false );
     translate( [thickness/2, 0, thickness/2] )
	  color( rand_clr() )cube([ comp_w-thickness,
				    (comp_d+thickness)*1.5,
				    comp_h-thickness ], false );
     }
}

module sbox( w, h, f, p, k, origin = 0, length = 2) {
     /*
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
     linear_extrude( height = length ){ polygon( points ); }

     pad = 1;
     origin_b = origin + ( width + key_depth );
     chan_t_h = height - key_width;
     chan_h   = chan_t_h - key_width;
     chan_b_h = chan_t_h - key_width;
     bridge_points = [
		      [ origin_b,             key_height + key_width       ], //a
		      [ origin_b,             key_height                   ], //b
		      [ origin_b + key_depth, key_height                   ], //c
		      [ origin_b + key_depth, key_height - (key_width * 1) ], //d
		      [ origin_b,             key_height - (key_width * 1) ], //e
		      [ origin_b,             key_height - (key_width * 2) ], //f
		      [ origin_b + 20,        key_height - (key_width * 2) ], //g
		      [ origin_b + 20,        key_height + key_width       ], //h
		     ] ;
     color( "green" )
     linear_extrude( height = length ){ polygon( bridge_points ); }
}


sbox( w = 5, h = 20, k = 3, f = 17, p = 2 );
