$fn = 75;

male_width = 12.5;
male_depth1 = 8.5;
male_depth2 = 4.6;

male_height = 10;

line_hole_d = 4.6;
line_hole_height = 8;

big_top_d = 7.3;
big_top_height = 5;

small_top_d = 5;
small_top_height = 2.5;

small_line_hole_d = 2.5;

difference() {
    union() {
        male();
        big_top();
        small_top();
    };
    line_hole();
    small_line_hole();
};

module male() {
    x = male_width/2;
    y1 = male_depth1/2;
    y2 = male_depth2/2;
    
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