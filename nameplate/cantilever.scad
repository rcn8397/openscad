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

module substrate( y, h, b, p, a, l = 1, origin = 0, hide = false, sep = 0.25, subx = 1, suby = 1 ){
     
       points = [
       [ origin,                          h + sep + y ],
       [ origin,                          h + sep + y + subx ],
       [ origin + b + p + a + sep + suby, h + sep + y + subx ],
       [ origin + b + p + a + sep + suby, origin ],
       [ origin + b + p + a + sep,        origin ],
       [ origin + b + p + a + sep,        h + sep ],
       [ origin + b + p + sep,            h + sep + y ],
       [ origin + b - sep,                h + sep + y ],
       [ origin + b - sep,                h + sep ],
       [ origin + a,                h + sep ],
       ];
     if( !hide ){
     linear_extrude( height = l ){ polygon( points ); }
     }
}

color( "violet")cantilever( y = 1, h = 1, b = 4, p = 1, a = 2 );
color( "pink" )substrate(  y = 1, h = 1, b = 4, p = 1, a = 2 );
