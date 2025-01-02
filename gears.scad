use <MCAD/involute_gears.scad>

$fn = 50;
//gear (number_of_teeth=90, circular_pitch=270,
//	rim_thickness=11, gear_thickness=11, bore_diameter=4);


//#translate([00, 0, 0])
//gear (number_of_teeth=110, circular_pitch=100,
//	rim_thickness=11, gear_thickness=11, bore_diameter=9);
 


//linear_extrude(height=0.2)
//translate([40, 0])
//square([200, 150], center=true);
//
//  				gear (number_of_teeth=22,
//					circular_pitch=700,
//					bore_diameter=9,
//					hub_diameter=40,
//					rim_width=1,
//					hub_thickness=15,
//					rim_thickness=12,
//					gear_thickness=12,
//                    clearance=2,
//					pressure_angle=29);
                 
gear (number_of_teeth=10,
      circular_pitch=2.5,
      bore_diameter=3.4,
      hub_diameter=6,
      rim_width=2,
      hub_thickness=6,
      rim_thickness=6,
      gear_thickness=6,
      clearance=0,
      pressure_angle=29
      );