///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include<nameplate.scad>;

box_depth = 20;
box_wall_thickness = 5;
lid_thickness = 5;

module electronics_box( depth = 20, wall_thickness = 5 ){
     ///< Component housing
     components_w = nameplate_w;
     components_d = nameplate_d + depth;
     components_h = nameplate_h;
     components_box = [ components_w, components_d, components_h ];
     components_box_cut = [ components_w - wall_thickness,
			    components_d,
			    components_h - wall_thickness ];

     translate( [ 0, nameplate_d, 0 ] )
	  color( rand_clr() )
	  difference(){
	  cube( components_box );
	  translate( [ wall_thickness/2, wall_thickness, wall_thickness/2 ] )
	       cube( components_box_cut );
     }
}

module lid( height = 5, wall_thickness = 5 ){
     ///< Lid
     lid_w = nameplate_w;
     lid_d = height;
     lid_h = nameplate_h;
     lid_tuple = [ lid_w, lid_d, lid_h ];

     if_w = nameplate_w;
     if_d = nameplate_d;
     if_h = nameplate_h;
     if_cut = [ if_w - wall_thickness,
		height,
		if_h - wall_thickness ];

     //translate( [ 0, height, 0 ] ) cube( lid_tuple );

     
     translate( [ wall_thickness/2, wall_thickness/2, wall_thickness/2 ] )

//	  intersection(){
	       rotate( [ 90, 0, 0 ] )
		    translate( [ lid_w/2, lid_h/2, -lid_d/2 ] )
		    color( rand_clr() )
		    cylinder( h = height, d = nameplate_w, $fn = 60 );
	       cube( if_cut );
//	       }
//	  }
	  
     
}

///< prototype
//difference(){
//electronics_box( depth = box_depth );
translate( [ 0, box_depth+lid_thickness+15, 0 ] )lid();
//     translate( [ 190, 0, 0 ] )cube( [30,50,80] );
//}


