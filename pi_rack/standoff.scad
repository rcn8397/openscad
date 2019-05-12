/// Standoff module


///< example
translate()standoff( 2.5, 10.5 );
$fn = 30;

///< Def
module standoff( inner, height, rim=2 ){
     difference(){
	  outer = inner + rim; ///< inner diameter plus rim
	  through_hole = height + height * 0.10;
	  cylinder(r=outer, h = height );
	  translate([0,0,1]){
	       cylinder(r=inner, h = through_hole);
	  }
     }
}
