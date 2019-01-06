$fn = 25;

fin_size = [3, 1.5, 2];
stick_size = [6.4, 6.4, 90];

mag_size = [5, 2.5];
mag_pos = [0, 0, 0];

fin_pos = [
    (fin_size.x + stick_size.x)/2,
    (stick_size.y - fin_size.y)/2,
    0
    ];

module body() {
     linear_extrude(height=stick_size.z)
          square([stick_size.x, stick_size.y], center=true);

     
};

module fin() {
     linear_extrude(height=fin_size.z)
          square([fin_size.x, fin_size.y], center=true);
};

module mag() {
     linear_extrude(height=mag_size.x)
          circle(mag_size.y, center=true);
};

difference() {
     body();

     translate(mag_pos)
          mag();
};

translate(fin_pos)
fin();
