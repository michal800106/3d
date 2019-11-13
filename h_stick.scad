stick_size = [
    7,
    7,
    51
];

fin_spring_size = [
    stick_size.x + 6,
    2,
    5
];

fin_cut_size = [
    stick_size.x + 1,
    2.1,
    10.1
];

fin_cut_pos = [
    0,
    0,
    stick_size.z - fin_cut_size.z + 0.1 
];

fin_mount_hole_size = [
    2,
    stick_size.y + 0.1
];

fin_mount_rotate = [
    90,
    0,
    0
];

fin_mount_pos = [
    0,
    0,
    stick_size.z - fin_cut_size.z/2
];

nut_hole_size = [
    6,
    3.1
];

nut_hole_rotate = [
    90,
    90,
    90
];

nut_hole_pos = [
    (stick_size.y - nut_hole_size.y + 0.1)/2 + 0.1,
    0,
    stick_size.z - fin_cut_size.z - 5.5
];

magnes_hole_size = [
    5,
    5.1
];

magnes_hole_rotate = [
    90,
    90,
    90
];

magnes_hole_pos = [
    (stick_size.y - magnes_hole_size.y + 0.1)/2 + 0.1,
    0,
    19
];

mount_hole_size = [
    5,
    1.6
];

mount_hole_rotate = [
    90,
    0,
    0
];

mount_hole_pos = [
    0,
    (stick_size.y - mount_hole_size.y + 0.1)/2 + 0.1,
    fin_mount_pos.z
];

module block(size) {
    linear_extrude(height=size.z)
    square([size.x, size.y], center=true);
};

module clinch(size) {
    $fn = 25;
    translate(
        [
            0,
            0,
            -size.y/2
        ]
    )
    linear_extrude(height=size.y)
    circle(size.x/2, center=true);
};

module stick() {
    block(stick_size);
    block(fin_spring_size);
};

module hexagon(size) {
    x = size.x/sqrt(3);
    translate(
        [
            0,
            0,
            -size.y/2
        ]
    )
    linear_extrude(height=size.y)
    polygon(
        [
            [-x, 0],
            [-x/2, x*sqrt(3)/2],
            [x/2, x*sqrt(3)/2],
            [x, 0],
            [x/2, -x*sqrt(3)/2],
            [-x/2, -x*sqrt(3)/2]
        ]
    );
};

difference() {
    stick();
    translate(fin_cut_pos)
    block(fin_cut_size);
    
    translate(fin_mount_pos)
    rotate(fin_mount_rotate)
    clinch(fin_mount_hole_size);
    
    translate(nut_hole_pos)
    rotate(nut_hole_rotate)
    hexagon(nut_hole_size);
    
    translate(magnes_hole_pos)
    rotate(magnes_hole_rotate)
    clinch(magnes_hole_size);
    
    translate(mount_hole_pos)
    rotate(mount_hole_rotate)
    clinch(mount_hole_size);
};



