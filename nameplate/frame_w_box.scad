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
   |   |   |     +--+      
   |   |   +----+   |
   |   | <-(P)->|   |(K)  | (C)
   |   |   +----+   |
  (H)  |   |     +--+       
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
     C: Channel width
     W: Width
     */

     width      = w;
     height     = h;
     key_width  = k;
     key_height = f; ///< Might need to adjust this
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
     linear_extrude( height = length ){
       polygon( points );


     }

}


sbox( w = 5, h = 10, k = 3, f = 6, p = 3 );
