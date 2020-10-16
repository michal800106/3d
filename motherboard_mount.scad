$fn = 50;

linear_extrude(height=9)
difference() {
    circle(d=7);
    circle(d=3);
};

difference() {
    linear_extrude(height=3)
    difference() {
        square([30, 10], center=true);
        circle(d=3);
    };
    
    translate([-10, 0, 3/2])
    cylinder(h=3, d1=3, d2=8, center=true);
    
    translate([10, 0, 3/2])
    cylinder(h=3, d1=3, d2=8, center=true);
}