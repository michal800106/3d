body_size = [125, 10, 3];
body2_size = [10, 60+body_size.y/2, 3];
mount_size = [3, 23, 15];
mount2_size = [23, 3, 15];

mount_holes = [[-6, 8.5, 0], [-6, 8.5 + 104, 0], [6, 8.5, 0], [6, 8.5 + 104, 0]];
bottom_mount_holes = [[-7, 0, -8], [7, 0, -8]];

holes_positions = [
    [45-body_size.x/2, 0, 0],
    [103-body_size.x/2, 0, 0],
    [body_size.x/2 - 6, 0, 0],
];

module body(size) {
    linear_extrude(size.z)
    square([size.x, size.y], center=true);
}

difference() {
    union() {
        rotate([0, 0, 90])
        translate([0, -body_size.x/2, 0])
        mount_line();
        body(body_size);
        translate([98-body_size.x/2, (body2_size.y-body_size.y)/2, 0])
        body(body2_size);
        translate([(mount_size.x-body_size.x)/2, 0, body_size.z-mount_size.z])
        body(mount_size);
        #translate([98-body_size.x/2, (body2_size.y-body_size.y/2-mount2_size.y/2), body_size.z-mount_size.z])
        body(mount2_size);
    }
    for (pos = holes_positions) {
            translate(pos)
            linear_extrude(body_size.z)
            circle(d=3.5);
    }
}

module pletwa(h1, h2, t) {
    translate([0, 0, -2])
    linear_extrude(height=t)
    polygon([[0, 0], [0, 30], [h2, 30], [h1, 0]]);
}

module bottom_mount() {
    rotate([90, 0, 0])
    translate([0, (-23 + 4)/2, -4])
    linear_extrude(height=4)  
    square([23, 23], center=true);
}

module body_line() {
    pletwa(h1=10, h2=10, t=4);
    rotate([0, 90, 0])
    pletwa(h1=15, h2=5, t=3);
    rotate([0, 180, 0])
    pletwa(h1=10, h2=10, t=4);
    bottom_mount();
}

module mount_line() {
    difference() {
        body_line();
        
        for (pos = mount_holes) {
            translate(pos)
            translate([0, 0, -2])
            linear_extrude(4)
            circle(d=3.6);
        }
        
        for (pos = bottom_mount_holes) {
            translate(pos)
            translate([0, 0, -2])
            rotate([270, 0, 0])
            linear_extrude(4)
            circle(d=3.6);
        }
    }
}