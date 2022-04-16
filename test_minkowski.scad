$fn=25;

difference() {
minkowski() {
    square([30-4, 30-4], center=true);
    circle(r=4);
}

minkowski() {
    square([30-4, 30-4], center=true);
    circle(r=1.5);
}
}