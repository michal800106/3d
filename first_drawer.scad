body_d = 18;
body_h = 18;
body_w = 30;
body_t = 2;

cut_l = 15;

module body(size) {
    linear_extrude(height=size.z)
    square([size.x, size.y]);
}


difference() {
    %body([body_d, body_w, body_h]);
    translate([body_t, 0, body_t])
    body([body_d-2*body_t, cut_l, body_h-2*body_t]);
}


cylinder(h=body_t, r1=3, r2=5);