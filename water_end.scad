d_in = 10;
d_out = 13.5;

cap1_d = 15.6;
cap1_height = 3;

cap2_d = 24;
cap2_height = 3;

height = 24;

$fn = 50;

rings_begin = 4;
number_rings = 3;
interval_rings = 7;

height_ring = 2;
depth_ring = 1.7;

rotate([180, 0, 0])
difference() {
    union() {
        cylinder(r1=d_out/2, r2=d_out/2, h=height);

        translate([0, 0, height])
        cylinder(r1=cap1_d/2, r2=cap1_d/2, h=cap1_height);
    
        translate([0, 0, height + cap1_height])
        cylinder(r1=cap2_d/2, r2=cap2_d/2, h=cap2_height);
    
        translate([0, 0, rings_begin])
        rings();
    };
    cylinder(r1=d_in/2, r2=d_in/2, h=height+cap1_height+cap2_height);
};

module rings() {
    for(i = [0, 1, number_rings-1]) {
        translate([0, 0, i*interval_rings])
        ring();
    };
};


module ring() {
    translate([0, 0, height_ring])
    rotate_extrude(angle = 360)
    translate([d_out/2, 0, 0])
    polygon(points=[[0, 0], [depth_ring, 0], [0, -height_ring]]);
};