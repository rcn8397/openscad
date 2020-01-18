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

cantilever( y = 2, h = 2, b = 7, p = 2, a = 2 );