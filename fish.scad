union() {
    translate([4, 0, 0])
    link();
    translate([40, 0, 0])
    link();
    translate([76, 0, 0])
    link();
    
    translate([36, 0, 0]) {
        bone("small");
        bone("medium");
    };
    bone("medium");
    bone("large");
};

module link() {
    rotate([0, -90, 0])
    linear_extrude(height=20) {
        projection() {
            rotate([0, 90, 0])
            intersection() {
                bone("medium");
                translate([32, 0, 0])
                cube([20, 20, 20], center=true);
            };
        };
    };
};

module head() {
    import("/home/michalz/Downloads/Fish_Bone_Wall_Hanger_-_Modular_Version/Fish_Bone_Wall_Hanger_-_Modular_Version/fish_bone_wall_hanger_02-head.stl");
};

module tail() {
    import("/home/michalz/Downloads/Fish_Bone_Wall_Hanger_-_Modular_Version/Fish_Bone_Wall_Hanger_-_Modular_Version/fish_bone_wall_hanger_02-tail.stl");
};


module bone(size) {
    import(str("/home/michalz/Downloads/Fish_Bone_Wall_Hanger_-_Modular_Version/Fish_Bone_Wall_Hanger_-_Modular_Version/fish_bone_wall_hanger_02-bone_", size, ".stl"));
}