$fn=50;

arc_d=6.3;

size = [7.5 + arc_d, 126];
size2 = [size.x + 4, size.y + 15];
height=11;

linear_extrude(height=height)
box(size);

*translate([0, 0, height])
linear_extrude(height=2)
box(size2);


module box(size) {
    difference() {
        square(size, center=true);
        translate([size.x/2, 0])
        cut();
        translate([-size.x/2, 0])
        cut();
    }
}

module cut() {
    minkowski() {
        circle(d=arc_d);
        square([0.001, size.y-arc_d], center=true);
    }
}