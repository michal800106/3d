use <MCAD/2Dshapes.scad>
use <list-comprehension/sweep.scad>
use <scad-utils/shapes.scad>
use <scad-utils/transformations.scad>

length_body = 36;
big_width_body = 20;
small_width_body = 15;
change_width_body = 18;

body_height = 4;

donut_height = 10;
donut_r1 = 31.5;
donut_r2 = 34.5;

donut_b1 = 180-acos(31.5/32.5);
donut_b2 = 180+acos(31.5/32.5);

donut_lean = 2;

pathstep = 0.3;

cut_height = 2;
cut_r = 11.5/2;
cut_length = 16;

small_r = 7/2;

translate_small_cut = 9;

small_square_a = 3;
small_square_b = 2;

big_square_a = 10;
big_square_b = 4.5;

big_cut_a = 10;
big_cut_b = cut_r * 2;

$fn = 25;


module cut() {
    linear_extrude(height=cut_height)
    hull() {
        circle(r=cut_r);
        translate([cut_length - cut_r, 0, 0])
        circle(r=cut_r);
    };
};

difference() {
    union() {
        difference() {
            linear_extrude(height=body_height)
            polygon(
                [
                    [-length_body/2, small_width_body/2],
                    [length_body/2-change_width_body, big_width_body/2],
                    [length_body/2, big_width_body/2],
                    [length_body/2, -big_width_body/2],
                    [length_body/2-change_width_body, -big_width_body/2],
                    [-length_body/2, -small_width_body/2]
                ]
            );
                    
            translate(
                [
                    15,
                    0,
                    -0.01
                ]
            )
            linear_extrude(height=body_height+0.02)
            square([big_cut_a, big_cut_b], center=true);
        };
        
        translate([14, 4.5, cut_height])
        rotate([0, 0, 40])
        linear_extrude(height=body_height-cut_height)
        square([10, 2], center=true);

        translate([14, -4.5, cut_height])
        rotate([0, 0, -40])
        linear_extrude(height=body_height-cut_height)
        square([10, 2], center=true);
    };
    translate(
        [
            (length_body/2) - cut_length + cut_r,
            0,
            -0.01
        ]
    )
    cut();
    translate(
        [
            translate_small_cut,
            0,
            -0.01
        ]
    )
    linear_extrude(height=body_height+0.02)
    {
        circle(r=small_r);
    };
    
    translate(
        [
            4.5,
            0,
            -0.01
        ]
    )
    linear_extrude(height=body_height+0.02)
    square([small_square_a, small_square_b], center=true);
    
    translate(
        [
            16.5,
            0,
            -0.01
        ]
    )
    linear_extrude(height=body_height+0.02)
    square([big_square_a, big_square_b], center=true);
};

path_transforms1 = [
    for (i=[0:pathstep:donut_height])
        let(t=(i/donut_height)*donut_lean)
            translation([donut_r2-(length_body/2)+t-1.5, 0, i])
    ];


function circlemz(r1, r2, b1, b2) = 
    let (step=(b2-b1)/$fn) 
    concat(
    [
        for (a=[b1:step:b2+1])
           r1 * [cos(a), sin(a)]
    ],
    [
        for (a=[b2:-step:b1-1])
           r2 * [cos(a), sin(a)]
    ]
);

shape = circlemz(
            donut_r1,
            donut_r2,
            donut_b1,
            donut_b2
        );


sweep(
        shape,
        path_transforms1
);
    