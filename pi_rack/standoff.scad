///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/hull.scad>;

///< Parameters
x = 0;
y = 0;
z = 0;

h = 1;
w = 1;
d = 1;
$fn = 60;
points = [ [0,0,0], [40,0,0], [23,-10,0], [60,19,10] ];

///< Modules
module object( height, width, depth ){
    translate( [ x, y, z ] ) peg( top_h = h, bot_h = h, top_r = d+1, bot_r = d, sep_w = 0.33 );
}


module peg( top_h, bot_h, top_r, bot_r, sep_w = 0.5 ){
    tot_h = top_h + bot_h;
    sep = top_r * sep_w;

    difference(){
        difference(){
            union(){
                cylinder( h = bot_h, r = bot_r );
                translate( [0,0,bot_h] )
                    cylinder( h = top_h, r1 = top_r, r2 = bot_r );
            }
            translate( [ 0,0, 0.10 * tot_h + tot_h/2 ] )
                color( rand_clr()) cube( [ sep, 2 * top_r, tot_h ], true );
        }
        translate( [ 0,0, 0.10 * tot_h ] )
            color( rand_clr() )cylinder( h = tot_h, r = bot_r * 0.8 );
    }
}
///< Build object
object( w, d, h );

