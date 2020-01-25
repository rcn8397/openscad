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

module substrate( y, h, b, p, a, l = 1, origin = [0,0], hide = false, sep = 0.25, suby = 1 ){

     points = [
       [ origin[0],                       h + y ],           //< A
       [ origin[0],                       h + y + suby ],    //< B
       [ origin[0] + b + p + a + subx,    h + y + suby ],    //< C
       [ origin[0] + b + p + a + subx,    origin[1] + sep ], //< D
       [ origin[0] + b + p + a + subx,    origin[1] + sep ], //< E
       [ origin[0] + b + p + a + subx,    h + sep ],         //< F
       [ origin[0] + b + p,               h + sep + y ],     //< G
       [ origin[0] + b,                   h + sep + y ],     //< H
       [ origin[0] + b - a,             h + sep ],         //< I
       [ origin[0] + a,                   h + sep ],         //< J
       ];
     if( !hide ){
     linear_extrude( height = l ){ polygon( points ); }
     }
}

module snap_fit_sub( y, h, b, p, a, l = 1, origin = 0, hide = false, sep = 0, suby = 0, subx = 0, hide_sub = false, hide_lever = false ){

     color( "violet")cantilever( y = y, h = h, b = b, p = p, a = a, l = l, hide = hide_lever );
     color( "pink" )substrate(   y = y, h = h, b = b, p = p, a = a, l = l, sep = sep, suby = suby, subx = subx, hide = hide_sub, origin = [ sep, 0 ] );
}

snap_fit_sub( y = 1, h = 1-0.1, b = 6, p = 2, a = 2, sep = 0.1, suby = 0.1, subx = 0 );

translate( [ 0, 3, 0 ] )snap_fit_sub( y = 0.5, h = 0.5-0.1, b = 3, p = 0.5, a = 1, l = 3, sep = 0.1, suby = 1, subx = 0 );
