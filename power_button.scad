$fn = 75;


linear_extrude(height=10)
difference() {
    circle(d=16+14+20);
    circle(d=16.5+14);
    for (i = [0, 1, 2]) {
        rotate([0, 0, 120 * i])
        translate([0, (16 + 14 + 20)/2 - 4.5])
        circle(d=4);
    }
}