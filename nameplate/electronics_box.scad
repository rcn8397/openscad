///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include<nameplate.scad>;

box_depth = 20;
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

module lid( thickness = 5 ){
     ///< Lid
     lid_w = nameplate_w;
     lid_d = thickness;
     lid_h = nameplate_h;
     lid_tuple = [ lid_w, lid_d, lid_h ];
     cube( lid_tuple );
}

///< prototype
//difference(){
electronics_box( depth = box_depth );
translate( [ 0, box_depth+lid_thickness, 0 ] )lid();
//     translate( [ 190, 0, 0 ] )cube( [30,50,80] );
//}


