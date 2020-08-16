///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <led_array.scad>;
include <nameplate.scad>

///< Parameters
esp8266_h = 10;

/*
                                 Bp
                              <---->
                              F    G   Br(idge)
                              +    +<------>
                              |    | H                I
                              |    +----------------+      ^
              B       C       |                     |      |
          ^     +-----+       |    +--------+       |      |
          |     |     |       |    |M   ^  L|   W   |   Drop(D)
          |     |     |       |    |    |   +<----->+      |
          |     +<--->+D     E|    |  Anchor|       |      |
      Rise(R)   |  T  +-------+    |    |   +-------+      v
          |     |      ^-----^     |    V  K    ^     J
          |     |         W        |            | Thickness(T)
          v     +------------------+            v
              A                     N

 */

module half_frame( depth, height, Bp = 1.0, Br = 1.0, thickness = 1.0, overhang = 5.0, anchor = 4.0, hook = 1.0 ){
    h = height;
    d = depth;
    rise      = overhang + thickness;
    drop      = thickness + anchor;

    /* Data points */
    Ax = 0.0;                     Ay = 0.0;
    Bx = 0.0;                     By = rise;
    Cx = thickness;               Cy = rise;
    Dx = thickness;               Dy = thickness;
    Ex = thickness+d;             Ey = thickness;
    Fx = thickness+d;             Fy = h/2+thickness;
    Gx = thickness+Bp+d;          Gy = h/2+thickness;
    Hx = thickness+Bp+d;          Hy = thickness+drop;
    Ix = thickness+Bp+Br+d+hook;  Iy = thickness+drop;
    Jx = thickness+Bp+Br+d+hook;  Jy = thickness;
    Kx = thickness+Bp+Br+d;       Ky = thickness;
    Lx = thickness+Bp+Br+d;       Ly = thickness + anchor;
    Mx = thickness+Bp+d;          My = thickness + anchor;
    Nx = thickness+Bp+d;          Ny = 0.0;
     
    points = [
              [ Ax, Ay ],
              [ Bx, By ],
              [ Cx, Cy ],
              [ Dx, Dy ],
              [ Ex, Ey ],
              [ Fx, Fy ],
              [ Gx, Gy ],
              [ Hx, Hy ],
              [ Ix, Iy ],
              [ Jx, Jy ],
              [ Kx, Ky ],
              [ Lx, Ly ],
              [ Mx, My ],
              [ Nx, Ny ],
              ];

    polygon( points );
}

module whole_frame( d, h, Bp = 1.0, Br = 1.0, t = 1.0, o = 5.0, a = 4.0, hook = 1.0 ){
    color( rand_clr() )
        half_frame( d, h, Bp = Bp, Br = Br, thickness = t, overhang = o, anchor = a, hook = hook  );
    translate( [ 0, h, 0 ] )
        mirror([0,1,0])
        color( rand_clr() )
                    half_frame( d, h, Bp = Bp, Br = Br, thickness = t, overhang = o, anchor = a, hook = hook  );    
}

module frame( w, d, h, Bp = 1.0, Br = 1.0, t = 1.0, o = 5.0,  a = 4.0, hook = 1.0 ){
    difference(){
        linear_extrude( height = w )
        whole_frame( d, h, Bp = Bp, Br = Br, t = t, o = o, a = a, hook = hook );
    
        ///< LED array
        echo( "thickness: ", t );
        rotate( [ 270,270,0] )
            translate( [0,d+Bp,0] )
            led_array( w, 0, h );
    }
}

///< Build object
echo( nameplate_w, nameplate_d, nameplate_h  );
frame( nameplate_w, nameplate_d, nameplate_h, Bp = 2.0, Br = 3.0, t = 1, hook = nameplate_d*0.80  );
