$fn = 50;

cyl_h = 15;
cyl_d = 11.1;

ring_h = 1.75;
ring_distance = 1.2;
ring_thickness = 1;

thickness = 3;

module tube(d, t, h) {
    linear_extrude(h)
    difference() {
        circle(d=d+t);
        circle(d=d);
    }
};

module half_sphere(d) {
    intersection() {
        sphere(d = d);
    
        translate([-d/2, -d/2, 0])
        cube(d);
    };
};

difference() {
    tube(cyl_d, thickness, cyl_h);
    
    translate([0, 0, ring_distance])
    tube(cyl_d, ring_thickness, ring_h);
};

//*translate([0, 0, cyl_h])
//difference() {
//    half_sphere(d = cyl_d + thickness);
//    half_sphere(d = cyl_d);
//};

translate([-110.3, -109.7, cyl_h])
import("/usr/home/michalz/Downloads/smile_owl_hole_scaled.stl");
