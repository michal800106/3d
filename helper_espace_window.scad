$fn = 75;

female_width = 16;
female_depth = 15;
female_height = 39.5;

line_hole_d = 5;

cut_thicknes = 5;
cut_depth = (female_depth+line_hole_d)/2;


difference() {
    external_form();
    form();
};

module external_form() {
    translate([
        0,
        -cut_thicknes/2,
        0
    ])
    cube([
        female_width,
        female_depth+cut_thicknes,
        female_height+2*cut_thicknes],
    center=true);
};

module form() {
    union() {
        base();
        translate([
            0,
            (female_depth-cut_depth)/2,
            (female_height+cut_thicknes)/2
        ])
        cut();
        translate([
            0,
            (female_depth-cut_depth)/2,
            -(female_height+cut_thicknes)/2
        ])
        cut();
    };
};

module base() {
    cube([female_width, female_depth, female_height], center=true);
};

module line_hole() {
    cylinder(r1=line_hole_d/2, r2=line_hole_d/2, h=female_height, center=true);
};

module cut() {
    cube([
    line_hole_d,
    cut_depth,
    cut_thicknes
    ],
    center=true
    );
};