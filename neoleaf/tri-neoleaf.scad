///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/neo_pixel.scad>;


/*
Module: Name
Preamble and description

*/

/*
Parameters
*/

// Finish
$fn = 60;

// Height
h = 1; // [0:1:100]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
pcb_d = 9.6; //Neo pixel diameter

///< Functions
function square_vec( x ) = [
                            [0,0,0],
                            [0,x,0],
                            [x,x,0],
                            [x,0,0],
                            ];

function eqtri_vec( h ) = [
                           [0,  0, 0],
                           [h/2,opposite_side_th( 45,h), 0],
                           [h,  0, 0],
                           ];

function echov( v ) = [ for (i= [0:1:len(v)-1])v];
function addr( x, y ) = x + y;
function subr( x, y ) = x - y;
function addifeq( x, y, eq ) = x == eq
    ? addr( x, y )
    : x;
function subifeq( x, y, eq ) = x == eq
    ? subr( x, y )
    : x;
///< These mod<> names are horrible descriptors
function modif( x, y, eq ) = x == eq
    ? addr( x, y )
    : subr( x, y );

function vmodif( v, x ) = [ modif( v[0], x, 0 ), modif( v[1], x, 0 ), 0 ];
function modvec( v, x ) = [ for (i= [0:1:len(v)-1]) vmodif( v[i], x )];

///< Modules

module distribute( points, rot=0, inc = 0 ){
    
    for ( i = [ 0:1:len(points)-1 ] ){//p = points ){
        p = points[i];
        echo( "i", i, "points", p )
        translate(p)
            rotate([0,0,rot+i*inc]) children();
    }
}

module cell( points = square_vec( 100 ), height = 15, thickness = 1){
    ex_points = points;
    in_points = modvec( ex_points, thickness );
    clip_points = modvec( ex_points, 10 );
    
    module shell(p){
        hull(){
        distribute( p )
            cylinder( d = 1, h = height );
        }
    }

    module clips(p){
        distribute(clip_points, 45, -90)
            neoclip();
    }

    difference(){
        shell(ex_points);
        translate( [0,0,thickness] )#shell(in_points );
    }
               
    translate([0,0,pcb_d/2+thickness])
        clips( clip_points );
}

///< Build object
//cell();
cell( eqtri_vec( 100 ) );
echo( eqtri_vec( 10 ) );
