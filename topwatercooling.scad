use <threadlib/threadlib.scad>

$fn=25;
//thread("G1/4-int", turns=10);

holes_positions = [
    [
        44.5/2,
        44.5/2
    ],
    [
        44.5/2,
        -44.5/2
    ],
    [
        -44./2,
        44.5/2
    ],
    [
        -44.5/2,
        -44.5/2
    ]
];

hole_dist = 18/2 + 5.75;

top_height = 7.2;
chamber_height = 2.6;
chamber_width = 34;
bottom_height = 5;

nut_head_d = 6;
nut_thread_d = 3.5;

module seal() {
    linear_extrude(height=chamber_height)
    difference() {
        minkowski() {
        square([chamber_width, chamber_width], center=true);
        circle(r=4);
    }
    minkowski() {
        square([chamber_width, chamber_width], center=true);
        circle(r=1.5);
    }
    }
}

module nut_head_holes() {
    height=top_height+chamber_height-bottom_height;
    
    for (pos = holes_positions) {
        translate([pos.x, pos.y, bottom_height])
        cyl(nut_head_d/2, height);
    }
};

module nut_thread_holes() {
    height=top_height-chamber_height+bottom_height;
    
    for (pos = holes_positions) {
        translate([pos.x, pos.y])
        cyl(nut_thread_d/2, height);
    }
};

module cyl(r, h) {
    linear_extrude(height=h)
    circle(r=r);
};

difference() {
    union() {
        linear_extrude(height=bottom_height)
        square([50, 50], center=true);

        translate([0, 0, chamber_height])
        linear_extrude(height=top_height)
        square([44, 44], center=true);
    }

    translate([0, 0, -0.01])
    linear_extrude(height=chamber_height+0.02)
    square([chamber_width, chamber_width], center=true);

    translate([0, 0, chamber_height])
    rotate([0, 0, 45]) {
        translate([hole_dist, 0, 0])
        tap("G1/4", turns=5);
    
        translate([-hole_dist, 0, 0])
        tap("G1/4", turns=5);
    }
    
    nut_head_holes();
    nut_thread_holes();
    
    seal();
}

