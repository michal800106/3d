// A router attachment for a dremel multitool
// This fits my dremel 395 nicely.
// Len Trigg <lenbok@gmail.com>


// You need the sylwych's thread library. Get it from:
// http://www.thingiverse.com/thing:8793
// or
// https://github.com/syvwlch/Thingiverse-Projects/tree/master/Threaded%20Library
include<syvwlch/Thingiverse-Projects/Threaded Library/Thread_Library.scad>


wallThickness=4; // Thickness of the walls, increase for more strength
threadRad=9.0;   // Tweak this so the thread fits snugly on your dremel
nutRad=14;       // Outer radius of the nut / top of attachment
nutDepth=9.5;    // Depth of the top nut
baseRad=(55/2) + wallThickness; // Outer radius at the base
baseDepth=35;    // Distance from bottom of the nut to the base
baseLift=5;      // How much of the base rises vertically before the cone starts / windows are cut out
holeRad=15;      // Radius of the window corners

// Set resolution parameters
$fn=0;
$fa=0.6;
$fs=4;

module routerAttachment() {

    // Top nut that attaches to the rotary tool
    translate([0,0,baseDepth]) trapezoidNut(length=nutDepth, radius=nutRad, 
        pitch=2.0, pitchRadius=threadRad, threadHeightToPitch=0.7, stepsPerTurn=20, countersunk=0.2);

    // The router attachment
    difference() {

        // Main body
        union() {
            translate([0,0,baseLift]) cylinder(r1=baseRad, r2=nutRad, h=baseDepth-baseLift);
            cylinder(r=baseRad, h=baseLift);
        }
        
        // Cut out the center
        translate([0,0,baseLift]) cylinder(r1=baseRad-wallThickness, r2=nutRad-wallThickness, h=baseDepth-baseLift);
        cylinder(r=baseRad-wallThickness, h=baseLift);

        // Cut out the side windows
        for (i = [0:1]) {
            mirror([i, 0, 0])
            translate([nutRad+0, 0, baseLift]) hull() translate([holeRad, 0, holeRad]) {
                rotate([0,90,90]) cylinder(r=holeRad, h=baseRad*2,center=true);
                translate([0,0,baseDepth]) rotate([0,90,90]) cylinder(r=holeRad, h=baseRad*2,center=true);
                translate([baseRad,0,0]) rotate([0,90,90]) cylinder(r=holeRad, h=baseRad*2,center=true);
            }
        }
    }
}

routerAttachment();
