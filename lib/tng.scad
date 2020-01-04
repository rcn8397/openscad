///< Object definition
use <math.scad>;
use <utils.scad>;
use <basics.scad>;

/*
Channel lock fitting

   B                  C
      +-------------+
      |             |   ( Q )
      |         (O) |
      |     E +-----+ D
      | (P)   |         ( R )
      |     F +-----+ G
      |             |   ( S )
      |             |   
   A  +-------------+ H

   C->D  = Q
   E->F  = P
   D->G  = R (P=R)
   G->H  = S
   
*/

///< Vectors
a = [ 0,  0  ];
b = [ 0,  10 ];
c = [ 10, 10 ];
d = [ 10, 6  ];
e = [ 5,  6  ];
f = [ 5,  4  ];
g = [ 10, 4  ];
h = [ 10, 0  ];

polygon( [ a, b, c, d, e, f, g, h ] );


module channel_lock( width,
		     height,
		     length = 0,
		     Q = 1,
		     R = 1,
		     S = 1,
		     O = 1,
		     P = 1,		     
		     origin = 0 ){

     points = [
	  [ origin,    origin     ], //A
	  [ origin,    height     ], //B
	  [ width,     height     ], //C
	  [ width,     height - Q ], //D
	  [ width - O, height - Q ], //E
	  [ width - O, origin + S ], //F
	  [ width,     origin + S ], //G
	  [ width,     origin     ]  //H
	  ];
     polygon( points );
}

translate( [ 20, 0, 0 ] )
channel_lock( width  = 10,
	      height = 10, Q = 10*0.6, O = 5, S = 10*0.6 );
