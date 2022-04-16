h = [12.5, 5.2, 3];

wood_d = 18.5;

mirror([0, 1, 0])
difference() {
    translate([-wood_d/2, wood_d/2-2, -35+3])
    linear_extrude(35)
    square([wood_d, wood_d], center=true);
    * spacer();
    #translate([1.5/2, 0, 0])
    linear_extrude(5)
    mirror([0, 1, 0])
    import("/home/michalz/drawing2.dxf");
}

module spacer() {
    color("red")
    translate([-h.x + h.y/2, -3.3, 0])
    linear_extrude(10)
    square([h.y, h.z], center=true);
}