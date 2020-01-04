///< Object definition
use <math.scad>;
use <utils.scad>;
use <basics.scad>;

/*
Channel lock fitting

   B                  C
      +-------------+
      |             |
      |             |
      |     E +-----+ D
      |       |
      |     F +-----+ G
      |             |
      |             |
   A  +-------------+ H

   
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


module channel_lock( width, height, length = 0, gap_h = 1, gap_d = 1, origin = 0 ){

     len_cd = height/3;
     len_ef = height/3;
     len_gh = height/3;
     
     points = [
	  [ origin,        origin ], //A
	  [ origin,        height ], //B
	  [ width,         height ], //C
	  [ width,         height - gap_h ], //D
	  [ width - gap_d, height - gap_h ], //E
	  [ width - gap_d, len_gh ], //F
	  [ width,         len_gh ], //G
	  [ width,         origin ]
	  ];
     polygon( points );
}

translate( [ 20, 0, 0 ] )channel_lock( width  = 10,
				       height = 10 );
