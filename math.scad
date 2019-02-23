///< Math scad module


///< Find the hypotenuse from two sides of a right triangle
function hyp_from_sides( a, b ) = sqrt( pow( a, 2 ) + pow( b, 2 ) );

///< Find equal sides from hypotenuse of a right triangle
function sides_from_hyp(h) = sqrt( pow( h, 2 ) / 2 );


///< Test for math functions

A = 3;
B = 4;
echo("Given A=", A, "and B=", B );
H = hyp_from_sides( A, B );
echo("Hypotenuse=", H );
echo("Calc Correct = ", (H == 5) );

echo("Given H=", H, " which is a hypotenuse with equal sides" );
sides = sides_from_hyp( H );
echo( "the sides=", sides );
