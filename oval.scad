/// Oval
$fn=30;
/// Example
translate()oval(1,2,1);

module oval(w,l, height, center = false) {
 scale([1, l/w, 1]) cylinder(h=height, r=w, center=center);
}
