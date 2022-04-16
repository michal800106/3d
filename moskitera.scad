$fn = 45;
d_stick = 9.5;
d_cut_stick = 3;
d_wheel = 17;

length_stick = 45;
length_cut_stick = 10;

size_extern = [25, 38, 24];
size_intern = [18, 65, 20];

//alpha = 60.886266849;
alpha = -(180-153);
//alpha = 90;
beta = 0;
s=alpha-2*beta;

coral_d = 4.2;
coral_width = 15;
coral_pos = -3;

pos_hole = (size_intern.x+d_wheel-(size_extern.x-size_intern.x)/2-1.5)*cos(alpha/2);

module small_box() {
    linear_extrude(size_extern.z)
    square([size_extern.x, size_extern.y]);
    translate([
        size_extern.x-(size_extern.x-size_intern.x)/2,
        -0.1,
        +size_extern.z-42
    ])
    linear_extrude(42)
    square([size_extern.z-size_intern.z, size_extern.y+0.1]);
}

module small_cut_box() {
    linear_extrude(size_intern.z)
    square([size_intern.x, size_intern.y]);
}


module body() {
    translate(
        [
        -size_extern.x,
        0,
        0
        ]
    )
    small_box();
}

module cut_body() {
    translate(
        [
        -size_extern.x,
        0,
        0
        ]
    )
    translate(
        [
        (size_extern.x-size_intern.x)/2,
        -10,
        size_extern.z-size_intern.z
        ]
    )
    small_cut_box();
}

module cut_stick() {
    translate(
        [
        -pos_hole,
        0,
        length_stick-10
    ])
    cylinder(h=length_cut_stick, d=d_cut_stick);
}

module stick() {
    translate(
        [
        -pos_hole,
        0,
        0
        ]
    )
    union() {
        cylinder(h=length_stick, d=d_stick);
        cylinder(h=size_extern.z-size_intern.z, d=d_stick+6);
    }
    
}

module wheel() {
    translate(
        [
        -pos_hole,
        0,
        size_extern.z-size_intern.z
        ])
    difference() {
        cylinder(h=20, d=d_wheel+3);
        cylinder(h=length_stick, d=d_stick);
    }
}

module small_hole() {
    #rotate([90, 180, 90])
    hull() {
        translate([0, 22, 0])
        cylinder(h=8, d=7, center=true);
        translate([0, 16, 0])
        cylinder(h=8, d=7, center=true);
    }
}

module large_hole() {
    rotate([0, 90, 0])
    cylinder(h=8, d=6, center=true);
}


module arc() {
    difference() {
        union() {
            linear_extrude(height=size_extern.z)
            translate([size_intern.x-4, 0])
            square([4.5, ((size_extern.y/2)+0.45)*cos(alpha)]);
        
            #linear_extrude(height=size_extern.z)
            translate([0, size_intern.y/8])
            square([size_intern.x, 2.5]);
        }
        
        translate(
            [
            18-2+coral_width-coral_d/2,
            0,
            9+coral_pos
            ]
        )
        rotate(
        [
        0,
        0,
        90
        ]
        )
        coral_cut();
    }
}

module fill_arc() {
    let(
        ex_x=size_extern.x/cos(beta),
        in_x=size_intern.x/cos(beta)
    ) {
        rotate(
            [
            0,
            0,
            180-(s/2)
            ]
        )
        rotate_extrude(angle=s)
        square([ex_x, size_extern.z]);
    }
}

module half_body() {
    rotate(
    [
        0,
        0,
        -alpha/2
    ]
    )
    difference() {
        union() {
            difference() {
                union() {
                    body();
                    linear_extrude(height=size_extern.z)
                    polygon(
                    [
                    [0, 0],
                    [-size_extern.x, 0],
                    [-size_extern.x, -size_extern.x*tan(beta)]
                    ]);
                };
                translate([0, -15, 0])
                cut_body();
            }
        }
        translate([0, size_extern.y-12, size_extern.z-size_intern.z+7])
        small_hole();
    }
    
    rotate(
    [
        0,
        0,
        -alpha/2
    ]
    )
    translate(
            [
            -size_extern.x,
            0,
            0
            ]
        )
    translate([size_extern.x, size_extern.y, 0])
    rotate([0, 0, 180])
    scale([1,2,1])
    arc();
}



module arcf(radius, thick, angle){
	intersection(){
		union(){
			rights = floor(angle/90);
			remain = angle-rights*90;
			if(angle > 90){
				for(i = [0:rights-1]){
					rotate(i*90-(rights-1)*90/2){
						polygon([[0, 0], [radius+thick, (radius+thick)*tan(90/2)], [radius+thick, -(radius+thick)*tan(90/2)]]);
					}
				}
				rotate(-(rights)*90/2)
					polygon([[0, 0], [radius+thick, 0], [radius+thick, -(radius+thick)*tan(remain/2)]]);
				rotate((rights)*90/2)
					polygon([[0, 0], [radius+thick, (radius+thick)*tan(remain/2)], [radius+thick, 0]]);
			}else{
				polygon([[0, 0], [radius+thick, (radius+thick)*tan(angle/2)], [radius+thick, -(radius+thick)*tan(angle/2)]]);
			}
		}
		difference(){
			circle(radius+thick);
			circle(radius);
		}
	}
}



module coral_cut() {
    translate([0, 0, coral_d/2])
    
    minkowski() {
        linear_extrude(height=coral_width-coral_d)
        square([(size_extern.y/2)*cos(alpha), coral_width - coral_d]);
        sphere(d=coral_d);
    }
}

difference() {
    union() {
        half_body();
        mirror([0, 1, 0])
        half_body();
        *fill_arc();
        stick();
        // rotate([0, 0, 180])
        // linear_extrude_fs(height=10);
    };
    #wheel();
    cut_stick();
}
