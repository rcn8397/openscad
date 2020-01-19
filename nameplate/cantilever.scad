///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include<nameplate.scad>;
use <../lib/basics.scad>;

/*
http://fab.cba.mit.edu/classes/S62.12/people/vernelle.noel/Plastic_Snap_fit_design.pdf

Parameters
y= (permissible) deflection (=undercut)
l= length of arm
h= thickness at root
b= width at root
c= distance between outer fiber and neutral fiber (center of gravity)
P= (permissible) deflection force
a= hypot of deflection
*/

thickness = 6.5;

module cantilever( y, h, b, p, a, l = 1, origin = 0, hide = false ){
       points = [
       [ origin,             origin],	
       [ origin,             h     ],
       [ origin + b,         h     ],
       [ origin + b,         h + y ],
       [ origin + b + p,     h + y ],
       [ origin + b + p + a, h     ],       
       [ origin + b + p + a, origin],
       ];
     if( !hide ){
     linear_extrude( height = l ){ polygon( points ); }
     }
}

module substrate( y, h, b, p, a, l = 1, origin = [0,0], hide = false, sep = 0.25, subx = 1, suby = 1 ){
     
       points = [
       [ origin[0],                          h + sep + y ],
       [ origin[0],                          h + sep + y + suby ],
       [ origin[0] + b + p + a + sep + subx, h + sep + y + suby ],
       [ origin[0] + b + p + a + sep + subx, origin[1] ],
       [ origin[0] + b + p + a + sep,        origin[1] ],
       [ origin[0] + b + p + a + sep,        h + sep ],
       [ origin[0] + b + p + sep,            h + sep + y ],
       [ origin[0] + b - sep,                h + sep + y ],
       [ origin[0] + b - sep,                h + sep ],
       [ origin[0] + a,                      h + sep ],
       ];
     if( !hide ){
     linear_extrude( height = l ){ polygon( points ); }
     }
}

module snap_fit_substrate( y, h, b, p, a, l = 1, origin = 0, hide = false, sep = 0.25, subx = 0.4, suby = 0.4, diffx = 0){

     color( "violet")cantilever( y = y, h = h, b = b+diffx, p = p, a = a );
     color( "pink" )substrate(   y = y, h = h, b = b,       p = p, a = a, subx = subx, suby = suby, origin = [diffx,0] );
}

///snap_fit_substrate( y = 1, h = 1, b = 4, p = 1, a = 2, diffx = 1, subx = 1, suby = 1 );

module snap_fit( y, h, b, p, a, l = 1, origin = 0, hide = false, sep = 0.1){
     
     translate( [ b + a + p, h + y + sep + y, 0 ] )
     rotate( [0,0,180] )
	  color( "violet")cantilever( y = y, h = h, b = b, p = p, a = a );
     color( "blue")cantilever( y = y, h = h, b = b, p = p, a = a );
     }

snap_fit( y = 1, h = 1, b = 4, p = 1.75, a = 2 );
