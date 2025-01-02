use <gears_3.scad>;

$fn = 50;
//gear(52, circular_pitch=false, diametral_pitch=false,
//                pressure_angle=20, clearance = 0,
//                verbose=true);

translate([0, 0, -3-2.8])
linear_extrude(height=2.8)
circle(d=9);


translate([0, 0, -3])
linear_extrude(height=3)
circle(d=11);

spur_gear(0.600, 52, 5, 0, pressure_angle=18, helix_angle=0, optimized=false, correction=2.5);

translate([0, 0, 5])
linear_extrude(height=5)
circle(d=11);

translate([0, 0, (5+5)])
linear_extrude(height=6.2)
circle(d=8);

translate([0, 0, (5+5+6.2)])
spur_gear(0.88, 15, 7.5, 0, pressure_angle=20, helix_angle=0, optimized=false, correction=0);
