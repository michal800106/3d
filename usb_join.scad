$fn = 50;

width = 15;

module box() {
    linear_extrude(height=3)
    translate([-40/2, -4])
    square([17.5 + width + 16.5 + width + 40, 8]);
    
    translate([-(17.5+width)/2, 0])
    nut();
    translate([(17.5+width)/2, 0])
    nut();
    translate([17.5+width+(16.5+width)/2, 0])
    nut();
    translate([17.5+width+16.5+width+(17.5+width)/2, 0])
    nut();
    
    linear_extrude(height=7.5+3)
    union() {
        circle(d=7);
        translate([17.5 + width, 0])
        circle(d=7);
        translate([17.5 + width + 16.5 + width, 0])
        circle(d=7);
    }
}

module nut() {
    linear_extrude(height=3+2)
    circle(d=8);
}

module nut_hole() {
    linear_extrude(height=3+2)
    circle(d=3);
}

module nut_holes() {
    translate([-(17.5+width)/2, 0])
    nut_hole();
    translate([(17.5+width)/2, 0])
    nut_hole();
    translate([17.5+width+(16.5+width)/2, 0])
    nut_hole();
    translate([17.5+width+16.5+width+(17.5+width)/2, 0])
    nut_hole();
}

difference() {
    box();
    nut_holes();
}