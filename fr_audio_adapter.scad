$fn = 50;

circle_d = 12;
dist = (22 - 6.6);
size = [26.5 + dist - circle_d, 104.5 + dist - circle_d];
height=9.5;

nut_d = 6.5;
screw_d = 3;
nut_height = 1;

difference() {
    linear_extrude(height=height)
    difference() {
        body(size, circle_d+20);
        body(size, circle_d);
    };
    for(i=[[-1,1], [-1, -1], [-1, 0], [1, 0], [1, -1], [1, 1]]) {
        translate([i.x * 26.5, i.y * 45]) {
            linear_extrude(10)
            circle(d=screw_d);
            
            translate([0, 0, height-nut_height])
            linear_extrude(nut_height)
            circle(d=nut_d);
        }
    }
}


module body(size, circle_d) {
    minkowski() {
        circle(d=circle_d);
        square([size.x, size.y], center=true);
    }
}