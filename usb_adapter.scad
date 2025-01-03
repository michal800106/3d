$fn = 50;

thickness = 2;
circle_d = 6.3;
size = [39.3+2*thickness-circle_d, 11.3+2*thickness-circle_d];
height=11;
hole_size = [13, 5.2];

difference() {
    union() {
        #linear_extrude(height=2)
        body(size, circle_d+4);
        translate([0, 0, 2]) 
        linear_extrude(height=height)
            difference() {
            body(size, circle_d);
            square(hole_size, center=true);
        }
    };
    linear_extrude(height=height+1) {
        hull() {
            translate([-30/2, 0])
            circle(d=10);
            translate([30/2, 0])
            circle(d=10);
        };
        
        square([22, 12], center=true);
    }
};

module body(size, circle_d) {
    minkowski() {
        circle(d=circle_d);
        square([size.x, size.y], center=true);
    }
}

