///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: Name
   Preamble and description

*/

/*
Parameters
*/
// Finish
$fn = 60;

// Clip outer radius
cir = 5.0; // [0:1:100]
cid = cir*2;

// Clip thickness
ct = 1.0; // [0:1:100]

// Clip base W
cbw = 20.0;  // [0:1:100]

// Clip bas H
cbh = 10.0;  // [0:1:100]

// Clip inner radius
cor = cir-(ct*2);


///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}


///< Modules
module clip_outer(){
    difference(){
        union(){
            circle( r = cir );
            translate( [ -cbw/2, -(cir+cbh-ct), 0 ] ) square( [ cbw, cbh ] );
        }
        clip_inner(r = cor, ct);
    }

}
module clip_inner( r, t = ct){
    ///< Inner clip
    union(){
    color("pink") circle( r = r );
    color("pink") translate( [ -cbw/2, (cor-(t*2)), 0 ] )
        square( [ cbw, cbh ] );
    }
}

 module clip(){
     clip_outer();
     #clip_inner( cor-ct );
 }

///< Build object
clip();


