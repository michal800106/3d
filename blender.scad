$fn = 75;

big_d = 47.5;
small_d = 35;

rant = 8;

width = 77;

top_rant_height = 2.7;
bottom_rant_height = 3.7;

body_height = 28.5;

cut_bottom_left = 35;
cut_bottom_right = 38;

cut_top_left = 49;
cut_top_right = 49;

cuffy_distance_near = 24;
cuffy_distance_far = 70;

cuffy_thick = 3.5;

cuffy_height = body_height +
                top_rant_height +
                bottom_rant_height +
                2 * cuffy_thick;

support_d = 7;

support1_position_width = 28;
support1_position_depth = -27;

support2_position_width = 60;
support2_position_depth = -22;

support3_position_width = 28;
support3_position_depth = 27;

support4_position_width = 60;
support4_position_depth = 22;

big_joint_d = 15;


module body() {
    translate([big_d/2, 0, 0])
    linear_extrude(height=body_height)
    hull() {
        circle(big_d/2, center=true);
        translate([width - big_d/2 - small_d/2, 0, 0])
        circle(small_d/2, center=true);
    };
};

module cuffy() {
    hang_width = cuffy_distance_far - cuffy_distance_near;
    hang_depth = big_d + 3* cuffy_thick;
    hang_height = bottom_rant_height +
                    body_height +
                    top_rant_height +
                    3 * cuffy_thick;
    intersection() {
        translate(
            [
                cuffy_distance_near,
                -hang_depth/2,
                -cuffy_thick/2
            ]
        )
        cube(
            [
                hang_width,
                hang_depth,
                hang_height
            ]
        );
        translate([big_d/2, 0, 0])
        linear_extrude(height=cuffy_height)
        hull() {
            circle(big_d/2 + cuffy_thick, center=true);
            translate([width - big_d/2 - small_d/2, 0, 0])
            circle(small_d/2 + cuffy_thick, center=true);
        };
    };
};

module bottom() {
    linear_extrude(height=bottom_rant_height)
    intersection() {
        polygon(
            [
                [0, big_d/2],
                [cut_bottom_left, big_d/2],
                [cut_bottom_right, -big_d/2],
                [0, -big_d/2],
            ]
        );
        translate([big_d/2, 0, 0])
        hull() {
            circle(big_d/2 - rant, center=true);
            translate([width - big_d/2 - small_d/2, 0, 0])
            circle(small_d/2 - rant, center=true);
        };
    };
};

module big_joint() {
    translate([0, 0, body_height/2])
    cylinder(r1=big_joint_d/2, r2=big_joint_d/2, h=body_height, center=true);
}


module top() {
    linear_extrude(height=top_rant_height)
    intersection() {
        polygon(
                [
                    [0, big_d/2],
                    [cut_top_left, big_d/2],
                    [cut_top_right, -big_d/2],
                    [0, -big_d/2],
                ]
        );
        translate([big_d/2, 0, 0])
        hull() {
            circle(big_d/2 - rant, center=true);
            translate([width - big_d/2 - small_d/2, 0, 0])
            circle(small_d/2 - rant, center=true);
        };
    };
};

module base() {
    union() {
        bottom();
        translate([0, 0, bottom_rant_height])
        body();
        translate([0, 0, bottom_rant_height + body_height])
        top();
    };
};

module support(pos_width, pos_depth) {
    translate([pos_width, pos_depth, cuffy_height/2])
    cylinder(r1=support_d/2, r2=support_d/2, h=cuffy_height, center=true);
}

difference() {
    union() {
        cuffy();
        support(support1_position_width, support1_position_depth);
        support(support2_position_width, support2_position_depth);
        support(support3_position_width, support3_position_depth);
        support(support4_position_width, support4_position_depth);
    };
    translate([0, 0, cuffy_thick])
    base();
    translate([width - small_d/2, 0, 2*body_height/3])
    big_joint();
};