$fn = 25;

wall_thickness = 2;

body_width = 11;
body_depth = 70;
body_height = 11;

big_cut_width = 11;
big_cut_depth = 7;
big_cut_height = wall_thickness;
big_cut_position_depth = 19;
big_cut_position_height = body_height - wall_thickness;

long_cut_width = 7;
long_cut_height = 7;
long_cut_depth = body_depth;

h_cut_size = [body_width+20, 7, 7];
h_cut_pos = [0, body_depth - 40, wall_thickness];

v_cut_size = [7, body_depth + 3, 7];
v_cut_pos = [0, 0, wall_thickness];

sensor_cut_size = [11.1, 7, wall_thickness + 0.1];
sensor_cut_pos = [0, body_depth - 64, body_height - wall_thickness];

suv_cut_size = [wall_thickness + 0.2, body_depth - 3, 1.7];
suv_cut_pos = [-(body_width - wall_thickness)/2, body_depth - 58.3, wall_thickness];

plate_pos = [0, body_depth - 49, 8];

holes = [
     [2, 15, [10, body_depth - 79.2, -5]],
     [2, 15, [10, body_depth - 65.4, -5]],
     [3, 15, [11.4, body_depth - 54.4, -5]],
];

mount_plate_size = [12, 40, wall_thickness];
mount_plate_pos = [10, body_depth - 64, -1];

cabel_plate_size = [body_width, 40, wall_thickness];
cabel_plate_pos = [0, plate_pos.y + cabel_plate_size.y/2, body_height - wall_thickness];

cabel_ring_size = [3.5, 5, 2, 10, 6];
cabel_ring_pos = [0, plate_pos.y + cabel_plate_size.y, body_height - wall_thickness/2 + cabel_ring_size[4]];

cabel_cut_size = 4.5;

module cut(cut_size) {
     linear_extrude(height=cut_size.z)
          square([cut_size.x, cut_size.y], center=true);
};

module body() {
     linear_extrude(height=body_height)
          square([body_width, body_depth], center=true);

     translate(mount_plate_pos)
          linear_extrude(height=mount_plate_size.z)
          square([mount_plate_size.x, mount_plate_size.y], center=true);

};


module cabel_ring() {
     rotate([90, 0, 0])
     translate([0, 0, -cabel_ring_size[3]/2])
     difference() {
          linear_extrude(height=cabel_ring_size[3])
               circle(cabel_ring_size[4], center=true);

          translate([0, 0, cabel_ring_size[3]/2])
               linear_extrude(height=cabel_ring_size[2])
               circle(cabel_ring_size.y, center=true);

          translate([0, 0, -0.1])
               linear_extrude(height=cabel_ring_size[3] + 0.2)
               circle(cabel_ring_size.x, center=true);

          translate([0, (cabel_ring_size.x + cabel_ring_size[4])/2, -2])
               linear_extrude(height=cabel_ring_size[3] + 3)
               square([cabel_cut_size, cabel_ring_size[4] - cabel_ring_size.x + 2], center=true);
     };

};

module cabel() {
     translate(cabel_plate_pos)
          linear_extrude(height=cabel_plate_size.z)
          square([cabel_plate_size.x, cabel_plate_size.y], center=true);

     translate(cabel_ring_pos)
     cabel_ring();
}

module holes() {
     for (hole = holes) {
          translate(hole.z)
               linear_extrude(height=hole.y)
               circle(hole.x, center=true);
     }
}

module corner(height) {
     linear_extrude(height=height)
          polygon([
                       [corner_cut_size, 0],
                       [0, corner_cut_size],
                       [0, 0]
                       ]);
}

module plate() {
     linear_extrude(height=3)
          difference() {
          hull() {
               translate([-8.3, 1, 0])
                    circle(r=3, center=true);

               translate([8.3, 1, 0])
                    circle(r=3, center=true);
          };
          translate([-8.3, 1, 0])
               circle(r=1.5, center=true);

          translate([8.3, 1, 0])
               circle(r=1.5, center=true);
     };
     linear_extrude(height=6)
          difference() {
          union() {
               translate([-8.3, 1, 0])
                    circle(r=3, center=true);
               translate([8.3, 1, 0])
                    circle(r=3, center=true);
          };

          translate([-8.3, 1, 0])
               circle(r=1.5, center=true);
          translate([8.3, 1, 0])
               circle(r=1.5, center=true);
     }
};

difference() {
     union() {
          body();
          translate(plate_pos)
               plate();
          cabel();
     };
     translate(h_cut_pos)
          cut(h_cut_size);
     translate(v_cut_pos)
          cut(v_cut_size);
     translate(sensor_cut_pos)
          cut(sensor_cut_size);
     translate(suv_cut_pos)
          cut(suv_cut_size);

     holes();
};

