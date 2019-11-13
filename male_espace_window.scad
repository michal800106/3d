$fn = 75;

male_width = 14;
male_depth1 = 14;
male_depth2 = 14;

male_height = 25;

line_hole_d = 8;
line_hole_height = 20;

big_top_d = 10;
big_top_height = 5;

small_top_d = 5;
small_top_height = 2.5;

small_line_hole_d = 2.5;

regulator_size = [12, 12, 7];
regulator_pos = [0, 0, -male_height/2 + regulator_size.z/2];

difference() {
    union() {
        male();
        big_top();
        small_top();
    };
    line_hole();
    small_line_hole();
    regulator();
};

module regulator() {
    translate(regulator_pos)
    cube(regulator_size, center=true);
};

module male() {
    x = male_width/2;
    y1 = male_depth1/2;
    y2 = male_depth2/2;
    
    translate([0, 0, -male_height/2])
    linear_extrude(height=male_height)
    polygon(
        [
            [-x, y1],
            [0, y1],
            [x, y1],
            [x, -y1],
            [0, -y1],
            [-x, -y1]
        ]
    );
};

module line_hole() {
    translate([0, 0, -(male_height-line_hole_height)/2])
    cylinder(r1=line_hole_d/2, r2=line_hole_d/2, h=line_hole_height, center=true);
};

module small_line_hole() {
    height = male_height + big_top_height + small_top_height;
    translate([0, 0, (height-male_height)/2])
    cylinder(r1=small_line_hole_d/2, r2=small_line_hole_d/2, h=height, center=true);
};

module big_top() {
    translate([0, 0, (male_height+big_top_height)/2])
    cylinder(r1=big_top_d/2, r2=big_top_d/2, h=big_top_height, center=true);
};

module small_top() {
    translate([0, 0, (male_height+small_top_height)/2+big_top_height])
    cylinder(r1=small_top_d/2, r2=small_top_d/2, h=small_top_height, center=true);
};