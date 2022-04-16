$fn = 25;

module profile() {
    intersection() {
        difference() {
            translate([0, -47])
            square([46.8, 46.8]);
            rotate([0, 0, -90])
            import("/home/michalz/listwa.dxf");
        }
        
        union() {
            translate([0, -19])
            square([46.8, 19]);
            translate([0, -46.8])
            square([19, 46.8]);
            translate([18, -18])
            rotate([0, 0, -90])
            import("/home/michalz/listwa.dxf");
        }
    }
}


difference() {
    linear_extrude(height=26)
    profile();
    
    translate([38, -42, 12])
    rotate([0, 90, 90])
    screw_hole();
    
    translate([42, -38, 12])
    rotate([90, 0, 270])
    screw_hole();
    
    translate([30, -18, 0])
    linear_extrude(height=26)
    square([18, 18]);
    
    translate([0, -48, 0])
    linear_extrude(height=26)
    square([18, 18]);
}

module screw_hole() {
    translate([0, 0, 17])
    linear_extrude(height=24)
    circle(d=5);
    translate([0, 0, 15])
    hull() {
        translate([0, 0, 3])
        linear_extrude(1)   
        circle(d=5);
    
        linear_extrude(1)
        circle(d=10);
    };
    linear_extrude(15)
    circle(d=10);
}
