fin_size = [3, 1.5, 2];
stick_size = [4.7, 4.7, 90];

fin_pos = [
    (fin_size.x + stick_size.x)/2,
    (stick_size.y - fin_size.y)/2,
    0
    ];

linear_extrude(height=stick_size.z)
square([stick_size.x, stick_size.y], center=true);

translate(fin_pos)
linear_extrude(height=fin_size.z)
square([fin_size.x, fin_size.y], center=true);