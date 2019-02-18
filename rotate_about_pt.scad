/// This is pulled from stackoverflow
/// https://stackoverflow.com/questions/45826208/openscad-rotating-around-a-particular-point


// rotate as per a, v, but around point pt
module rotate_about_pt(a, v, pt) {
    translate(pt)
        rotate(a,v)
            translate(-pt)
                children();   
}

color("Red")cube([10,10,1]);
rotate_about_pt(45,0,[5,5,0]) cube([10,10,1]);
