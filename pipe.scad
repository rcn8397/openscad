/// Pipe module


///< example
translate()pipe( 3, 2,  10.5 );
$fn = 30;

///< Def
module pipe( outer, inner, height ){
     offset_percent = 0.25;
     inner_h = height + (offset_percent * 2 );
     difference(){
     ///< Debug with union(){
	  cylinder(r=outer, h = height );
	  translate([0,0,-offset_percent]){
	       color("green",0.5)cylinder(r=inner, h = inner_h );
	       }
     }
}
