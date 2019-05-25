///< Zip tie pad

pad_w     = 20;
top_pad_h =  2;
pad_h     =  2;

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

     color( rand_clr() )
	  union(){
	  translate([w/2,w/2,h])color( rand_clr() )
	       cylinder( r=upper_cube_w, h=(h+th), $fn=60);
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
