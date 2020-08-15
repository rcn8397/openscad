///< Object definition
use <../lib/math.scad>;
use <../lib/utils.scad>;
use <led_array.scad>;
include <nameplate.scad>

///< Parameters
esp8266_h = 10;

module frame( w, d, h, show_nameplate = false ){
     lip_h = 2.0;
     thickness = 1.0;
     overhang = thickness + lip_h;
     Ax = 0.0;                   Ay = 0.0;
     Bx = 0.0;                   By = overhang;
     Cx = thickness;             Cy = overhang;
     Dx = thickness;             Dy = overhang - lip_h;
     Ex = thickness+d;           Ey = overhang - lip_h;
     Fx = thickness+d;           Fy = h/2;
     Gx = thickness*2+d;         Gy = h/2;
     Hx = thickness*2+d;         Hy = overhang;
     Ix = thickness*3+d*2;       Iy = overhang;
     Jx = thickness*3+d*2;       Jy = overhang-lip_h-thickness;
     Kx = thickness*2+d*2;       Ky = overhang-lip_h-thickness;
     Lx = thickness*2+d*2;       Ly = lip_h;
     Mx = thickness*2+d;         My = lip_h;
     Nx = thickness*2;           Ny = 0.0;
     
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
frame( nameplate_w, nameplate_d, nameplate_h  );
