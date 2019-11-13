$fn = 75;

cyl_d = 5;
cyl_height = 20;
slit_size_inside = [1.5, 1];

slit_size_outside = [1, 0.5];
cyl_outside_d = 6.5;
cyl_join_height = 3;

module stick_inside(slit_size) {
    difference() {
        linear_extrude(height=cyl_height)
        circle(cyl_d/2);
        for(i = [0:2]) {
            echo(i);
            rotate([0, 0, 90*i])
            linear_extrude(height=cyl_height)
            translate([-slit_size.x/2, cyl_d/2 - slit_size.y])
            square([slit_size.x, slit_size.y]);
        }
    }
}

module stick_outside(slit_size, height) {
   difference() {
        linear_extrude(height=height)
        circle(cyl_outside_d/2);
        stick_inside(slit_size);
    }  
}

translate([0, 0, cyl_height])
linear_extrude(height=cyl_join_height)
circle(cyl_outside_d/2);
        
translate([0, 0, cyl_height])
stick_outside(slit_size_outside, cyl_height);

stick_inside(slit_size_inside);
