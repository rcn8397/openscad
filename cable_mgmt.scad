///< Cable management

///< module parameters
sphere_r = 5;
sphere_d = sphere_r * 2;
print_finish = 40;

///< modules
module half_sphere( r ){
     w = r*2;
     difference(){
     sphere( r, $fn=print_finish );
     translate([0,0,-r/2])
	  color([1,0,0],0.5)cube( [w, w, r], true);
     }
}

module cable_channel( r, h ){
     color([0,1,0])cylinder( r = r, h=h, $fn=print_finish );
}

module cable_sphere( r, ch_d ) {
     d = r*2;
    difference(){
         color([1,0,0],0.5)half_sphere( r );
         translate([0,r,r/1.6])rotate([90,0,0])cable_channel( ch_d, d );
    }
}

cable_sphere( sphere_r, 2 );
