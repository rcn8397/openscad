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

$fn=90;

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
cr2032_h        = 3.12; // [0:1:100]
cr2032_r        = 10.00;// [0:1:100]
cr2032_d        = cr2032_r * 2;
thickness       = 1.0;
leads_r         = 0.75;

///< Modules
module batt_holder( batt_h = cr2032_h , batt_d = cr2032_d, t = thickness ){
    batt_r = batt_d/2;
    difference(){
        //< Outter shell
        cylinder( h = batt_h+t*2, d = batt_d+t );
        //< Inner shell
        translate([0,0,t])
            cylinder( h = batt_h*2, d = batt_d );
        
        //< Top Cutouts (right/left)
        for( i=[0,1] )
            translate([-batt_r+i*batt_r*2,
                       0,
                       batt_h+t*2])
                cube( [batt_r, batt_d+t*2, batt_h+t], true );

        //< Positive Terminals
        for( i=[-1,1] )
            translate([ i*2.5,
                        0,
                        0] )
                cylinder( h=t, d = leads_r );
        translate([-2.5,0,t])
            rotate([0,90,0])
            cylinder( h = 5, d = leads_r );

        //< Negative Terminals
        for( i = [-1,1] )
            translate( [ i*2.5, batt_r-t, t+batt_h] )
                rotate([-90,0,0] )
                cylinder( h=t*2, d = leads_r  );

        //< Flex cuts
        for( i = [-1,1] )
            translate( [ -(batt_r/2)*i+(i*t*2), -batt_r, batt_h ] )
                #cube( [ t, batt_r, batt_h*2 ],true );
    }
    //< Flex Tab
    translate([ 0,-batt_r,t+batt_h] )
        cylinder( h = t, d = batt_r/4 );
}

///< Build object
batt_holder();

