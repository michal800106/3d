$fn = 75;

female_width = 18;
female_depth = 15;
female_height = 38.5;

cut_width = 3.5;
cut_depth = 2;
cut_height = 2;
cut_leaning = -7.6;
cut_stop_depth = 5.5;

cut_begin = 15;
distance_between_cuts = 5;

male_width = 13.5;
male_depth1 = 9.5;
male_depth2 = 5;

male_height = 12;

spring_hole_d = 8;
spring_hole_height = 28;

line_hole_d = 5;

translate([0, 0, female_depth/2])
rotate([-90, 0, 0])
difference() {
    base();
    union() {
        cuts();
        male();
        spring_hole();
        line_hole();
    };
};
rotate([0, 0, 90])
linear_extrude(height=0.5)
square([female_height*2, female_width*2], center=true);

module line_hole() {
    cylinder(r1=line_hole_d/2, r2=line_hole_d/2, h=female_height, center=true);
};

module spring_hole() {
    translate([0, 0, -(female_height-spring_hole_height)/2])
    cylinder(r1=spring_hole_d/2, r2=spring_hole_d/2, h=spring_hole_height, center=true);
};

module base() {
    cube([female_width, female_depth, female_height], center=true);
};

module cuts() {
    num = floor((female_height - cut_begin) / distance_between_cuts);
    for(i = [0:num]) {
        echo(i * distance_between_cuts);
        translate([0, 0, -(female_height/2) + cut_begin + (i * distance_between_cuts)])
        cut();
    };
};

module cut() {
    big_depth = female_depth + 2.5 - cut_depth;
    
    rotate([cut_leaning, 0, 0])
    difference() {
        cube([female_width+5, female_depth+5, cut_height], center=true);
        translate([0, cut_depth/2 + 1.25, 0])
        cube(
            [
                female_width - 2 * cut_width,
                big_depth,
                cut_height
            ],
            center=true
        );
        translate(
            [
                0,
                (big_depth-cut_stop_depth+2.5)/2,
                0
            ]
        )
        cube(
            [
                female_width+5,
                cut_stop_depth + 2.5,
                cut_height
            ],
            center=true
        );
    };
};

module male() {
    x = male_width/2;
    y1 = male_depth1/2;
    y2 = male_depth2/2;
    
    translate([0, 0, -(female_height-male_height)/2])
    translate([0, 0, -male_height/2])
    linear_extrude(height=male_height)
    polygon(
        [
            [-x, y2],
            [0, y1],
            [x, y2],
            [x, -y2],
            [0, -y1],
            [-x, -y2]
        ]
    );
};