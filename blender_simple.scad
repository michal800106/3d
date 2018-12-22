
height = 8;

out_d = 52;
internal_d = 24;

cut_length = 50;
cut_distance = cut_length/2 + 7;


linear_extrude(height=height)
difference() {
    circle(out_d/2, center=true);
    circle(internal_d/2, center=true);
    translate([cut_distance, 0])
    square(cut_length, center=true);
};