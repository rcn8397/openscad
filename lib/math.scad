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

///< Find the sum of a vector <vect> starting from <s> and continuing to <i>
function sumv( vect, i, s=0 ) = ( i == s ? vect[ i ] : vect[ i ] + sumv( vect, i - 1, s ) );
vec = [ 1, 2, 3, 4 ];
l = len( vec )-1;
echo( "Sum vec = ", sumv( vec, l, 0 ) );

///< Find the average of a vector <vect> starting at <s>
function average( vect, s=0 ) = (len( vect ) == 0 ? 0 : ( sumv( vect, len( vect ) - 1, s )/len(vect) ) );
echo( "Ave vec = ", average( vec ) );
vec2 = [];
echo( "Ave vec2 = ", average( vec2 ) );