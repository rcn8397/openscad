///< Zip tie pad

pad_w = 20;
pad_d = pad_w;
top_pad_h = 1;
pad_h = 1;

zip_tie_pad();

module zip_tie_pad( concave = true){
     center = pad_w/2-pad_w/8;
     difference(){
	  tie_pad(pad_w, pad_h, top_pad_h);

	  zip_anchor(pad_w, pad_h, center, top_pad_h);
     }	  

}

module concave( r, h ){
	  translate([r,r,(r)+h-h*0.2])
	       sphere( r, $fn=60 );
}

module zip_anchor(w,h,c,th){    
     color( rand_clr() )
	  union(){
	  scale([1,1,0.5])
	       translate([w/2,w/2,w/2])
	       rotate([90,0,0])
	       color( rand_clr() ) sphere( r = w/2, $fn=60 );	
	  translate([c,c,h+h*0.1])color( rand_clr() )cube( [w/4, w/4, th] );
	  translate([0,c,h])cube([w, w/4, th/2]);
	  translate([c,0,h])cube([w/4, w, th/2]);
     }
}

module tie_pad(w,h,th){
    hull(){
        cube([w, w, h]);
	translate([w/4,w/4,h])color( rand_clr() ) cube([w/2, w/2, th ]);
    }
}

function rand_clr() = rands( 0,1,3 );
     
