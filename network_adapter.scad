$fn = 50;

thickness = 3;
circle_d = 6.3;
size = [39.3+2*thickness-circle_d, 23+2*thickness-circle_d];
height=11;
hole_size = [16, 13];

difference() {
    union() {
        translate([0, 0, height])
        linear_extrude(height=2)
        body(size, circle_d+4);
         
        linear_extrude(height=height)
        difference() {
            body(size, circle_d);
            translate([0, hole_size.y/2 - 10/2])
            square(hole_size, center=true);
        }
    };
    
    translate([0, 0, thickness])
    linear_extrude(height=height+1) {
        hull() {
            translate([-28/2, 0])
            circle(d=10);
            translate([28/2, 0])
            circle(d=10);
        };
        square([23, 23], center=true);
    }
};

module body(size, circle_d) {
    minkowski() {
        circle(d=circle_d);
        square([size.x, size.y], center=true);
    }
}
