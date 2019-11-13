$fn = 100;

wall_thick = 0.5;

r_out_out = (64/2) + wall_thick;
r_out_in = r_out_out - wall_thick;

r_in_out = (61/2) - wall_thick;
r_in_in = r_in_out + wall_thick;

height = 5;

difference() {
    linear_extrude(height)
    {
        difference() {
            circle(r_out_out, center=true);
            circle(r_in_out, center=true);
        };
    };
    translate([0, 0, wall_thick])
    linear_extrude(height)
    {
        difference() {
            circle(r_out_in, center=true);
            circle(r_in_in, center=true);
        };
    };
}
