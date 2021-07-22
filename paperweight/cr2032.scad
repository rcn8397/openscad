///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: CR2032 Battery Holder/Switch
   Preamble and description
*/

/*
Parameters
*/
// Finish
$fn = 120;

// Thickness
thickness = 1.0; // [0:1:100]
// Terminal Wire Radius
term_r   = 0.5;    // [0:0.1:100]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
cr2032_h = 3.12; // [0:1:100]
cr2032_r = 10.00;// [0:1:100]

///< Modules
module cr2032( r = cr2032_r, h = cr2032_h, t = thickness ){
    color("silver")
        cylinder( h=h, r=r, true );
}

module terminal( r = 1, l = 1 ){
    cylinder( h = l, r = r );
}

module terminal_pair(r = 1, l = 1){
    union(){
        terminal(r, l);
        translate( [0,cr2032_r/2,0] )
            terminal(r, l);
    }
}

module hull_cr2032( t= thickness, h =thickness*2+cr2032_h ){
    r = cr2032_r+t*2;
    hull(){
        linear_extrude( height = h ){
            circle( r = r );
            translate([0,r/4,0])
                circle( r = r );
        }
    }
}

module shell(t = thickness, h = thickness+cr2032_h){
    difference(){
        hull_cr2032(t, h);
        translate([0,0,thickness])
            #hull_cr2032(0, h);
        translate([cr2032_r/4,-cr2032_r/2, thickness ] )
        rotate([0,-180,90] )
        #terminal_pair(l=thickness);

    }

}


module shell_inlay(){
    r = cr2032_r;
    linear_extrude( height = thickness ){
        hull(){
        circle( r = r/2 );
        translate([-r/2-thickness,r/2,0])
            circle( r = r/2 );
        translate([r/2+thickness,r/2,0])
            circle( r = r/2 );
        }
    }
}

module shell_rim(t = thickness, h = thickness){
    color("pink")
        difference(){
            hull_cr2032(t, h);
            translate([0,0,-0.01])
                hull_cr2032(0, h+0.02);
        }
}

module shell_top(){
    difference(){
        union(){
            shell_rim();
            #shell_inlay();
        }
        terminal_pair();
    }
}

///< Build object
difference(){
    shell();
    translate([0,-cr2032_r,thickness])
        cr2032();
}

translate([0,0,thickness+cr2032_h ])
shell_top();
//translate([0,0,thickness])cr2032();
