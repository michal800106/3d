/* [Main parameters] */
//height of fan measured from heating block bottom (or a bit lower if needed)to the fan insert hole lip
fan_height=24; //does not include insert portion height

//measured from fan inside left corner to nozzle tip
measured_nozzle_distance=32; 
//measured from fan inside left corner to nozzle tip
measured_fan_offset=-5.3;

//0: half torus , 1: full torus
fan_type=0; //[0:half,1:full]

//fan side snap tongue
fan_side_clip=1; //[0:No,1:Yes]
$fn=25;//shape resolution
/* [Advanced parameters]*/



//top insert width to match fan hole
fan_insert_width=16.8;
//top insert length to match fan hole
fan_insert_length=13.2;
//top insert height
fan_insert_height=9;

fan_rotate=-55;


//hight of fan torus and throat
fan_thickness=7;
//measured center radius
fan_diameter=50;
//rim width around top insert
fan_shoulder=1.3;
//thickness of internal skin
skin_thickness=1.6;
//thickness of top insert skin
top_skin_thickness=1.6;
//angle adjustment for air flow direction downwards
vent_cutout_offset=-6;
//size of vent holes
vent_hole_radius=1.3;

//manifold padding
pad=0.01;

/* [hidden] */
vent_angle=80;
vent_angle_start=-10; 
vent_angle_shift=-16;
fan_length=measured_nozzle_distance-fan_diameter/2+fan_insert_length+fan_shoulder;
fan_width=fan_insert_width+fan_shoulder*2;
fan_top_length=fan_insert_length+fan_shoulder*2;
fan_throat_length=fan_length-fan_top_length-fan_thickness/2;
r1=fan_thickness;
//r1=fan_height/2>fan_thickness?fan_thickness:fan_thickness/2;
//r1=fan_thickness/2;
r2=fan_top_length/2-skin_thickness;
fan_offset=-(measured_fan_offset+fan_insert_width/2);
tab_width=2;


//echo(fan_length,fan_top_length,fan_throat_length,fan_offset);

//main program loop

rotate([0,0,180]) union() {
    difference() {
        union() {
            difference() {
               main_shape();
               main_shape_cutout(); 
            }
            circular_fan_shape();
        }
        circular_fan_shape_cutout();
       
     }
     difference() {
        top_insert_shape();
         if(fan_side_clip) 
            tab_cutout();
     }
}

//modules section
 
 module main_shape() {
        union() {
            difference() {
            
            //middle upper section
                translate([0,0,0]) cube([fan_width,fan_top_length,fan_height],center=false);
                
            //rear slanted cutout
                hull() {
                    translate([-pad,-4.5,fan_height-6]) cube([fan_width+pad*2,3.8,4]);
                   translate([-pad,0,-4]) cube([fan_width+pad*2,5,4]);
                } 
            }
    
            difference() {
            //horizontal section
               translate([0,fan_top_length,0]) cube([fan_width,fan_throat_length+fan_diameter/2,fan_thickness],center=false);
                
            //horizontal section cut out
              translate([skin_thickness,fan_top_length,skin_thickness]) cube([fan_width-(skin_thickness*2),fan_throat_length+pad*2,fan_thickness-(skin_thickness*2)],center=false);
                
                  //front cutout to match round fan profile       
        translate([fan_offset+fan_width/2,fan_length+fan_diameter/2+fan_thickness/2,-fan_thickness/2])
   cylinder(r=fan_diameter/2,h=fan_thickness*2);   

            }
            //front fillet
           translate([fan_width/2,fan_top_length,fan_thickness]) rotate([0,-90,0]) fillet(r1/2,fan_width);
        
        }
        
}

module main_shape_cutout() {
    
    slope_distance=3;

      translate([skin_thickness,0,skin_thickness]){
                //main internal shape with rounded flow
           difference() {
              union() {
                        //slanted inside cut
                 hull() {
                      translate([0,fan_top_length/2,fan_height]) rotate([0,90,0]) cylinder(r=r2,h=fan_width-skin_thickness*2);
                           translate([0,slope_distance+fan_top_length/2,r2]) rotate([0,90,0]) cylinder(r=r2,h=fan_width-skin_thickness*2);
                        }
                        //horizonal lower cut
                       hull() {
                              translate([0,fan_top_length/2+r2/2,r2]) rotate([0,90,0]) cylinder(r=r2,h=fan_width-skin_thickness*2);
                              translate([0,fan_length*2,r2]) rotate([0,90,0]) cylinder(r=r2,h=fan_width-skin_thickness*2);
                        }
                    }
                  
                   translate([-.1,fan_top_length-skin_thickness,-skin_thickness*2]){
                        //vertical front cut
                        hull() {
                         translate([-.5,r1,fan_height+r2]) rotate([0,90,0]) cylinder(r=r1,h=fan_width-skin_thickness*2+1);
                          translate([-.5,r1-skin_thickness/2,r1*2]) rotate([0,90,0]) cylinder(r=r1,h=fan_width-skin_thickness*2+1);
                        }
                        //horizonal top cut
                         hull() {
                             translate([-.5,r1+skin_thickness,r1*2]) rotate([0,90,0]) cylinder(r=r1,h=fan_width-skin_thickness*2+1);
                           translate([-.5,fan_length*2,r1*2]) rotate([0,90,0]) cylinder(r=r1,h=fan_width-skin_thickness*2+1);
                        }
                       //top horizontal cut 
                      //translate([0,fan_top_length/2,fan_thickness]) cube([fan_width+.1,fan_length*2,fan_height]);
   
                    }
                }
         
        }
            
}
 
module circular_fan_shape() {
    
   
    translate([fan_offset+fan_width/2,fan_length+fan_diameter/2+fan_thickness/2,fan_thickness/2])
    rotate([0, 0, fan_rotate])
    {
         

        difference() {
            //fan torus
            difference() {
                translate([0,0,0]) torus(fan_thickness,fan_diameter,-fan_thickness/2,-180); 
                
                if(fan_type==0)
                //cut in half if needed
               translate([-fan_diameter/2-fan_thickness,0,-fan_thickness/2-skin_thickness])cube([fan_diameter+fan_thickness*2+10,fan_diameter,fan_thickness+pad*2+skin_thickness*2]);
                
            }
         
            //vent ports cutout
                for (a =[vent_angle_start:vent_angle_shift:-360]) {   
                    translate([0,0,vent_cutout_offset]) 
                    rotate([0,vent_angle,a]) 
                            cylinder(r=vent_hole_radius,h=fan_diameter/2+fan_thickness/2-skin_thickness*2);
                     
             
                 }
         
        }
    }   
}

module circular_fan_shape_cutout() {
  
    translate([fan_offset+fan_width/2,fan_length+fan_diameter/2+fan_thickness/2,fan_thickness/2])
    rotate([0, 0, fan_rotate])
    difference () {
         //torus inside round cutout 360 degs
         
         torus(fan_thickness-(skin_thickness*2),fan_diameter,-fan_thickness/2);
         
         //half torus cutout if chosen
         if(fan_type==0)
         translate(
         [
            -(fan_diameter+fan_thickness*2)/2
            , -fan_thickness/4
            ,-(fan_thickness+pad*4)/2])
         cube([fan_diameter+fan_thickness*2,fan_diameter,fan_thickness+pad*4]);  
       
    }
    difference() {
    // inside torus square throat cutout
          translate([skin_thickness,fan_length,skin_thickness-pad]) cube([fan_width-skin_thickness*2,fan_thickness+skin_thickness,fan_thickness-(skin_thickness*2)+pad],center=false);
            
      //now make the throat cutout match fan round shape
           translate([fan_offset+fan_width/2,fan_length+fan_diameter/2+fan_thickness/2,-fan_thickness/2])
       cylinder(r=fan_diameter/2,h=fan_thickness*2);  
    }
}


module top_insert_shape() {
      
        //top insert 
       
        difference(){
            //outer insert
            union() {
               translate([0,0,fan_height-top_skin_thickness])  cube([fan_width,fan_top_length,top_skin_thickness]);
                translate([fan_shoulder,fan_shoulder,fan_height])  cube([fan_insert_width,fan_insert_length,fan_insert_height]);
            }
            //inside cutout 
            translate([fan_shoulder+top_skin_thickness,fan_shoulder+top_skin_thickness,fan_height-top_skin_thickness-pad])  cube([fan_insert_width-top_skin_thickness*2,fan_insert_length-top_skin_thickness*2,fan_insert_height+top_skin_thickness*2]);
        }
      //right inside bottom fillet
     translate ([skin_thickness-.2,fan_top_length/2,fan_height-top_skin_thickness]) rotate([90,90,0]) fillet(top_skin_thickness,fan_top_length-pad);
     //left inside bottom fillet   
     translate ([fan_width-skin_thickness+.2,fan_top_length/2,fan_height-top_skin_thickness]) rotate([90,90,180]) fillet(top_skin_thickness,fan_top_length-pad);
     //front inside bottom fillet  
   translate ([fan_width/2,fan_top_length-skin_thickness+.2,fan_height-top_skin_thickness]) rotate([180,90,0]) fillet(top_skin_thickness,fan_width-pad);
    //back inside bottom fillet  
  translate ([fan_width/2,fan_shoulder,fan_height-top_skin_thickness]) rotate([0,90,0]) fillet(top_skin_thickness,fan_width-pad);  
      
      
     if (fan_side_clip) {
         //right half arrow on tab
         translate ([fan_shoulder+pad,tab_width/2+fan_insert_length/2+.25,fan_height+fan_insert_height-2])rotate([0,0,0])
        triangle(top_skin_thickness/2,top_skin_thickness,tab_width);
        
         //left half arrow on tab
         translate ([fan_shoulder+fan_insert_width-pad,tab_width/2+fan_insert_length/2+.25,fan_height+fan_insert_height-2])rotate([0,0,180])
        triangle(top_skin_thickness/2,top_skin_thickness,tab_width);    
     }   
        
}

module tab_cutout() {
    
  
  
    //cut 4 slots ( 2 slots each side) to create tabs 
      translate ([fan_shoulder-pad-top_skin_thickness,fan_shoulder+fan_insert_length/2+tab_width/2,fan_height+tab_width/2])cube([top_skin_thickness*2+pad*2,.5,fan_insert_height]); 
    
      translate ([fan_shoulder-pad-top_skin_thickness,fan_shoulder+fan_insert_length/2-tab_width/2-.5,fan_height+tab_width/2])cube([top_skin_thickness*2+pad*2,.5,fan_insert_height]); 
    
      translate ([fan_shoulder+fan_insert_width-top_skin_thickness-pad,fan_shoulder+fan_insert_length/2+tab_width/2,fan_height+tab_width/2])cube([top_skin_thickness*2+pad*2,1,fan_insert_height]); 
      translate ([fan_shoulder+fan_insert_width-top_skin_thickness-pad,fan_insert_length/2-.5,fan_height+tab_width/2])cube([top_skin_thickness*2+pad*2,1,fan_insert_height]); 
    
  
}

module triangle(b,h,w) {
  
    rotate(a=[90,-90,0])
 linear_extrude(height = w, center = true, convexity = 10, twist = 0)
 polygon(points=[[0,0],[h,0],[0,b]], paths=[[0,1,2]]);
}


module fillet(r, h) {
    
    translate([r / 2, r / 2, 0])
        difference() {
            cube([r + pad, r + pad, h], center = true);
            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);
        }
}


module torus (th, dia,off,angle) {

 hull_offset_adj=1;
 d1lb3rt66=0;
 rotate_extrude(angle=-360,convexity = 10) 
  
    union() {
         difference() {
             
                hull() {
                    
                    translate([dia/2, 0, 0]) circle(r=th/2);
                   translate([dia/2-th/2-hull_offset_adj,-th/2+th/8,0]) circle(r=th/8);
                   
                }
               
               * translate([0,-th/2+th/8-d1lb3rt66,0]) rotate([180,0,0])  square([dia,th]);
        }
        
    }
}




