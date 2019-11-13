fin_size = [
    13,
    2,
    11.6
];

mount_hole_size = [
    2,
    7
];

mount_hole_rotate = [
    90,
    0,
    0
];

mount_hole_pos = [
    0,
    0,
    fin_size.z/2
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

difference() {
    block(fin_size);
    
    translate(mount_hole_pos)
    rotate(mount_hole_rotate)
    clinch(mount_hole_size);
};