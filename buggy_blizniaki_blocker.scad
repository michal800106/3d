$fn = 50;

stick_height = 44;
stick_width = 18.4;
stick_depth = 50;

holder_height = 60;
holder_width = 30;
holder_depth = 30;

keeper_height = 30;
keeper_width = stick_width + 10;
keeper_depth = holder_depth;
keeper_position = holder_height - 20;

keeper_cut_height = 40;
keeper_cut_width = stick_width;
keeper_cut_depth = holder_depth;
keeper_cut_position = holder_height - 30;

screw_hole_d = 4.5;
screw_hole_position = keeper_position + keeper_height - 8;
screw_hole_width = 2 * holder_width;

keeper_distance = 3;

module stick() {
    rotate([0, 90, 0])
    translate([0, 0, -stick_depth/2])
    linear_extrude(height=stick_depth)
    resize([stick_height, stick_width])
    circle(1);
};

difference() {
    translate([0, 0, keeper_cut_position])
    linear_extrude(height=keeper_cut_height)
    square([keeper_cut_depth, keeper_cut_width - keeper_distance], center=true);

    translate([
                0,
                0,
                holder_height/2
            ])
    stick();
    
    translate([0, 0, screw_hole_position])
    rotate([90, 0, 0])
    cylinder(r1=screw_hole_d/2, r2=screw_hole_d/2, h=screw_hole_width, center=true);
};