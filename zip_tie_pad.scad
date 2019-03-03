///< Zip tie pad

pad_w     = 20;
top_pad_h =  1;
pad_h     =  1;

zip_tie_pad( pad_w, top_pad_h, pad_h );

module zip_tie_pad( w, th, h){
     center = w/2-w/8;
     difference(){
	  tie_pad(w, h, th);
	  zip_anchor(w, h, center, th);
     }
}

module zip_anchor(w,h,c,th){
     upper_cube_w = w/4;
     sphere_r = w/2;
     color( rand_clr() )
	  union(){
	  scale([1,1,0.5])
	       translate([sphere_r,sphere_r,w/2+w*0.05])
	       rotate([90,0,0])
	       color( rand_clr() ) sphere( r = sphere_r, $fn=60 );
	  translate([c,c,h+h*0.1])color( rand_clr() )cube( [upper_cube_w, upper_cube_w, th] );
	  translate([0,c,h])cube([w, upper_cube_w, th/2]);
	  translate([c,0,h])cube([upper_cube_w, w, th/2]);
     }
}

module tie_pad(w,h,th){
    hull(){
	cube([w, w, h]);
	translate([w/4,w/4,h])color( rand_clr() ) cube([w/2, w/2, th ]);
    }
}

function rand_clr() = rands( 0,1,3 );
