$fn = 75;

inside_d = 17/2;
outside_d = 22.5/2;
thickness = 1.5;

linear_extrude(height=thickness)
difference() {
    circle(outside_d);
    circle(inside_d);
};