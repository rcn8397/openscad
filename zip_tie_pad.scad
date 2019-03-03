///< Zip tie pad

pad_w = 20;
pad_d = pad_w;
pad_h = 2;

zip_tie_pad();

module zip_tie_pad(){
     difference(){
	  tie_pad(pad_w, pad_h);
	  zip_anchor(pad_w, pad_h);
     }
}

module zip_anchor(w,h){
     color( rand_clr() )
	  union(){
     translate([0,pad_w/2-pad_w/8,pad_h])cube([w, w/4, h/2]);
     translate([pad_w/2-pad_w/8,0,pad_h])cube([w/4, w, h/2]);
     }
}

module tie_pad(w,h){
    hull(){
        cube([w, w, h]);
	translate([w/4,w/4,h])color( rand_clr() ) cube([w/2, w/2, h ]);
    }
}

function rand_clr() = rands( 0,1,3 );
     
