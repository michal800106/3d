thickness = 1.5;
size_b = [30, 10, 16];
size = [35, size_b.y-2*thickness, 18];


cube(size, center=true);
translate([0,0, (size_b.z-size.z)/2-thickness])
cube(size_b, center=true);