height = 15;
thickness = 3;

sphere_d = 8;
sphere_pos = [
    0,
    0,
    height - sphere_d/2
];

cut_size = [1.5, 5, 7];


size = [15, 15/2];

cut_cylinder1_size = [15, 7/2];
cut_cylinder1_pos = [
    0,
    0,
    thickness
];

cut_cylinder2_size = [15, 4/2];
cut_cylinder2_pos = [
    0,
    0,
    -thickness
];



$fn = 50;


module cylinder_(size_) {
    linear_extrude(height=size_.x)
    circle(size_.y);
};


module cut() {
    translate([
        0,
        (size.x-cut_size.y)/2,
        height-cut_size.z
    ])
    linear_extrude(height=cut_size.z)
    square([cut_size.x, cut_size.y] , center=true);
};


difference() {
    cylinder_(size);
    
    translate(cut_cylinder1_pos)
    cylinder_(cut_cylinder1_size);
    
    translate(cut_cylinder2_pos)
    cylinder_(cut_cylinder2_size);
    
    translate(sphere_pos)
    sphere(sphere_d/2);
    
    cut();
    rotate(
        [
            0,
            0,
            120
        ]
    )
    cut();
    rotate(
        [
            0,
            0,
            240
        ]
    )
    cut();
};
