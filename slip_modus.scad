use <MCAD/shapes.scad>;

$fn = 50;

width_cable = 11;
depth_cable = 12;

width = 27.5;
height = 35;

depth_hang = 14;

hole1_width = 10;

hole2_depth = 8;

hole_size = 2.5;

cube_hole1_width = 6*2/sqrt(3);
cube_hole1_depth = 6;
cube_hole1_height = 9;

hole1_distance_from_bottom = 5.5;

hole2_distance_width = 4;
hole2_distance_depth = 1.5;
hole2_distance_height = 1.5;

slit2_height = 47;
slit2_width = 7;
slit2_depth = 2;

slit1_height = 45;
slit1_width = 8;
slit1_depth = 2;

tube_height = 2.5;
tube_d = 7;
tube_spare = 3;

tube_distance_height = 3;

window_hook_d = 8.6;
window_hook_height = 6;
window_hook_angle = 45;

window_plate_depth = 3;
window_plate_height = 20;
window_plate_width = 75;

window_plate_cut_pos1 = 12;
window_plate_cut_pos2 = 31;

window_plate_cut_width = 2;

window_hook_pos_w = window_plate_width/2 - 20.5;
window_hook_pos_h = 15;

window_joint_depth = 7.2 + window_plate_depth;
window_joint_height = 11;
window_joint_width = window_plate_width;

window_pos = [15-6-(window_hook_pos_w - width/2), 0, height-window_joint_height-22+5.6];

module window_hook() {
    difference() {
        linear_extrude(height=window_hook_height)
        circle(d=window_hook_d);
        
        translate([0, 0, window_hook_height - 2])
        rotate([0, -window_hook_angle, 0])
        linear_extrude(height=window_hook_height)
        square(2 * window_hook_d, center=true);
    
        translate([window_hook_d - 1, 0, 0])
        linear_extrude(height=window_hook_height - 1)
        square(window_hook_d, center=true);
    }
}

module window_plate() {
    #linear_extrude(height=window_plate_height)
    //difference() {
        square([window_plate_width, window_plate_depth], center=true);
        //translate([(window_plate_width + window_plate_cut_width)/2 - window_plate_cut_pos1, 0])
        //square([window_plate_cut_width, window_plate_depth], center=true);
    
        //translate([(window_plate_width + window_plate_cut_width)/2 - window_plate_cut_pos2, 0])
        //square([window_plate_cut_width, window_plate_depth], center=true);
    //}
}

module window() {
    translate([window_hook_pos_w, window_plate_depth/2, window_hook_pos_h])
    rotate([-90, 90, 0])
    window_hook();
    
    window_plate();
    
    translate([0, (window_joint_depth - window_plate_depth)/2, -window_joint_height])
    linear_extrude(height=window_joint_height)
    square([window_joint_width, window_joint_depth], center=true);
}

translate([0, -8.9, 0])
linear_extrude(height=10)
square([80, 2.5], center=true);

linear_extrude(height=0.5)
square([80, 70], center=true);

translate([0,0,0.5])
difference() {
    union(){
        translate([-width/2, 0, 0])
        base_whole();
        translate(window_pos)
        translate([0, window_plate_depth/2 - window_joint_depth, window_joint_height])
        window();
    };
    translate([-width/2, 0, 0])
    union() {
        hole1();
        hole2();
    };
};
//linear_extrude(height=0.2)
//translate([-10, -20])
//square([50, 50]);

module slit2() {
    rotate([3, -10, -5])
    translate([-slit2_width/2, slit2_depth, 0])
    cube([slit2_width, slit2_depth, slit2_height]);
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
    translate([1, (cube_hole1_depth-slit1_depth)/2, 10])
    rotate([2, 10, 0])
    translate([-slit1_width/2, 0, -slit1_height])
    cube([slit1_width, slit1_depth, slit1_height]);
};

module hole1() {
    translate([width_cable-cube_hole1_width-2 ,  hole1_distance_from_bottom-2, height-cube_hole1_height]) {
        //cube([cube_hole1_width, cube_hole1_depth, cube_hole1_height]);
        translate([(cube_hole1_depth)/sqrt(3), cube_hole1_depth/2, cube_hole1_height/2])
        hexagon(cube_hole1_depth, cube_hole1_height);
        slit1();
    };
};

module hole2() {
    translate([hole2_distance_width-1, hole2_distance_depth+2, hole2_distance_height-3])
    union() {
        translate([(cube_hole1_depth)/sqrt(3), cube_hole1_depth/2, cube_hole1_height/2])
        hexagon(cube_hole1_depth, cube_hole1_height);
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
            cube([hole1_width+1, hole_size, height]);
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