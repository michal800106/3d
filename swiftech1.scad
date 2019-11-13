$fn = 50;

inside_size = [52, 52, 3.5];
inside_small_size = [45, 45, 9];

holes_positions = [
    [
        44.5/2,
        44.5/2
    ],
    [
        44.5/2,
        -44.5/2
    ],
    [
        -44./2,
        44.5/2
    ],
    [
        -44.5/2,
        -44.5/2
    ]
];


central_size = [60, 60, 9];

mount_holes_angle = atan(80/80);

minimal_thickness = 2.5;

mount_spring_d = 9.5;
mount_d = 15;
mount_small_d = 5.5;
mount_below = 4;
mount_length = sqrt(pow(80/2, 2) + pow(80/2, 2));
mount_height = 2;

nut_head_d = 6;
nut_thread_d = 3.5;

module box(size) {
    linear_extrude(height=size.z)
    square([size.x, size.y], center=true);
}; 

module cyl(r, h) {
    linear_extrude(height=h)
    circle(r=r);
};

module nut_head_holes() {
    height=central_size.z - inside_size.z - minimal_thickness;
    
    for (pos = holes_positions) {
        translate([pos.x, pos.y, inside_size.z + minimal_thickness])
        cyl(nut_head_d/2, height);
    }
};

module nut_thread_holes() {
    height=central_size.z;
    
    for (pos = holes_positions) {
        translate([pos.x, pos.y])
        cyl(nut_thread_d/2, height);
    }
};

module mount() {
    translate([0, 0, -mount_below+2.5])
    linear_extrude(height=mount_height+mount_below-1)
    difference() {
        hull() {
            circle(mount_d/2);
            translate([0, mount_length])
            circle(mount_d/2);
        };
        translate([0, mount_length])
        circle(mount_spring_d/2);
    };
    translate([0, mount_length, -mount_height])
    difference() {
        linear_extrude(height=mount_height+2)
        circle(mount_d/2);
        translate([0,0, minimal_thickness])
        linear_extrude(height=mount_height-minimal_thickness+2)
        circle(mount_spring_d/2);
        linear_extrude(height=mount_height+2)
        circle(mount_small_d/2);
    }
};

module mount2() {
    linear_extrude(height=inside_size.z)
    hull() {
        circle(mount_d/2);
        translate([0, mount_length])
        circle(mount_d/2);
    };
};

module mounts2() {
    rotate([0, 0, mount_holes_angle])
    mount2();
    rotate([0, 0, -mount_holes_angle])
    mount2();

    rotate([0, 0, 180 + mount_holes_angle])
    mount2();
    rotate([0, 0, 180 - mount_holes_angle])
    mount2();
};

module mounts() {
    rotate([0, 0, mount_holes_angle])
    mount();
    rotate([0, 0, -mount_holes_angle])
    mount();

    rotate([0, 0, 180 + mount_holes_angle])
    mount();
    rotate([0, 0, 180 - mount_holes_angle])
    mount();
};

module body() {
    box(central_size);
    translate([
        0,
        0,
        central_size.z - inside_size.z
    ])
    mounts();
    difference() {
        translate([0, 0, central_size.z - 0.65])
        cyl(mount_length+10, 0.65);
        translate([
            0,
            0,
            central_size.z - inside_size.z
        ])
        mounts2();
    };
};

difference() {
    body();
    box(inside_small_size);
    box(inside_size);
    nut_head_holes();
    nut_thread_holes();
}