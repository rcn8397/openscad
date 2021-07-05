///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;


/*
Module: Name
   Preamble and description

*/

/*
Parameters
*/

// Finish
$fn = 60.0;

// WallExtrusion parameters
// Wall Extrusion Width (X)
wallex_w = 90.0; // [0:1:100]
// Wall Extrusion Depth (Y)
wallex_d = 18.93; // [0:1:100]
// Wall Extrustion Height (Z)
wallex_h = 38.36; // [0:1:100]
wallex_hd = 5;
wallex_hl = wallex_h;
wallex_hp = [
            [ wallex_w*1/4, wallex_h/2, 0 ],
            [ wallex_w*3/4, wallex_h/2, 0 ]
            ];


// Wall Mount parametsers
// Wall mount width (X)
wallmnt_w = 45.0; // [0:0.01:300]
// Wall mount depth (Y)
wallmnt_d = 50.00; // [0:0.01:100]
// Wall mount height (Z)
wallmnt_h = 38.36; // [0:0.01:100]

// Slide Mount Parameters
// Slide Hole Width
slide_hole_w = 5.0; // [0:0.1:50]
// Slide Hole Length
slide_hole_l = 7.0; // [0:0.1:50]
// Slide Hole Diameter
slide_hole_d = 4.55; // [0: 0.01: 10 ]
// Slide Hole Height
slide_hole_h = 100; // [0: 1: 100 ]
// Slide Hole Y Offset
slide_hole_y = 6.1; // [0: 0.1: 100]
// Slide Hole X Offset
slide_hole_x = 1;   // [0: 0.1: 100]


slide1_x0 = wallex_w*1/4+slide_hole_w+slide_hole_x;
slide1_x1 = wallex_w*1/4+slide_hole_w+slide_hole_l+slide_hole_x;

slide2_x0 = wallex_w*1/4+wallmnt_w-(slide_hole_w+slide_hole_x );
slide2_x1 = wallex_w*1/4+wallmnt_w-(slide_hole_w+slide_hole_l+slide_hole_x );

// Slide Hole points
slide_hole_pts1 =  [
                   [ slide1_x0, wallex_d + slide_hole_y, 0.0 ],
                   [ slide1_x1, wallex_d + slide_hole_y, 0.0 ],
                   ];

slide_hole_pts2 =  [
                   [ slide2_x0, wallex_d + slide_hole_y, 0.0 ],
                   [ slide2_x1, wallex_d + slide_hole_y, 0.0 ],
                   ];

// Mounting Parameters
// Mount Hole Diameter
mnt_hole_d = 3.75; // [ 2 : 0.01: 7 ]
// Mount Hole Height
mnt_hole_h = wallmnt_d*2;  // [ 5: 1: 100 ]
// Mount Hole points
mnt_hole_points = [
                  [ wallex_w/2.0, 0,          -wallex_h/4 ],
                  [ wallex_w/2.0, wallex_d/2,  wallex_h/4 ],
                  ];

// Mount thickness
mnt_thickness = 5.00; // [0:1:50]

// Mount Chamfer Parameters
// Mount Chamfer Diameter1
mnt_chmfr_d1  = 8.0;  // [0:0.01:100]
// Mount Chamfer Diameter2
mnt_chmfr_d2  = 16.0; // [0:0.01:100]
// Mount Chamfer Height
mnt_chmfr_h = wallmnt_d;
// Mount Chamfer Points
mnt_chmfr_points = [
                    [wallex_w/2.0,mnt_thickness,         -wallex_h/4],
                    [wallex_w/2.0,mnt_thickness+wallex_d, wallex_h/4],
                    ];

// Slide Chamfer Parameters
// Slide Chamfer Diameter1
sld_chmfr_d1  = 8.5;  // [0:0.01:100]
// Slide Chamfer Diameter2
sld_chmfr_d2  = 15;    // [0:0.01:100]
// Slide Chamfer Height
sld_chmfr_h = 100;     // [0:1:100]

sld_chmfr1_x0 = wallex_w*1/4+slide_hole_w+slide_hole_x;
sld_chmfr1_x1 = wallex_w*1/4+slide_hole_w+slide_hole_l+slide_hole_x;

sld_chmfr2_x0 = wallex_w*1/4+wallmnt_w-(slide_hole_w+slide_hole_x);
sld_chmfr2_x1 = wallex_w*1/4+wallmnt_w-(slide_hole_w+slide_hole_l+slide_hole_x);
    
// Mount Chamfer Points
sld_chmfr_pts1 = [
                 [ sld_chmfr1_x0, wallex_d + slide_hole_y, wallex_h/2-mnt_thickness ],
                 [ sld_chmfr1_x1, wallex_d + slide_hole_y, wallex_h/2-mnt_thickness ],
                 ];

sld_chmfr_pts2 = [
                 [ sld_chmfr2_x0, wallex_d + slide_hole_y, wallex_h/2-mnt_thickness ],
                 [ sld_chmfr2_x1, wallex_d + slide_hole_y, wallex_h/2-mnt_thickness ],
                 ];



///< Parameters after this are hidden from the customizer
module __Customizer_Limit__(){}

///< hole pattern
module hole_pattern( d, h, points, center = true ){
    for( p = points ){
        rotate( [90,0,0] )
        translate( p )
            cylinder( d = d, h  = h, center = center );
    }
}

///< extrusion
module wall_extrusion( width, depth, height, hole_d, hole_h, hole_points ){
    difference(){
        cube( [width, depth, height] );
        //color("red")hole_pattern( d = hole_d, h = hole_h, points = hole_points );
    }
}


module mounting_holes( points, d, h, center = false ){
    for (p = points ){
        translate( p )
            rotate( [-90,0,0] )
            cylinder( d = d, h = h, center = center );
    }
}

module wall_mounting_chamfer( points, d1, d2, h, center = false ){
    for( p = points ){
        translate( p )
            rotate( [-90,0,0] )
            cylinder( d1 = d1, d2 = d2, h = h, center = center );
    }
}

module slide_mounting_chamfer( points, d1, d2, h, center = false ){
    hull(){
        for( p = points ){
            translate( p )
                rotate([180,0,0] )
                cylinder( d1 = d1, d2 = d2, h = h, center = center );
        }
    }
}

module adjustable_holes( points, d, h, center = true ){
    hull(){
        for( p = points ){
            translate( p )
                cylinder( d = d, h = h, center = center );
        }
    }
}

module wall_mount( width, depth, height ){
    diag = sqrt( pow( depth, 2 ) + pow( height, 2 ) );
    angle = asin( height / diag );

    difference(){
        color( "orange" )
            translate( [ wallex_w/4, 0.01, -wallex_h/2 ] )
            cube( [ width, depth, height ] );
        rotate( [ angle, 0, 0 ] )
        color( "blue" )
            translate( [ wallex_w/4, -depth/2, -wallex_h/2-height ] )
            cube( [ width+0.1, depth*2, height ] );
        #wall_extrusion( wallex_w, wallex_d, wallex_h, wallex_hd, wallex_hl, wallex_hp );
    }
}

///< Build object
//wall_extrusion( wallex_w, wallex_d, wallex_h, wallex_hd, wallex_hl, wallex_hp );
difference(){
   wall_mount( wallmnt_w, wallmnt_d, wallmnt_h );
   color( "purple" )
       #adjustable_holes( slide_hole_pts1, slide_hole_d, slide_hole_h );
       #adjustable_holes( slide_hole_pts2, slide_hole_d, slide_hole_h );
   color( "teal" )
       #mounting_holes( mnt_hole_points, mnt_hole_d, mnt_hole_h );
   color( "green")
       wall_mounting_chamfer( mnt_chmfr_points, mnt_chmfr_d1, mnt_chmfr_d2, mnt_chmfr_h );
   color( "green")
       slide_mounting_chamfer( sld_chmfr_pts1, sld_chmfr_d1, sld_chmfr_d2, sld_chmfr_h );
   color( "green")
       slide_mounting_chamfer( sld_chmfr_pts2, sld_chmfr_d1, sld_chmfr_d2, sld_chmfr_h );
}
