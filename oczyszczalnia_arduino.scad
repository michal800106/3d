thickness_wall = 3;

arduino_size = [54, 68.5, 2];
relay_size = [52, 40, 2];
rtc_size = [23.4, 84, 2];

case_size_internal = [51.6, 2 * relay_size.y + 10, 80];
extra_body_relay_size = [
    2,
    case_size_internal.y+2,
    2*relay_size.z
];

extra_body_rtc_size = [
    arduino_size.x - rtc_size.x,
    rtc_size.y+8,
    2*rtc_size.z
];

cones_positions = [
    [
       case_size_internal.x/2-1.5,
       -case_size_internal.y/2-9,
       case_size_internal.z+2
    ],
    [
       -case_size_internal.x/2+1.5,
       -case_size_internal.y/2-9,
       case_size_internal.z+2
    ],
    [
       case_size_internal.x/2-1.5,
       -case_size_internal.y/2-9,
       4
    ],
    [
       -case_size_internal.x/2+1.5,
       -case_size_internal.y/2-9,
       4
    ]
];

cones_rotations = [
    [-90+15, 0, -15],
    [-90+15, 0, 15],
    [-90-15, 0, -15],
    [-90-15, 0, 15]
];

module body(size) {
    translate([0, 0, -size.z/2])
    linear_extrude(size.z)
    square([size.x, size.y], center = true);
}

module case(size, thickness) {
    difference() {
        body(
            [
                size.x + 2*thickness,
                size.y + thickness,
                size.z + 2*thickness
            ]
        );
        translate([0, -thickness/2, 0])
        body(size);
    }
}

module cones() {
    translate(
        [
            0,
            7,
            -(
                case_size_internal.z + 2 *thickness_wall
            )/2
        ]
    )
    for(i=[0:3]) {
        position=cones_positions[i];
        rotation=cones_rotations[i];
        translate(position)
        rotate(rotation)
        cylinder(h=8, d1=7, d2=0);
    }
}

module holes() {
    for(z = [-15, -5, 12, 24, 45, 55]) {
    for(y = [0:7:case_size_internal.y-10]) {
        translate([0, -45+y, 20+z])
        rotate([0, 90, 0])
        cylinder(
            h=2*case_size_internal.x,
            d1=3,
            d2=3,
            center=true
        );
    }
}
}

module front() {
    translate(
        [
            0,
            -(
                case_size_internal.y + 2 *thickness_wall
            )/2-7.7,
            0
        ]
    )
    linear_extrude(
        case_size_internal.z + 2 *thickness_wall
    )
    square(
        [
            case_size_internal.x + 2 *thickness_wall,
            2 *thickness_wall
        ],
        center=true
    );
}

difference() {
    translate(
        [
            0,
            -7,
            (
                case_size_internal.z + 2 *thickness_wall
            )/2
        ]
    )
    union() {
        cones();
        case(case_size_internal, thickness_wall);
        translate(
           [
             -(
                case_size_internal.x -
                extra_body_relay_size.x
              )/2,
              0,
              (
                -case_size_internal.z -
                2 *thickness_wall +
                2 * 38
              )/2
           ]
        )
        body(extra_body_relay_size);
        translate(
           [
             -(
                case_size_internal.x -
                extra_body_rtc_size.x
              )/2,
              0,
              (
                -case_size_internal.z -
                2 *thickness_wall +
                2 * 70
              )/2
           ]
        )
        body(extra_body_rtc_size);
    }
    color("black")
    translate([0, -20.5, 9.5])
    body(arduino_size);
    
    #color("pink")
    translate([1, -31, 38])
    body(
        [
            relay_size.x,
            relay_size.y + 5,
            relay_size.z
        ]
    );
    
    #color("blue")
    translate([1, 14, 38])
    body(
        [
            relay_size.x,
            relay_size.y + 5,
            relay_size.z
        ]
    );


    color("orange")
    translate(
        [
            (
                case_size_internal.x -
                rtc_size.x
             )/2+1,
             -12.5,
             70
        ]
    )
    body(rtc_size);
    holes();
    front();
}
