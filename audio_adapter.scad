$fn = 50;

small_l = 58.5;
small_d = 7;

step = (small_l - small_d) / 5;

big_d = 9.2;
big_dist = 4.15;
big_pos = [0, (step * 5) + big_dist + (big_d + small_d)/2];

thickness = 3;
circle_d = 6.3;
size = [20+2*thickness-circle_d, 98+2*thickness-circle_d];
size_inside = [size.x - 2*thickness, size.y - 2*thickness];
height=11;

echo(step);


difference() {
    union() {
        translate([-3, size.y/2-14, height])
        linear_extrude(height=2)
        body(size, circle_d+4);
    
        linear_extrude(height=height)
        difference() {
            translate([-3, size.y/2-14])
            body(size, circle_d);
            for(i = [0 : 5]) {
                echo(i);
                translate([0, step * i])
                circle(d=small_d);
            }
            
            translate(big_pos)
            circle(d=big_d);
        }
    };    

    translate([-3, size.y/2-14, thickness])
    linear_extrude(height=height)
    body(size_inside, circle_d);
}


module body(size, circle_d) {
    minkowski() {
        circle(d=circle_d);
        square([size.x, size.y], center=true);
    }
}