///< Math scad module


///< Find the hypotenuse from two sides of a right triangle
function hyp_from_sides( a, b ) = sqrt( pow( a, 2 ) + pow( b, 2 ) );

///< Find equal sides from hypotenuse of a right triangle
function sides_from_hyp(h) = sqrt( pow( h, 2 ) / 2 );
