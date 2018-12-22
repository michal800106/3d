length_plate = 70;
width_plate = 30;

d_big_hole = 16.5;

module hole() {
    cylinder(h=3.6, r1=1.5, r2=5, center=true);
};


difference() {
    linear_extrude(height = 3.5, center = true, convexity = 10, twist = 0) {
        difference() {
            square(size = [length_plate, width_plate]);
            translate([14, 15.7, 0]) {
                hull() {
                    translate([34.85,0,0]) {
                        circle(d_big_hole/2);
                    };
                    translate([7.85, 0, 0]) {
                        circle(d_big_hole/2);
                    };
                };
            };
        };
    };
    
    translate([7, 15.7, 0]) {
        hole();
    };
    
    translate([63, 15.7, 0]) {
        hole();
    };
};