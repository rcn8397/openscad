/// Stackoverflow example module for a line
/// https://stackoverflow.com/questions/49533350/is-that-possible-to-draw-a-line-using-openscad-by-joining-different-points

$fn=30;
module line(start, end, thickness = 1) {
    hull() {
        translate(start) sphere(thickness);
        translate(end) sphere(thickness);
    }
}

line([0,0,0], [5,23,42]);
