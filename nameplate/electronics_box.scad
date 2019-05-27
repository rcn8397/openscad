///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
include<nameplate.scad>;
use <../lib/hull.scad>;

box_depth = 20;
box_thickness = 5;
lid_thickness = 5;

module electronics_box( depth = 20, thickness = 5 ){
     ///< Component housing
     components_w = nameplate_w;
     components_d = nameplate_d + depth;
     components_h = nameplate_h;
     components_box = [ components_w, components_d, components_h ];
     components_box_cut = [ components_w - thickness,
			    components_d,
			    components_h - thickness ];

     translate( [ 0, nameplate_d, 0 ] )
	  color( rand_clr() )
	  difference(){
	  cube( components_box );
	  translate( [ thickness/2, thickness, thickness/2 ] )
	       cube( components_box_cut );
     }
}

module lid( height = 5, thickness = 5 ){
     ///< Lid
     lid_w = nameplate_w;
     lid_d = height;
     lid_h = nameplate_h;
     lid_tuple = [ lid_w, lid_d, lid_h ];

     inner_points = [
         [ thickness*2,          (thickness*2),      0 ],
         [ thickness*2,          lid_h-(thickness*2),0 ],
         [ lid_w-( thickness*2 ),lid_h-(thickness*2),0 ],
         [ lid_w-( thickness*2 ),(thickness*2),      0 ],
         ];

      translate( [ 0, height, 0 ] ){
          color( rand_clr() )cube( lid_tuple );
          color( rand_clr() )
              rotate( [ 90,0,0] )
              rounded_box( points=inner_points,
                           radius=thickness,
                           height=height - height*0.20 );
      }
}

///< prototype
//electronics_box( depth = box_depth );
//translate( [ 0, box_depth+lid_thickness, 0 ] )lid();



