//translate([-56, 0, -4.3]) {
//import("/home/michalz/Downloads/Crash_Probe_with_optical_switch/files/3-StemH.stl");
//}
//
translate([3, -22.15, -3])
import("/home/michalz/Downloads/Anet_A8_E3D_V6_Bowden_MODULAR_X_Carriage_V4_BEST_ONE/files/E3DV6_BasePlate_V4.stl");

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

h_cut_size = [body_width+20, 4.5, 4.5];
h_cut_pos = [0, body_depth - 5, wall_thickness];

module h_cut() {
    linear_extrude(height=h_cut_size.z)
    square([h_cut_size.x, h_cut_size.y], center=true);
};

module body() {
    difference() {
        union() {
            translate([-body_width/2, 0, 0])
            linear_extrude(height=body_height)
            square([body_width, body_depth]);

            translate([body_width/2+2, body_depth/2, -3])
            linear_extrude(height=7)
            square([12, body_depth], center=true);
        };

        translate([body_width/2+3, body_depth/2, -3])
        linear_extrude(height=5)
        square([11, body_depth], center=true);

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
        
        #translate([-long_cut_width/2, 0, wall_thickness])
        linear_extrude(height=long_cut_height)
        square([long_cut_width, long_cut_depth]);
        
        translate([8, 5.8, -5])
        linear_extrude(height=15)
        circle(2, center=true);

        translate([8, 19.6, -5])
        linear_extrude(height=15)
        circle(2, center=true);
        
        translate([9.4, 30.6, -5])
        linear_extrude(height=15)
        circle(3, center=true);
    }
}

module corner(height) {
    linear_extrude(height=height)
    polygon([
        [corner_cut_size, 0],
        [0, corner_cut_size],
        [0, 0]
    ]);
}

module plate() {
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

difference() {
    body();
    translate(h_cut_pos)
    h_cut();
};

translate([0, 36, 8])
plate();
