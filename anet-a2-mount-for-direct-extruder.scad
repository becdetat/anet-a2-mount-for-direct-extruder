// Anet A2 mount for NEMA 17 direct extruder
// https://github.com/bendetat/anet-a2-mount-for-direct-extruder
//
// NEMA 17 model (http://www.thingiverse.com/thing:3165) from Bogdam Kecman (http://www.thingiverse.com/BogdanKecman/about)

// Set the length to 50 for a standard NEMA 17 stepper, or 30 for a pancake stepper

$fn = 50;

width = 50;
length = 30; //50;
thickness = 3;

translate([0,length/2,width])
top_plate();
back_plate();
translate([width/2, 0, 0])
brace();
translate([-width/2 + thickness, 0, 0])
brace();

// Uncomment to see with a NEMA 17 in position
//translate([0,thickness+0.2,width/2])
//rotate([90,0,0])
//nema17();

module brace() {
    translate([0,thickness,0])
    rotate([0,270,0])
    linear_extrude(height=thickness)
    polygon([
        [0,0],
        [width,0],
        [width,length-thickness]
    ]);
}

module back_plate() {
    translate([
        -width/2,
        0,
        0
    ])
    difference() {
        cube([
            width,
            thickness,
            width
        ]);
        
        translate([width/2,thickness+0.1,width/2])
        rotate([90,0,0])
        {
            // shaft
            cylinder(d=23.5,h=20);
        
            // screw holes
            translate([15.5,15.5,0])
            cylinder(d=3,h=10);
            translate([-15.5,15.5,0])
            cylinder(d=3,h=10);
            translate([15.5,-15.5,0])
            cylinder(d=3,h=10);
            translate([-15.5,-15.5,0])
            cylinder(d=3,h=10);
        }
    }
}

module top_plate() {
    difference() {
        translate([-width/2, -length/2, 0])
        cube([width, length, 3]);
        
        translate([0,(length-25)/2,0]) {
            translate([-10, -6, -0.1])
            cylinder(d=2.5, h=thickness*1.1);
            translate([10, -6, -0.1])
            cylinder(d=2.5, h=thickness*1.1);
            translate([10, 6, -0.1])
            cylinder(d=2.5, h=thickness*1.1);
            translate([-10, 6, -0.1])
            cylinder(d=2.5, h=thickness*1.1);
        }
    }
}


module rounded_box(dimensions, radius) {
    translate([radius, radius, radius]) {
        minkowski() {
            cube([
                dimensions[0] - radius,
                dimensions[1] - radius,
                dimensions[2] - radius
            ]);
            sphere(r=radius);
        }
    }
}


















// Model: NEMA23
// Model: NEMA17
// Author: Bogdan Kecman
// Licence: GPL
//
// Usage:
// nema17(1); //nema17 double shaft
// nema17(); //nema17 siingle shaft
// nema23(1, 1); //nema23 double shaft cylinder
// nema23(1); //nema23 double shaft cube
// nema23(); //nema23 single shaft cube
// nema23(0,1); //nema23 single shaft cylinder



module nema23(has_back, is_cylinder){
  mplate = 56.9; //mounting plate width
  mplateH = 5.3; //mounting plate height

  ringR = 38.10 / 2; //ring radius
  ringH = 1.3; //ring thickness

  shaftR = 6.337/2; //shaft radius
  shaftH = 20.6;  //shaft lenght

  bodyL = 46.5; //46.5, 56.1, 77.7, 103.1, ...
  bodyInnerCube = 37.6;

  holeR = 5.21/2;
  holeL = 47.14/2; //distance between hole centres

  difference(){
    union(){
      //mounting plate
      color([0.7,0.7,0.7]) cube(size = [mplate,mplate,mplateH], center = true);
      //ring
      color([0.7,0.7,0.7]) translate(v=[0,0,mplateH/2+ringH/2]) cylinder(r=ringR, h=ringH, center=true);
      //shaft front
      color([0.9,0.9,0.9]) translate(v=[0,0,mplateH/2+ringH+shaftH/2])cylinder(r=shaftR, h=shaftH, center=true);
      if (has_back == 1){
        color([0.9,0.9,0.9])  translate(v=[0,0,0-bodyL-shaftH/2]) cylinder(r=shaftR, h=shaftH, center=true);
      }
      //body
      if (is_cylinder == 1){
        color([0.1,0.1,0.1]) translate(v=[0,0,0-mplateH/2-bodyL/2]) cylinder(r=mplate/2, h=bodyL, center=true);
      }else{
        union(){
          color([0.1,0.1,0.1]) translate(v=[0,0,0-mplateH/2-bodyL/2]) cube(size = [bodyInnerCube, mplate, bodyL], center=true);
          color([0.1,0.1,0.1]) translate(v=[0,0,0-mplateH/2-bodyL/2]) cube(size = [mplate,bodyInnerCube, bodyL], center=true);
        }
      }
    }
    translate(v=[holeL,holeL,0]) cylinder(r = holeR, h = 2*mplateH, center=true);
    translate(v=[-holeL,holeL,0]) cylinder(r = holeR, h = 2*mplateH, center=true);
    translate(v=[-holeL,-holeL,0]) cylinder(r = holeR, h = 2*mplateH, center=true);
    translate(v=[holeL,-holeL,0]) cylinder(r = holeR, h = 2*mplateH, center=true);
  }
  
}

module nema17(has_back, is_cylinder){
  mplate = 42.67; //mounting plate width
  mplateH = 0; //mounting plate height

  ringR = 22 / 2; //ring radius, can be 21.95/2
  ringH = 2; //ring thickness

  shaftR = 5/2; //shaft radius, can be 4.988/2
  shaftH = 20.07;  //shaft lenght

  bodyL = 46.5; //25.3, 33.13, 34.7, 40.9, 47.0, ...

  holeR = 3.5/2; //M3 or M4 or #4-40
  holeL = 31.0/2; //distance between hole centres

  difference(){
    union(){
      //ring
      color([0.7,0.7,0.7]) translate(v=[0,0,ringH/2]) cylinder(r=ringR, h=ringH, center=true);
      //shaft front
      color([0.9,0.9,0.9]) translate(v=[0,0,ringH+shaftH/2])cylinder(r=shaftR, h=shaftH, center=true);
      if (has_back == 1){
        color([0.9,0.9,0.9]) translate(v=[0,0,0-bodyL-shaftH/2]) cylinder(r=shaftR, h=shaftH, center=true);
      }
      //body
      if (is_cylinder == 1){
        color([0.1,0.1,0.1]) translate(v=[0,0,0-bodyL/2]) cylinder(r=mplate/2*1.2, h=bodyL, center=true);
      }else{
        union(){
          color([0.1,0.1,0.1]) translate(v=[0,0,0-bodyL/2]) cube(size = [mplate, mplate, bodyL], center=true);
          color([0.1,0.1,0.1]) translate(v=[0,0,0-bodyL/2]) cube(size = [mplate, mplate, bodyL], center=true);
        }
      }
    }
    translate(v=[holeL,holeL,0-bodyL/2]) cylinder(r = holeR, h = bodyL+10, center=true);
    translate(v=[-holeL,holeL,0-bodyL/2]) cylinder(r = holeR, h = bodyL+10, center=true);
    translate(v=[-holeL,-holeL,0-bodyL/2]) cylinder(r = holeR, h = bodyL+10, center=true);
    translate(v=[holeL,-holeL,0-bodyL/2]) cylinder(r = holeR, h = bodyL+10, center=true);
  }
  
}