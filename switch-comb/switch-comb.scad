///< Object definition

/*
Module: Switch Comb
Simple switch comb for projects
*/

/*
Parameters
*/

// finish
$fn = 60;

// Num switches (try 9)
num_switches = 9; 

// Switch Hole Radius
sw_hole_r = 3.10; // [0:0.1:100]

// Rotation 
rot_x = 10; // [-90:0.1:90] 

// Padding
pad = 4; // [0:0.1:25]

// Thickness
thickness = 2;   // [0:1:10]

// Legend Height
legend_h = 5.0;  // [0:1:10]

// Foot depth
foot_depth = 10;  // [0:1:25]

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}
rot_y = 0; // [-360:0.1:360]
rot_z = 0; // [-360:0.1:360]

txt = [ "pwr", "demo", "bb", "d1", "d2", "d3", "rev1", "rev2" ];


///< Modules

module rotate_about(a, v, p=[0,0,0]) {
    // Credit: thehans
    // https://forum.openscad.org/Rotate-about-user-defined-axis-td27737.html
     translate(p) rotate(a,v) translate(-p) children();
} 

module object( r = sw_hole_r, pad = pad, /* rot = [rot_x, rot_y, rot_z],*/  t = thickness, lh = legend_h, tstr, fd = foot_depth ){
    cut = 100;
    w = r*2 + pad;
    h = r*2 + pad*2;
    d = t;
    ph = d+pad;
    z_offset = h/2+lh;
    difference(){
        union(){
            rotate_about( -rot_x, v = [1,0,0], p = [0,0,0] ){
                translate([0,0,z_offset])
                cube( [ w, d, h ], center = true );
                translate([0,0,lh/2])
                        color("green")
                        cube( [w, d, lh], true );
            }
        }
        translate([0,t/2,lh/2])
            rotate( [ -rot_x+90,0,0] )
            linear_extrude( height=t ){
            text( tstr, size = 2, halign="center" ); }

        rotate_about( -rot_x, v = [1,0,0], p = [0,0,0] )
            translate([0,cut/2,z_offset])
            translate([0,d/2,0])
            rotate([90,0,0])
            cylinder( d = sw_hole_r * 2, h = cut );
    }

    //< Foot
    translate([0,(fd/2)-d/2,0])
        difference(){
        color("pink")
            cube( [w, fd, t], true );
            color("cyan")
                translate( [ 0, fd*.10, 0 ] )
                cube( [w/4, fd/2, 10 ],true );
    }

    //< Legend TODO

}


///< Build object

for( i = [0:num_switches-1] ){
    r = sw_hole_r;
    w = ( r * 2 + pad )*i;
    p = [ w, 0, 0 ];
    translate( p ){
        object(tstr=txt[i]);
    }
 }

