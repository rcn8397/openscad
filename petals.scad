///< Petals tutorial from all3dp
///< https://all3dp.com/2/openscad-tutorial-for-advanced-users-modules-functions/

module petal(length=16, width=10, thickness=2){
     hull(){
	  translate([0,thickness/2,0])
	       cube(thickness, center=true);///Petal base
	  translate([0,length/2,0])
	       cylinder(r=width/2, h=thickness, center=true);///Petal middle
	  translate([0,length-hypo_to_side(thickness),0])
	       rotate([0,0,45])cube(thickness, center=true);///Petal tip
     }
}

function hypo_to_side(h) = sqrt( pow( h, 2 ) / 2 );

petal();

