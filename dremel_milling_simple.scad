include</home/michalz/projects/Thingiverse-Projects/Threaded Library/Thread_Library.scad>

nutDepth=9.5;    // Depth of the top nut
threadRad=9.0;   // Tweak this so the thread fits snugly on your dremel
nutRad=14;       // Outer radius of the nut / top of attachment

module quill(height, d_out1, d_in1, d_out2, d_in2) {
    difference() {
        cylinder($fn=90, h=height, r1=d_out1/2, r2=d_out2/2);
        translate([0, 0, -1]) {
            cylinder($fn=90, h=height+2, r1=d_in1/2, r2=d_in2/2);
        };
    };
};


rotate([90, 0, 0]) {
    union() {
            translate([0, 0, 8]) {
                quill(21, 18, 14, 23, 14);
            };
            translate([0, 0, 6]) {
                quill(2, 14, 4.5, 18, 4.5);
            };
            quill(6, 7, 4.5, 7, 4.5);
            translate([0, 0, 29]) {
                trapezoidNut(
                    length=nutDepth,
                    radius=nutRad, 
                    pitch=2.0,
                    pitchRadius=threadRad,
                    threadHeightToPitch=0.7,
                    stepsPerTurn=20,
                    countersunk=0.2
                );
            };
    };
};
