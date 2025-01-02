use <gears_3.scad>;

$fn = 50;
//gear(52, circular_pitch=false, diametral_pitch=false,
//                pressure_angle=20, clearance = 0,
//                verbose=true);


union() {
    spur_gear(0.525, 24, 1.6, 2.1, pressure_angle=18, helix_angle=0, optimized=false, correction=0.2);

    translate([0, 0, 1.6])
    spur_gear(0.525, 12, 3, 2.1, pressure_angle=20, helix_angle=0, optimized=false, correction=0.2);
};
