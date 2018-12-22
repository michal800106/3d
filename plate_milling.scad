module quill(height, d_out, d_in) {
    difference() {
        cylinder($fn=90, h=height, r1=d_out/2, r2=d_out/2);
        translate([0, 0, -1]) {
            cylinder($fn=90, h=height+2, r1=d_in/2, r2=d_in/2);
        };
    };
};

quill(2.5, 32, 7);