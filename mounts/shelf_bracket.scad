///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: Shelf Bracket
Example from online book 'Mastering Openscad'
https://mastering-openscad.eu/buch/example_01
*/

/*
Parameters
*/

// Side A length
side_a_l = 50; // [0:1:100]

// Side A hole diameter
side_a_hole_dia = 6; // [0:1:100]

// Side A number of holes
side_a_num_holes = 1;

// Side B length
side_b_l = 75; // [0:1:100]

// Side B hole diameter
side_b_hole_dia = 4; // [0:1:100]

// Side B number of holes
side_b_num_holes = 3;

// Width
width = 35; // [0:1:100]

// Thickness
thickness = 4; // [0:1:100]

// Generate drilling templates
templates = false; 

// Rotate the build for printing
rotate_it = false;

///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}


///< Modules

/*
        module shelf_bracket

        parameters:
        - side_a    is a vector [length, hole diameter, number of holes]
        - side_b    is a vector [length, hole diameter, number of holes]
        - width     refers to the width of the bracket
        - thickness refers to the material thickness of the bracket
*/
module shelf_bracket( side_a, side_b, width, thickness, rotate_it = false ){

    module xhole_plate( size, h_dm, h_num, margin ){
        /* X holed plate: Size, hole diameter, num holes, margin */
        difference(){
            cube( size );
            h_distance = ( size.x - margin )/(h_num + 1 );
            for ( x = [1:h_num] )
                translate( [
                            margin + x * h_distance,
                            size.y/2,
                            -1
                            ])
                    cylinder( d = h_dm, h = size.z + 2, $fn = 18 );
        }
    }
    // Determine the hypotenuse and angle or rotation for the cut
    diag = sqrt( pow( side_a[0], 2 ) + pow( side_b[0], 2) );
    angle = asin( side_a[0] / diag );
    rot_h = cos( angle ) * side_a[0];
    
    translate( [0,0, rotate_it ? rot_h : 0] )
    rotate( [0, rotate_it ? 90 + angle : 0, 0 ] )
    difference(){
        union(){
            // Side A
            xhole_plate(
                        [ side_a[0], width, thickness ],
                        side_a[1],
                        side_a[2],
                        thickness
                        );

            // Side B
            translate( [ thickness, 0, 0 ] )
                rotate( [ 0, -90, 0 ] )
                xhole_plate(
                            [ side_b[0], width, thickness ],
                            side_b[1],
                            side_b[2],
                            thickness
                            );

            // Stringer
            cube( [ side_a[0], thickness, side_b[0] ] );

            translate( [ 0, width - thickness, 0 ] )
                cube( [ side_a[0], thickness, side_b[0] ] );
        }

        // Cut
        color("red" )
        translate( [ side_a[0], -1, 0] )
            rotate( [ 0, -angle, 0 ] )
            cube( [ diag, width + 2, diag + 2 ] );
    }
}


module output( tempaltes = false ){

    if ( templates ) {
        /// Drilling template
        projection( cut = true )
            children(0);

        translate( [-0.01, 0, 0] )
            projection( cut = true )
            rotate( [0, -90, 0 ] )
            children(0);

    } else {
        children(0);
    }
}

output( templates )
///< Build object
shelf_bracket(
              side_a    = [ side_a_l, side_a_hole_dia, side_a_num_holes ],
              side_b    = [ side_b_l, side_b_hole_dia, side_b_num_holes ],
              width     = width,
              thickness = thickness,
              rotate_it = rotate_it
              );
