module quill(height, d_out1, d_in1, d_out2, d_in2) {
    difference() {
        cylinder($fn=90, h=height, r1=d_out1/2, r2=d_out2/2);
        translate([0, 0, -1]) {
            cylinder($fn=90, h=height+2, r1=d_in1/2, r2=d_in2/2);
        };
    };
};

module mount(height, d_out1, d_in1, d_out2, d_in2) {
    difference() {
        union() {
            quill(height/2, d_out1-1, d_in1-3, d_out2, d_in2);
            translate([0, 0, height/2]) {
                quill(height/2, d_out1, d_in1, d_out2, d_in2);  
            };
            translate([d_out2/2 + 3.5, 0, height*2/3]) {
                cube(size=[10, 9, 13], center=true);
            };
        };
        translate([d_out2/2 + 4.5, 0, height*2/3]) {
            cube(size=[22, 3, 30], center=true);
            rotate([90, 0, 0]) {
                cylinder(h=10, r1=2, r2=2, center=true);
            };
        };
    };
};

rotate([0, -90, 0]) {
    union() {
        translate([0, 0, 41]) {
            mount(26, 23.3, 20.3, 23.3, 20.3);
        };
        translate([0, 0, 24]) {
            quill(17, 17, 13, 22.3, 13);
        };
        translate([0, 0, 4]) {
            quill(22, 14, 4.5, 17, 4.5);
        };
        quill(4, 8, 4.5, 8, 4.5);
    };
};