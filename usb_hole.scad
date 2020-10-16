$fn = 50;

size = [23.5, 21.5];
distance = 7.85;
thickness = 20;
hole_d = 3;

linear_extrude(height=9)
difference() {
    square(
        [
            size.x + distance*2 + thickness,
            size.y + distance*2 + thickness
        ],
        center=true
    );
    square(
        [
            size.x + distance*2,
            size.y + distance*2
        ],
        center=true
    );
    for( i = [
        [1, 1],
        [1, -1],
        [-1, 1],
        [-1, -1],
    ]
    ) {
        translate(
            [
                i.x * ((size.x + distance*2 + thickness) / 2 - 5),
                i.y * ((size.y + distance*2 + thickness) / 2 - 5)
            ]
        )
        circle(d=hole_d);
    };
}

linear_extrude(height=0.5)
square(
    [
        size.x + distance*2 + 2*thickness,
        size.y + distance*2 + 2*thickness
    ],
    center=true
);
