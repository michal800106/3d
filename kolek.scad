$fn = 50;

d_out = 5;
height = 20;

top_height = 1;
top_d = 7.5;

cut_width = 2* d_out;
cut_height = height;
cut_depth = 0.3;

cut_pos = 3.5;

tip_d = 3;
tip_height = 1;

rings_begin = 4;
number_rings = 8;
interval_rings = 2;

height_ring = 0.6;
depth_ring = 0.6;

hole_d = 2.8;
hole_height = 10;

taper_d = 6.3 / sqrt(2);
taper_height = 5;
taper_taper = 0.3;

echo( sqrt(taper_d * taper_d * 2) );

difference() {
    union() {
        cylinder(r1=d_out/2, r2=d_out/2, h=height);
        *cylinder(r1=top_d/2, r2=top_d/2, h=top_height);
        translate([0, 0, height])
        cylinder(r1=d_out/2, r2=tip_d/2, h=tip_height);
        translate([0, 0, rings_begin])
        rings();
        translate([-taper_d/2, -taper_d/2, 0])
        tapered_cuboid(taper_d, taper_d, taper_height, taper_taper);
    };
    translate([0, 0, cut_pos + height/2])
    cube([cut_width, cut_depth, cut_height], center=true);
    cylinder(r1=hole_d/2, r2=hole_d/2, h=hole_height);
    translate([0, 0, hole_height])
    cylinder(r1=hole_d/2, r2=0, h=height-hole_height+tip_height);
};


module rings() {
    for(i = [0 : number_rings-1]) {
        translate([0, 0, i*interval_rings])
        ring();
    };
};


module ring() {
    translate([0, 0, height_ring])
    rotate_extrude(angle = 360)
    translate([d_out/2, 0, 0])
    polygon(points=[[0, 0], [depth_ring, 0], [0, height_ring]]);
};

module tapered_cuboid(w, l, h, taper) {
	ho = taper;
	hw = w - taper;
	hl = l - taper;
	polyhedron( points=[
		[ 0,  0, 0],
		[ho, ho, h],
		[hw, ho, h],
		[ w,  0, 0],
		[ 0,  l, 0],
		[ho, hl, h],
		[hw, hl, h],
		[ w,  l, 0] 
	], faces = [
		//side face
		[0, 1, 2],
		[2, 3, 0],
		//side face
		[3, 2, 6],
		[6, 7, 3],
		//side face
		[7, 6, 5],
		[5, 4, 7],
		//side face
		[4, 5, 1],
		[1, 0, 4],
		//top face
		[1, 5, 2],
		[2, 5, 6],
		//bottom face
		[4, 0, 3],
		[7, 4, 3],
	] );
};


