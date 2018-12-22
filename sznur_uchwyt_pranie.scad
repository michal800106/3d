$fn = 50;

d = 7.9;
height = 28;

hole_d = 2.7;

big_hole_d = 4;
big_hole_height = 14;

cap_external_d = 16;
cap_internal_d = 12;
cap_external_height = 14;
cap_internal_height = 10;

difference() {
    diff = cap_external_height - cap_internal_height;

    union() {
        translate([0,0,diff])
        cylinder(r1=d/2, r2=d/2, h=height-diff);
        cap();
    }
    cylinder(r1=hole_d/2, r2=hole_d/2, h=height);
    translate([0, 0, height-big_hole_height])
    cylinder(r1=big_hole_d/2, r2=big_hole_d/2, h=big_hole_height);
};


module cap() {
    diff = cap_external_height - cap_internal_height;
    difference() {
        union() {
            cylinder(r1=hole_d/2, r2=cap_external_d/2, h=diff);
            translate([0,0,diff])
            cylinder(r1=cap_external_d/2, r2=cap_external_d/2, h=cap_internal_height);
        };
        translate([0, 0, diff])
        cylinder(r1=cap_internal_d/2, r2=cap_internal_d/2, h=cap_internal_height);
    };
};