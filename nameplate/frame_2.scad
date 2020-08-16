///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <led_array.scad>;
include <nameplate.scad>

///< Parameters
esp8266_h = 10;

/*
                                 T
                              <---->
                              F    G
                              +    +
                              |    | H                I
                              |    +----------------+      ^
              B       C       |                     |      |
          ^     +-----+       |    +--------+       |      |
          |     |     |       |    |M      L|   W   |   Drop(D)
          |     |     |       |    |        +<----->+      |
          |     +<--->+D     E|    |        |       |      |
      Rise(R)   |  T  +-------+    |        +-------+      v
          |     |      ^-----^     |       K    ^     J
          |     |         W        |            | Thickness(T)
          v     +------------------+            v
              A                     N

 */

module half_frame( w, d, h, show_nameplate = false ){
    thickness = 1.0;
    overhang  = 5.0;
    rise      = overhang + thickness;
    anchor    = 4.0;
    drop      = thickness + anchor;
    
    
    Ax = 0.0;                   Ay = 0.0;
    Bx = 0.0;                   By = rise;
    Cx = thickness;             Cy = rise;
    Dx = thickness;             Dy = thickness;
    Ex = thickness+d;           Ey = thickness;
    Fx = thickness+d;           Fy = h/2;
    Gx = thickness*2+d;         Gy = h/2;
    Hx = thickness*2+d;         Hy = thickness+drop;
    Ix = thickness*3+d*2;       Iy = thickness+drop; ///<3 thickness here but not part of diagram
    Jx = thickness*3+d*2;       Jy = thickness;
    Kx = thickness*3+d;         Ky = thickness;
    Lx = thickness*3+d;         Ly = thickness + anchor;
    Mx = thickness*2+d;         My = thickness + anchor;
    Nx = thickness*2+d;         Ny = 0.0;
     
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

///< Build object
echo( nameplate_w, nameplate_d, nameplate_h  );
half_frame( nameplate_w, nameplate_d, nameplate_h  );
