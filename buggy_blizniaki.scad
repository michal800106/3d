$fn = 50;

hole1_r = 4.5;
hole1_depth = 13;
hole1_width = 21;
hole1_height = 9;

hole2_height = 29;
hole2_small_depth = 8;
hole2_small_width = 8;
hole2_big_depth = 6.5;
hole2_big_width = 17;


hole3_height = 9;
hole3_width = 90;
hole3_depth = 5.5;
hole3_position = 28.7;

hole4_d = 10;
hole4_width = 15;
hole4_depth = 20;
hole4_position = 12;

hole4_helper_height = 2;
hole4_helper_width = 40;
hole4_helper_depth = 6;

body_width = 28;
body_depth = 15.7;
body_height = 42;

stick_height = 44;
stick_width = 18.4;
stick_depth = 50;

holder_height = 60;
holder_width = 30;
holder_depth = 30;

connector_height = 7;

keeper_height = 30;
keeper_width = stick_width + 10;
keeper_depth = holder_depth;
keeper_position = holder_height - 20;

keeper_cut_height = 60;
keeper_cut_width = stick_width;
keeper_cut_depth = holder_depth;
keeper_cut_position = holder_height - 30;

screw_hole_d = 4.5;
screw_hole_position = keeper_position + keeper_height - 8;
screw_hole_width = 2 * holder_width;

module hole1() {
    translate(
        [
            -(hole1_depth-2*hole1_r)/2,
            -(hole1_width-2*hole1_r)/2,
            0
        ]
    )
    linear_extrude(height=hole1_height)
    minkowski() {
        circle(hole1_r);
        square([hole1_depth - 2*hole1_r, hole1_width - 2*hole1_r]);
    };
};


module hole2() {
    linear_extrude(height=hole2_height) {
        square([hole2_small_depth, hole2_small_width], center=true);
        square([hole2_big_depth, hole2_big_width], center=true);
    }
};

module hole3() {
    linear_extrude(height=hole3_height)
    square([hole3_depth, hole3_width], center=true);
};

module hole4() {
    difference() {
        translate([0, 0, hole4_d/2])
        rotate([0, 90, 0])
        translate([0, 0, -hole4_depth/2])
        linear_extrude(height=hole4_depth)
        hull() {
            circle(hole4_d/2);
            translate([-hole4_d/2, 0])
            square([hole4_d, hole4_width]);
        };

        linear_extrude(height=hole4_helper_height)
        square([hole4_helper_depth, hole4_helper_width], center=true);
    };
};

module hole() {
    union() {
        translate([0, 0, hole4_position])
        hole4();
        translate([0, 0, hole3_position])
        hole3();
        translate([0, 0, hole1_height])
        hole2();
        hole1();
    };
};

module body_base() {
    resize([body_depth, body_width])
    translate(
        [
            -(hole1_depth-2*hole1_r)/2,
            -(hole1_width-2*hole1_r)/2,
        ]
    )
    minkowski() {
        circle(hole1_r);
        square([hole1_depth - 2*hole1_r, hole1_width - 2*hole1_r]);
    };

};

module body() {
    linear_extrude(height=body_height)
    body_base();
};

module stick() {
    rotate([0, 90, 0])
    translate([0, 0, -stick_depth/2])
    linear_extrude(height=stick_depth)
    resize([stick_height, stick_width])
    circle(1);
};

module holder_body() {
    hull() {
        translate([0, 0, holder_height/2])
        rotate([0, 90, 0])
        translate([0, 0, -holder_depth/2])
        linear_extrude(height=holder_depth)
        resize([holder_height, holder_width])
        circle(1);
    };
};

difference() {
    union() {
        translate([0, 0, -(body_height - holder_height)/2])
        body();
        translate([
            0,
            -(stick_width+body_width)/2,
            0
        ])
        holder();
    };
    translate([0, 0, -(body_height - holder_height)/2])
    hole();
    translate([
                0,
                -(stick_width+body_width)/2,
                holder_height/2
            ])
    stick();
};

module holder() {
    difference() {
        union() {
            holder_body();
            translate([0, 0, keeper_position])
            linear_extrude(height=keeper_height)
            square([keeper_depth, keeper_width], center=true);
        };
        translate([
                    0,
                    0,
                    holder_height/2
                  ])
        stick();
    
        translate([0, 0, keeper_cut_position])
        linear_extrude(height=keeper_cut_height)
        square([keeper_cut_depth, keeper_cut_width], center=true);
    
        translate([0, 0, screw_hole_position])
        rotate([90, 0, 0])
        cylinder(r1=screw_hole_d/2, r2=screw_hole_d/2, h=screw_hole_width, center=true);
    }
};
