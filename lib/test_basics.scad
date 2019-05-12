///< Test basics
use <basics.scad>

///< Triangle
p1 = [   0,   0 ];
p2 = [   5,   0 ];
p3 = [   0,   5 ];
     
translate( [ 0 ,10, 0 ] ) tri( p1, p2, p3, h = 5 );
triangle( [p1,p2,p3], h = 3 );

/// Oval
translate( [ 10, 0, 0 ] )translate()oval(1,2,1, fn = 30);

/// Pipe
translate( [ 20, 0 , 0 ] )pipe( 3, 2,  10.5 );

/// Pipe that is rounded on the ends
translate( [20, 20, 0 ] )rounded_pipe(r=5, h=10, fn = 50 );

/// Line...
translate( [ 20, 20, -20 ] )line([0,0,0], [5,23,42]);
