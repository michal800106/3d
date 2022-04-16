$fn = 45;
d_stick = 10.5;
d_wheel = 17;

length_stick = 45;
length_wheel = length_stick-4;

coral_d = 4.2;
coral_width = 15;
coral_pos = 1.5;

d_pipe_int = 15.8;
d_pipe_ext = 18.3;
length_pipe = 20;

module stick() {
    cylinder(h=length_stick, d=d_stick);
}

module wheel() {
    difference() {
        cylinder(h=length_wheel, d=d_wheel);
        stick();
    }
}

module pipe() {
    difference() {
        cylinder(d=d_pipe_ext, h=length_pipe);
        cylinder(d=d_pipe_int, h=length_pipe);
    }
}

module pipe_join() {
    difference() {
        cylinder(d1=d_wheel, d2=d_pipe_ext, h=3);
        stick();
    }
}

module coral_cut() {
    translate([0, 0, coral_d/2])
    rotate_extrude(angle=360)
    translate(
        [
        (d_wheel+1)/2,
        0
        ]
    )
    minkowski() {
        square([10, coral_width - coral_d]);
        circle(d=coral_d);
    }
}

difference() {
    union() {
        wheel();
        translate([0, 0, length_wheel-length_pipe-3])
        pipe_join();
    };
    translate([0, 0, coral_pos])
    coral_cut();
    translate([0, 0, length_wheel-length_pipe])
    pipe();
}
