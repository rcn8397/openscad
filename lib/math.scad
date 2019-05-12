///< Math scad module


///< Find the hypotenuse from two sides of a right triangle
function hyp_from_sides( a, b ) = sqrt( pow( a, 2 ) + pow( b, 2 ) );

///< Find equal sides from hypotenuse of a right triangle
function sides_from_hyp(h) = sqrt( pow( h, 2 ) / 2 );

///< Find A from hypotenuse and B
function a_from_hb( h, b ) = sqrt( pow( h, 2 ) - pow( b, 2 ) );

function dist_2d( pt2, pt1 ) = sqrt(pow(( pt2[0]-pt1[0] ),2) + pow(( pt2[1]-pt1[1]),2) );

function mid_pt_2d( pt2, pt1 ) = [( pt1[0]+pt2[0] )/2, ( pt1[1]+pt2[1] )/2, 0 ];
///< Test for math functions

A = 3;
B = 4;
echo("Given A=", A, "and B=", B );
H = hyp_from_sides( A, B );
echo("Hypotenuse=", H );
echo("Calc Correct = ", (H == 5) );

echo("Given H=", H, " which is a hypotenuse with equal sides" );
echo( "the sides=", sides_from_hyp( H ) );

echo("Given H=", H, "B=", 4 );
echo("A=", a_from_hb( H, 4 ) );

echo("Distance from [-1,1] and [3,4] = ", dist_2d( [-1,1],[3,4]) );
