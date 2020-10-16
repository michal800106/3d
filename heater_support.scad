$fn = 50;

bottom_mount_holes = [[-7, 0, -8], [7, 0, -8]];

// pnp
//pletwa_length = 30; 
//mount_holes = [[6, 45, 0], [6, 105, 0]]; 
//line_length = 125;

// pnp vertical
mount_holes = [[-6, 8.5, 0], [-6, 8.5 + 80, 0], [6, 8.5, 0], [6, 8.5 + 80, 0]]; 
pletwa_length = 115;
line_length = 115;

//heater
//mount_holes = [[-6, 8.5, 0], [-6, 8.5 + 104, 0], [6, 8.5, 0], [6, 8.5 + 104, 0]]; 
//pletwa_length = 120;
//line_length = 120;



module pletwa(h1, h2, t, l) {
    translate([0, 0, -2])
    linear_extrude(height=t)
    polygon([[0, 0], [0, l], [h2, l], [h1, 0]]);
}

module bottom_mount() {
    rotate([90, 0, 0])
    translate([0, (-23 + 4)/2, -4])
    linear_extrude(height=4)  
    square([23, 23], center=true);
}

module body() {
    pletwa(h1=10, h2=10, t=4, l=line_length);
    rotate([0, 90, 0])
    pletwa(h1=15, h2=5, t=3, l=pletwa_length);
    rotate([0, 180, 0])
    pletwa(h1=10, h2=10, t=4, l=line_length);
    bottom_mount();
}

rotate([0, 180, 0])
difference() {
    body();
    
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