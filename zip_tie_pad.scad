///< Zip tie pad

pad_w = 10;
pad_d = pad_w;
pad_h = 1;

zip_tie_pad();

module zip_tie_pad(){
     center = pad_w/2-pad_w/8;
     difference(){
	  tie_pad(pad_w, pad_h);
	  zip_anchor(pad_w, pad_h, center);
     }
}

module zip_anchor(w,h,c){    
     color( rand_clr() )
	  union(){
	  translate([c,c,h+h*0.1])color( rand_clr() )cube( [w/4, w/4, h] );
	  translate([0,c,h])cube([w, w/4, h/2]);
	  translate([c,0,h])cube([w/4, w, h/2]);
     }
}

module tie_pad(w,h){
    hull(){
        cube([w, w, h]);
	translate([w/4,w/4,h])color( rand_clr() ) cube([w/2, w/2, h ]);
    }
}

function rand_clr() = rands( 0,1,3 );
     
