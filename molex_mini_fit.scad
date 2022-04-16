$fn = 25;

pin_d = 2;
pin_w = 2;
pin_h = 20;

pin_top_d=3;
pin_top_w=2;
pin_top_h=pin_h-10;


pin_top2_d=3.2;
pin_top2_w=3.2;
pin_top2_h=pin_h-14;

p_pos_h=7;

dis = 4.2;

pins = [
  [-1, .5, 0],
  [0, .5, 1],
  [1, .5, 1],
  [-1, -.5, 1],
  [0, -.5, 0],
  [1, -.5, 0]
];

module p() {
  translate(
    [
    0,
    0,
    2
    ]
  )  
  rotate(
    [
    0,
    90,
    0
    ]  
  )
  translate(
    [
    0,
    0,
    -1.5/2
    ]
  )
  linear_extrude(
    height=1.5
  )
  polygon(
    [
    [0, 0],
    [0, 0.5],
    [2, 0]
    ]
  );
}

module pin() {
  linear_extrude(height=pin_h)
  square([pin_d, pin_w], center=true);
 
  translate(
    [
      (pin_top_d-pin_d)/2,
      0,
      pin_h-pin_top_h
    ]
  )
  linear_extrude(height=pin_top_h)
  square([pin_top_d, pin_top_w], center=true);
    
  translate(
    [
      0,
      0,
      pin_h-pin_top2_h
    ]
  )
  linear_extrude(height=pin_top2_h)
  square([pin_top2_d, pin_top2_w], center=true);
    translate(
    [
    0,
    pin_d/2,
    p_pos_h
    ]
    )
    p();
    
    rotate(
    [
    0,
    0,
    180
    ]
    )
    translate(
    [
    0,
    pin_d/2,
    p_pos_h
    ]
    )
    p();
}

module pin_bottom_body_cut() {
    linear_extrude(height=9)
    polygon(
    [
    [-1.75, -1.75],
    [1.75, -1.75],
    [1.75, 1.75/2],
    [1.75/2, 1.75],
    [-1.75/2, 1.75],
    [-1.75, 1.75/2]
    ]
    );
}

module pin_bottom_body_rec() {
    linear_extrude(height=9)
    square(
    [3.5, 3.5], center=true
    );
}

module body() {
    translate(
    [
    0,
    0,
    9
    ]
    )
    linear_extrude(height=11)
    square([13, 10], center=true);
}


module clip() {
   translate(
    [
    0,
    0,
    9
    ]
    )
   rotate(
    [
    -90,
    0,
    0
    ]
    )
   translate(
    [
    0,
    0,
    -2.5
    ]
    )
   linear_extrude(height=5)
   union() {
       square([2, 15], center=true);
       translate(
        [
        0, 5
        ]
       )
       polygon(
       [
        [-1, 0],
        [1, 0],
        [1, 1],
        [2, 1],
        [0, 4],
        [-1, 3]
       ] 
       );
   }
   
   translate(
   [
   3,
   0,
   11.5
   ]
   )
   rotate(
   [
   0,
   90,
   90
   ]
   )
   both_flex();
}

module flex() {
   translate([
    0,
    0,
    -0.5
    ]) {
   rotate_extrude(angle=90)
   translate([2, 0])
   square([1, 1]);
   
   linear_extrude(height=1)
   translate([
   -5,
   2 
   ])
   square([5, 1]);
   }
}

module both_flex() {
   translate(
    [
    0,
    0,
    3
    ]
    )
   flex();
   translate(
    [
    0,
    0,
    -3
    ]
    )
   flex();
}


translate(
[
00,
-7,
3.5
]
)
rotate(
[
0,
0,
90
]
)
clip();


difference() {
    union() {
        body();
        for( pin = pins ) {
          translate(
          [
            dis*pin.x,
            dis*pin.y,
            0
          ]
          )
          if (pin.z==0) {
            pin_bottom_body_rec();
          } else {
            pin_bottom_body_cut();
          }
        }
    };

    for( pin = pins ) {
      translate(
      [
        dis*pin.x,
        dis*pin.y,
        0
      ]
      )
      rotate(
      [
      0,
      0,
      180*pin.y  
      ]  
      )
      pin();
    }
}