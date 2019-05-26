///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;

///< Component housing
components_w = frame_w;
components_d = frame_d + 10;
components_h = frame_h;
wall_thickness = 5;
components_box = [ components_w, components_d, components_h ];
components_box_cut = [ components_w - wall_thickness,
		       components_d - wall_thickness,
		       components_h - wall_thickness ];

module exlectronics_box(){
     translate( [ 0, frame_d, 0 ] )color( rand_clr() )
	  difference(){
	  cube( components_box );
	  translate( [ wall_thickness/2, -wall_thickness/2, wall_thickness/2 ] )
	       cube( components_box_cut );
     }
}

