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


///< Modules

module distribute( points, rot=0, inc = 0 ){
    
    for ( i = [ 0:1:len(points)-1 ] ){//p = points ){
        p = points[i];
        echo( "i", i, "points", p )
        translate(p)
            rotate([0,0,rot+i*inc]) children();
    }
}

module cell( height = 15, thickness = 1){
    ex_points = [
              [0,    0,0],
              [0,  100,0],
              [100,100,0],
              [100,  0,0],
              ];
              
    in_points = [
                 [ ex_points[0][0]+thickness, ex_points[0][1]+thickness, 0 ],
                 [ ex_points[1][0]+thickness, ex_points[1][1]-thickness, 0 ],
                 [ ex_points[2][0]-thickness, ex_points[2][1]-thickness, 0 ],
                 [ ex_points[3][0]-thickness, ex_points[3][1]+thickness, 0 ],
                 ];

    module shell(p){
        hull(){
        distribute( p )
            cylinder( d = 1, h = height );
        }
    }

    module clips(p=in_points){
        clip_points = [ [in_points[0][0],in_points[0][1],0],
                        [in_points[1][0],in_points[1][1],0],
                        [in_points[2][0],in_points[2][1],0],
                        [in_points[3][0],in_points[3][1],0],
                        ];
        
        distribute(clip_points, 45, -90)
            neoclip();
    }

    difference(){
        shell(ex_points);
        #shell(in_points );
    }
               
    translate([0,0,pcb_d/2+thickness])
        clips( in_points );
}

///< Build object

cell();

