///< Object definition
use <math.scad>;
use <utils.scad>;
use <basics.scad>;

/*
Channel lock fitting            Key fitting
				(Note symmetry)
   B                  C
      +-------------+              F +---+ G
      |             |   ( Q )        |   |
      |         (O) |	       D   E |   |
      |     E +-----+ D         +----+   |
      | (P)   |         ( R )   +        |
      |     F +-----+ G		+----+   |
      |             |   ( S )  C   B |   |
      |             |                |   |
   A  +-------------+ H            A +---+ H

   C->D  = Q
   E->F  = P
   D->G  = R (P=R)
   G->H  = S

*/

module channel_lock( width,
		     height,
		     length = 1,
		     rake = 0,
		     Q = 1,
		     R = 1,
		     S = 1,
		     O = 1,
		     P = 1,
		     origin = 0 ){

     points = [
	  [ origin - rake,    origin     ], //A
	  [ origin,           height     ], //B
	  [ width,            height     ], //C
	  [ width,            height - Q ], //D
	  [ width - O,        height - Q ], //E
	  [ width - O,        origin + S ], //F
	  [ width,            origin + S ], //G
	  [ width,            origin     ]  //H
	  ];
     linear_extrude( height = length ){
       polygon( points );
     }
}

module channel_key( width,
		    height,
		    length = 1,
		    Q = 1,
		    R = 1,
		    S = 1,
		    O = 1,
		    P = 1,
		    origin = 0 ){

     points = [
	  [ origin,         origin     ], //A
	  [ origin,         S          ], //B
	  [ origin - O,     S          ], //C
	  [ origin - O,     height - Q ], //D
	  [ origin,         height - Q ], //E
	  [ origin,         height     ], //F
	  [ origin + width, height     ], //G
	  [ origin + width, origin     ]  //H
	  ];
     linear_extrude( height = length ){
       polygon( points );
     }
}


module channel_key_pair( width,
			 height,
			 length = 1,
			 rake = 0,
			 clearance = 1,
			 Q = 1,
			 R = 1,
			 S = 1,
			 O = 1,
			 P = 1,
			 origin       = 0,
			 hide_channel = false,
			 hide_key     = false
			 ){
  if( !hide_channel ){
        color( rand_clr() )
        channel_lock(width  = width,
		     height = height,
		     length = length,
		     rake   = rake,
		     Q      = Q,
		     O      = O,
		     S      = S );
  }

  if( !hide_key ){
      color( rand_clr() )
	translate( [ (width+clearance), 0, 0 ]  )
	channel_key(  width  = width,
		      height = height,
		      length = length,
		      Q      = Q + clearance,
		      O      = O,
		      S      = S + clearance );
  }
}

module mirrored_channel_pairs( width,
			       height,
			       length = 1,
			       rake = 0,
			       clearance = 1,
			       Q = 1,
			       R = 1,
			       S = 1,
			       O = 1,
			       P = 1,
			       origin       = 0,
			       hide_channel = false,
			       hide_key     = false ){
  translate( [width*2,0,0] ){
    mirror( [ 1,0,0 ] )
    channel_key_pair( width  = width,
		      height = height,
		      length = length,
		      rake   = rake,
		      clearance = clearance,
		      Q = Q,
		      O = O,
		      S = S,
		      hide_channel = hide_channel,
		      hide_key     = hide_key
		      ); }

 translate( [width*2+rake*2,0,0 ]){
   channel_key_pair( width  = width,
		     height = height,
		     length = length,
		     rake   = rake,
		     clearance = clearance,
		     Q = Q,
		     O = O,
		     S = S,
		     hide_channel = hide_channel,
		     hide_key     = hide_key
		     );}
 }


///< Test
if( false ){
channel_key_pair( width  = 20,
		  height = 20,
		  length = 20,
		  rake   = 10,
		  Q = 5,
		  O = 10,
		  S = 5);
 }

if( true ){
mirrored_channel_pairs( width  = 20,
			height = 20,
			length = 20,
			rake   = 10,
			Q = 5,
			O = 10,
			S = 5 );
 }
