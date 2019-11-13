$fn = 25;

fin_size = [3, 1.5, 30];
stick_size = [7, 7, 73];

mag_size = [5.1, 2.6];
mag_pos = [0, -(stick_size.y/2 - mag_size.y), -0.1];

fin_pos = [
    (fin_size.x + stick_size.x)/2,
    (stick_size.y - fin_size.y)/2,
    0
    ];

cut_size = [1.5, stick_size.z + 0.2];
cut_pos = [0, 0, -0.1];

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

module cut() {
     linear_extrude(height=cut_size.y)
          circle(cut_size.x, center=true);
};

difference() {
     body();

     translate(mag_pos)
          mag();

     translate(cut_pos)
          cut();
};

translate(fin_pos)
fin();
