cylinder_thick = 2;
cylinder_d = 5.5;
distance_between_cylinders = 1.4;

bolt_middle_length = 5.5;
bolt_d = 4;

bolt_length = 
    cylinder_thick*2
    + distance_between_cylinders
    + bolt_middle_length;

circle_in_d = 4;
circle_out_d = 8.5;

circle_thick = 2.3;

cylinder1_pos = [
    0,
    0,
    0
];

cylinder2_pos = [
    0,
    0,
    cylinder_thick + distance_between_cylinders
];

circle_diff_pos_z = circle_out_d/2
    - sqrt(
        pow(circle_out_d/2, 2)
        -pow(bolt_d/2, 2)
    );

circle_pos = [
    0,
    0,
    bolt_length - circle_diff_pos_z
];

stop_pos = [
    0,
    0,
    bolt_length - circle_diff_pos_z
];
module bolt() {
    $fn = 25;
    linear_extrude(height=bolt_length)
    circle(bolt_d/2);
};

module cylinder_() {
    $fn = 25;
    linear_extrude(height=cylinder_thick)
    circle(cylinder_d/2);
};

module circle_() {
    $fn = 50;
    rotate([
        0,
        90,
        0
    ])
    translate([
        -circle_out_d/2,
        0,
        -circle_thick/2
    ])
    linear_extrude(height=circle_thick)
    difference() {
        circle(circle_out_d/2);
        circle(circle_in_d/2);
    };
};

module stop() {
    $fn = 50;
    rotate([
        00,
        90,
        0
    ])
    translate([
        -circle_out_d/2,
        0,
        -circle_thick/2
    ])
    linear_extrude(height=circle_thick)
    rotate([
        0,
        0,
        45
    ]
    )
    intersection() {
        difference() {
            circle(circle_out_d/2+1);
            circle(circle_in_d/2);
        };
        square(circle_out_d/2+1);
    };
}

bolt();

translate(cylinder1_pos)
cylinder_();

translate(cylinder2_pos)
cylinder_();

translate(circle_pos)
circle_();

translate(stop_pos)
stop();
