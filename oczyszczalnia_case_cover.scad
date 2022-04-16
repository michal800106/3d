$fn = 10;

thickness_wall = 3;

case_size_internal = [51.6, 80];

distance_hole = 2.7;
hole_d = 3;

size_usb = [
    12,
    11
];

size_power = [
    9.2,
    11.4
];

pos_usb = [
    34,
    10
];

pos_power = [
    5.5,
    10
];

case_size = [
    case_size_internal.x + 2*thickness_wall,
    case_size_internal.y + 2*thickness_wall
];

holes_positions = [
    [distance_hole, distance_hole],
    [distance_hole, case_size.y - distance_hole],
    [case_size.x - distance_hole, distance_hole],
    [case_size.x - distance_hole, case_size.y - distance_hole]
];

linear_extrude(height=thickness_wall)
difference() {
    square(case_size);

    translate(pos_usb)
    square(size_usb);
    
    translate(pos_power)
    square(size_power);
    
    for (hole_pos = holes_positions) {
        translate(hole_pos)
        circle(d=hole_d);
    }
}