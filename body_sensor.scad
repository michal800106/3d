%translate([-25.85, -22.15, 0.16])
import("/home/michalz/Downloads/Crash_Probe_with_optical_switch/files/1-Main.stl");


$fn = 25;

wall_thickness = 3;

body_width = 11;
body_depth = 50;
body_height = 11;

big_cut_width = 11;
big_cut_depth = 5;
big_cut_height = wall_thickness;
big_cut_position_depth = 19;
big_cut_position_height = body_height - wall_thickness;

corner_cut_size = 2;

long_cut_width = 5;
long_cut_height = 5;
long_cut_depth = body_depth;

corner2_distance_depth = big_cut_position_depth + big_cut_depth;
corner2_distance_width = long_cut_width/2;

difference() {
    translate([-body_width/2, 0, 0])
    linear_extrude(height=body_height)
    square([body_width, body_depth]);
    
    
    translate(
        [
            -big_cut_width/2,
            big_cut_position_depth,
            big_cut_position_height
        ]
    )
    linear_extrude(height=big_cut_height)
    square([big_cut_width, big_cut_depth]);
    
    translate([-body_width/2, 0, 0])
    corner(body_height);
    
    translate([body_width/2, 0, 0])
    rotate([0, 0, 90])
    corner(body_height);
    
    translate(
        [
            corner2_distance_width,
            corner2_distance_depth,
            wall_thickness
        ]
    )
    corner(big_cut_height - wall_thickness);
    
    translate(
        [
            -corner2_distance_width,
            corner2_distance_depth,
            wall_thickness
        ]
    )
    rotate([0, 0, 90])
    corner(big_cut_height - wall_thickness);
    
    translate([-long_cut_width/2, 0, wall_thickness])
    linear_extrude(height=long_cut_height)
    square([long_cut_width, long_cut_depth]);
}

module corner(height) {
    linear_extrude(height=height)
    polygon([
        [corner_cut_size, 0],
        [0, corner_cut_size],
        [0, 0]
    ]);
}

translate([0, 36, 8])
union() {
    linear_extrude(height=3)
    difference() {
        hull() {
            translate([-8.3, 1, 0])
            circle(r=3, center=true);
        
            translate([8.3, 1, 0])
            circle(r=3, center=true);
        };
        translate([-8.3, 1, 0])
        circle(r=1.5, center=true);
        
        translate([8.3, 1, 0])
        circle(r=1.5, center=true);
    };
    linear_extrude(height=6)
    difference() {
        union() {
            translate([-8.3, 1, 0])
            circle(r=3, center=true);
            translate([8.3, 1, 0])
            circle(r=3, center=true);
        };

        translate([-8.3, 1, 0])
        circle(r=1.5, center=true);
        translate([8.3, 1, 0])
        circle(r=1.5, center=true);
    }
};