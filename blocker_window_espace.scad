$fn = 75;

blocker_height = 20;
blocker_width = 16;
blocker_depth = 12;

blocker_cut_width = 1.5;

cut_height = 13.5;
cut_depth = 1.5;
cut_width = 3.5;

line_hole_d = 4.7;
line_hole_height = 16;
small_line_hole_d = 2.3;

translate([0, 0, blocker_height/2])
rotate([0, 180, 0])
difference() {
    blocker_base();
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
    translate([
        0,
        0,
        -blocker_height
    ])
    blocker_cut();
};
linear_extrude(height=0.5)
square([blocker_height*2, blocker_width*2], center=true);

module blocker_base() {
    cube([blocker_width, blocker_depth, blocker_height], center=true);
};

module blocker_cut() {
    translate([0, blocker_depth/4, blocker_height])
    cube([blocker_cut_width, blocker_depth/2, blocker_height], center=true);
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