$fn = 50;

width_cable = 10;
depth_cable = 12;

width = 26.5;
height = 45;

depth_hang = 14;

hole1_width = 10;

hole2_depth = 8;

hole_size = 2.5;

cube_hole1_width = 6;
cube_hole1_depth = 5;
cube_hole1_height = 9;

cube_hole2_width = 6;
cube_hole2_depth = 8;
cube_hole2_height = 8;

hole1_distance_from_bottom = 5.5;

hole2_distance_width = 3;
hole2_distance_depth = 1.5;
hole2_distance_height = 1.5;

cube_hole3_width = 5;
cube_hole3_depth = depth_cable;
cube_hole3_height = 5;

slit2_height = 45;
slit2_width = 1.5;
slit2_depth = 6;

slit1_height = 45;
slit1_width = 7;
slit1_depth = 1.5;

stick_d = 11;
stick_height = 14.5;

stick_distance_width = 7.5;
stick_distance_height = 23.5;

tube_height = 2.5;
tube_d = 7;
tube_spare = 3;

tube_distance_height = 3;

tri_a = 14;
tri_depth = 4.5;

tri_distance_height = 22;

rotate1 = 14.5;


difference() {
    base_whole();
    union() {
        hole1();
        hole2();
    };
};
stick();
triangle();

module stick() {
    translate([stick_distance_width, -stick_height/2, stick_distance_height])
    rotate([90, 0, 0])
    difference() {
        cylinder(r1=stick_d/2, r2=stick_d/2, h=stick_height, center=true);
        tube();
    };
};

module slit2() {
    cube([slit2_width, slit2_depth, slit2_height]);
};

module triangle() {
    h = tri_a * 0.866;
    translate([0, tri_depth, tri_distance_height])
    rotate([90, 180-rotate1, 0])
    linear_extrude(height=tri_depth)
    polygon([[0, 0], [h, tri_a/2], [0, tri_a]]);
};

module tube() {
    translate([0, 0, (stick_height/2)-tube_distance_height])
    difference() {
        cylinder(r1=stick_d/2, r2=stick_d/2, h=tube_height, center=true);
        cylinder(r1=tube_d/2, r2=tube_d/2, h=tube_height, center=true);
        cube([stick_d, tube_height, stick_height], center=true);
    };
};

module slit1() {
    translate([0, (cube_hole1_depth-slit1_depth)/2, 2])
    rotate([0, 12, 0])
    translate([-slit1_width/2, 0, -slit1_height])
    cube([slit1_width, slit1_depth, slit1_height]);
    translate([-(width_cable-cube_hole1_width-2), (cube_hole1_depth-slit1_depth)/2, 0])
    cube([slit1_width, slit1_depth, slit1_height]);
};

module hole1() {
    translate([width_cable-cube_hole1_width-2 ,  hole1_distance_from_bottom, height-cube_hole1_height]) {
        cube([cube_hole1_width, cube_hole1_depth, cube_hole1_height]);
        slit1();
    };
};

module hole2() {
    translate([hole2_distance_width, hole2_distance_depth, hole2_distance_height])
    rotate([0,-rotate1,0])
    union() {
        translate([0, depth_cable-cube_hole2_depth-hole2_distance_depth, 0])
        cube([cube_hole2_width, cube_hole2_depth, cube_hole2_height]);
        translate([-(cube_hole3_width-cube_hole2_width)/2, -hole2_distance_depth, 0])
        cube([cube_hole3_width, cube_hole3_depth, cube_hole3_height]);
        translate([(cube_hole2_width-slit2_width)/2, -hole2_distance_depth, 0])
        slit2();
    };
};

module base_whole() {
    difference() {
        base();
        union() {
            translate([width_cable, depth_hang-hole2_depth, 0])
            cube([hole_size, hole2_depth, height]);
            translate([width_cable, depth_hang-hole2_depth, 0])
            cube([hole1_width, hole_size, height]);
        };
    };
};


module base() {
    union() {
        cube([width_cable, depth_cable, height]);
        translate([width_cable, 0, 0])
        cube([width-width_cable, depth_hang, height]);
    };
};