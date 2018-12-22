$fn = 75;

blocker_height = 15;
blocker_width = 16;
blocker_depth = 12;

cut_height = 8.5;
cut_depth = 1.5;
cut_width = 3.5;

line_hole_d = 4.7;
line_hole_height = 10;
small_line_hole_d = 2.3;

difference() {
    blocker_base();
    union() {
        translate([
            (blocker_width-cut_width)/2,
            0,
            (blocker_height-cut_height)/2
        ])
        cut();
        translate([
            -(blocker_width-cut_width)/2,
            0,
            (blocker_height-cut_height)/2
        ])
        cut();
        translate([
            0,
            0,
            -(blocker_height-line_hole_height)/2
        ])
        line_hole();
        small_line_hole();
    };
};

module blocker_base() {
    cube([blocker_width, blocker_depth, blocker_height], center=true);
};

module cut() {
    cube([cut_width, cut_depth, cut_height], center=true);
};

module line_hole() {
    cylinder(r1=line_hole_d/2, r2=line_hole_d/2, h=line_hole_height, center=true);
};

module small_line_hole() {
    cylinder(r1=small_line_hole_d/2, r2=small_line_hole_d/2, h=blocker_height, center=true);
};