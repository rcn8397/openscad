///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <../lib/hull.scad>;

///< Parameters
h   = 10;
$fn = 60;

shaft_measurements = [ 37.86, 37.64, 37.63, 37.53, 37.43, 37.44  ];
average_shaft_size = average( shaft_measurements );
echo( "Average Shaft Size = ", average_shaft_size );

base_measurements = [ 48.38, 48.39 ];
average_base_size = average( base_measurements );
echo( "Average Base Size = ", average_base_size );

///< Modules
module ring( height, width1, width2 ){//, wt1 = 1, wt2 = 1 ){
    color(rand_clr())cylinder( h = height, d1 = width1,    d2 = width2);   
}

///< Build retainer ring
lr_h = h + 10;
shaft_wt = 1;
base_wt  = 2;
shaft_size = average_shaft_size + 2;
difference(){
    union(){
        ring( lr_h, shaft_size, average_base_size );//, wt1 = shaft_wt, wt2 = base_wt );
        translate( [0,0,lr_h+h])
            mirror([0,0,90])
            ring( h, shaft_size, average_base_size );//, wt1 = shaft_wt, wt2 = base_wt );
    }
    shalf_cut = lr_h + h + 0.1;
    color( rand_clr() )cylinder( h = shalf_cut, d = shaft_size );
}

