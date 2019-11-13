
thickness = 4;

iphone_size = [
    127.4,
    11.7
];

base_size = [
    iphone_size.x + 2*thickness,
    iphone_size.y + 2*thickness,
    18
];

back_size = [
    base_size.x,
    thickness,
    14
];

back_pos = [
    0,
    base_size.y-thickness,
    26-back_size.z-2*thickness
];

cut1_size = [
    iphone_size.x,
    iphone_size.y,
    base_size.z
];

cut1_pos = [
    thickness,
    thickness,
    thickness
];

cut2_size = [
    110,
    2*thickness,
    base_size.z
];

cut2_pos = [
    (base_size.x-cut2_size.x)/2,
    -thickness/2,
    9
];

holder_stick_size = [
    10,
    26,
    thickness
];

holder_end_size = [
    holder_stick_size.x,
    thickness,
    6.3
];

holder1_pos = [
    base_size.x/2-11-10,
    base_size.y,
    0
];

holder2_pos = [
    base_size.x/2+11,
    base_size.y,
    0
];

diff_corner1_pos = [
    (base_size.x-cut2_size.x)/2-thickness,
    thickness,
    base_size.z-thickness
];

diff_corner1_rot = [
    90,
    0,
    0
];

diff_corner2_pos = [
    (base_size.x+cut2_size.x)/2+thickness,
    thickness,
    base_size.z-thickness
];

diff_corner2_rot = [
    90,
    -90,
    0
];

corner1_pos = [
    (base_size.x-cut2_size.x)/2+thickness,
    thickness,
    cut2_pos.z+thickness
];

corner1_rot = [
    90,
    180,
    0
];

corner2_pos = [
    (base_size.x+cut2_size.x)/2-thickness,
    thickness,
    cut2_pos.z+thickness
];

corner2_rot = [
    90,
    90,
    0
];

corner3_pos = [
    base_size.x-thickness,
    base_size.y-2*thickness,
    base_size.z+thickness
];

corner3_rot = [
    90,
    90,
    90
];

corner4_pos = [
    0,
    base_size.y-2*thickness,
    base_size.z+thickness
];

corner4_rot = [
    90,
    90,
    90
];

module corner(a) {
    difference() {
        $fn = 50;
        square(a);
        intersection() {
            circle(a);
            square(a);
        };
    };
};

module holder() {
    box(holder_stick_size);
    translate(
        [
            0,
            holder_stick_size.y,
            0
        ]
    )
    box(holder_end_size);
};

module box(size) {
    linear_extrude(height=size.z)
    square([size.x, size.y]);
};

module back() {
    rotate([90, 0, 0])
    translate([
        thickness,
        thickness,
        -thickness
    ])
    linear_extrude(height=back_size.y)
    minkowski() {
        circle(thickness);
        square(
            [
                back_size.x-2*thickness,
                back_size.z
            ]
        );
    }
};

module base() {
    linear_extrude(height=base_size.z)
    translate([
        0,
        thickness
    ]) {
        square(
            [
                base_size.x,
                base_size.y-thickness,
            ]
        );
        
        translate([
            thickness,
            0
        ])
        minkowski() {
            circle(thickness);
            square(
                [
                    base_size.x-2*thickness,
                    base_size.y-2*thickness,
                ]
            );
        };
    }
}

difference() {
    union() {
        base();
        translate(
            back_pos
        )
        back();
    };
    
    translate(cut1_pos)
    box(cut1_size);
    
    translate(cut2_pos)
    box(cut2_size);
    
    translate(diff_corner1_pos)
    rotate(diff_corner1_rot)
    linear_extrude(thickness)
    corner(thickness);
    
    translate(diff_corner2_pos)
    rotate(diff_corner2_rot)
    linear_extrude(thickness)
    corner(thickness);
        
}

translate(holder1_pos)
holder();

translate(holder2_pos)
holder();

translate(corner1_pos)
rotate(corner1_rot)
linear_extrude(thickness)
corner(thickness);

translate(corner2_pos)
rotate(corner2_rot)
linear_extrude(thickness)
corner(thickness);

translate(corner3_pos)
rotate(corner3_rot)
linear_extrude(thickness)
corner(thickness);

translate(corner4_pos)
rotate(corner4_rot)
linear_extrude(thickness)
corner(thickness);
