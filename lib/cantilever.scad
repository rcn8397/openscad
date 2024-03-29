///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
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

module cantilever_w_fillet( y, h, b, p, a, l = 1, origin = 0, fw, fh, fr=1, hide = false ){

    difference(){
        //union(){
        union(){
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
                linear_extrude( height = l ){
                    polygon( points );
                    translate([ origin, h, 0] )
                        square( [ fw, fh ] );
                    translate([ origin, -h, 0] )
                        square( [ fw, fh ] );
                }
            }
        }
        translate([ origin + fw, origin + h + fr, 0] )
            linear_extrude( height = l ){
            circle( r = fr, $fn=60 );
            translate( [ -fw, 0, 0] )
                square([fw,fh]);
        }
        translate([ origin + fw, origin-fr, 0] )
            linear_extrude( height = l ){
            circle( r = fr, $fn=60 );
            translate( [ -fw, -fh, 0] )
                square([fw,fh]);

        }
    }
}


module substrate( y, h, b, p, a, l = 1, origin = [0,0], hide = false, sep = 0.25, suby = 1, subx = 0 ){

     points = [
       [ origin[0],                       h + y ],           //< A
       [ origin[0],                       h + y + suby ],    //< B
       [ origin[0] + b + p + a + subx,    h + y + suby ],    //< C
       [ origin[0] + b + p + a + subx,    origin[1] + sep ], //< D
       [ origin[0] + b + p + a + subx,    origin[1] + sep ], //< E
       [ origin[0] + b + p + a + subx,    h + sep ],         //< F
       [ origin[0] + b + p,               h + sep + y ],     //< G
       [ origin[0] + b,                   h + sep + y ],     //< H
       [ origin[0] + b - a,               h + sep ],         //< I
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


module snap_fit_anchor( y, h, b, p, a, l = 1, origin = [0,0], hide = false, sep = 0, suby = 0, subx = 0, hide_sub = false, hide_lever = false ){

  color( "violet")cantilever( y = y, h = h, b = b, p = p, a = a, l = l, hide = hide_lever );
  color( "pink" )substrate(   y = y, h = h, b = b, p = p, a = a, l = l, sep = sep, suby = suby, subx = subx, hide = hide_sub, origin = [ sep, 0 ] );
 
  cube_w = h+y;
  cube_h = h+y+sep+suby+sep;
  translate( [-(h+y),0,0] )cube( [ cube_w, cube_h, l ] );

}


//translate( [ 0, 8, 0 ] )cantilever(y = 1, h = 1-0.1, b = 6, p = 2, a = 2 );

translate( [ 0, 18, 0 ] )cantilever_w_fillet(y = 1, h = 2, b = 6, p = 2, a = 2, fw = 2, fh = 40 );

//snap_fit_sub( y = 1, h = 1-0.1, b = 6, p = 2, a = 2, sep = 0.1, suby = 0.1, subx = 0 );

//translate( [ 0, 3, 0 ] )snap_fit_sub( y = 0.5, h = 0.5-0.1, b = 3, p = 0.5, a = 1, l = 3, sep = 0.1, suby = 1, subx = 0.25 );


//translate( [ 0, 5, 0 ] )snap_fit_anchor( y = 0.5, h = 0.5-0.1, b = 3, p = 0.5, a = 1, l = 3, sep = 0.1, suby = 1, subx = 0.25 );

