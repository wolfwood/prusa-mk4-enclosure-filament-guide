
module prusa_plug() {
  rotate([180,0,90]) translate([0,0,-1.5])import("Top-plug-center.stl");
}

module prusa_guide() {
  translate([48.15,-51.25,8.9612]) difference(){
    import("filament-guide-R1.3mf");
    let(z=40) translate([-27.5,-60,-z/2]) cube([90,130,z]);
  }
}

module guide_end(){
  rotate([0,0,180]) difference() {
    prusa_guide();
    translate([20,0,0]) cube([40,20,20],center=true);
  }
}

module enclosure_top_filament_guide_flat(){
  difference(){
    prusa_plug();
    // remove material from plug that would block the holes in the bottom of the guide on the +X axis side
    //translate([0,-10,-2])cube([20.5,20,4]);
    let(y=11)translate([0,-y/2,-2])cube([20.5,y,4]);
    // don't block the screw holes in the sides
    let(y=16)translate([0,-y/2,.75])cube([20.5,y,4]);

    // remove the part that goes into the lid hole so we can print without supports
    *translate([-5-3,-10,-4])cube([20.5,20,4]);
    let(x=80)translate([-x/2,-10,-4])cube([x,20,4]);

    // cut the PTFE tube hole for the -X axis side of the hole
    cylinder($fn=60, r=5.5,h=4,center=true);
  }

  prusa_guide();

  translate([20.15,0,0]) {
    // extend the deck of the flex chamber
    let(x=5,y=11,z=4){
      difference(){
	translate([.5,-y/2,0])cube([x,y,z]);

	// remove protruding corners
	let(dx=5,dy=3) {
	  translate([dx,dy,-1]) rotate([0,0,45]) cube([3,3,z+2]);
	  mirror([0,-1,0])translate([dx,dy,-1]) rotate([0,0,45]) cube([3,3,z+2]);
	}
      }
    }

    // close the flex chamber keeping both inside and outside walls flush
    intersection(){
      scale([1,1.025,1]) guide_end();
      guide_end();
    }
  }
}

module enclosure_top_filament_guide(){
  difference(){
    prusa_plug();

    // extrude the flex cuts
    translate([0,0,-2]) linear_extrude(4) projection() difference() {
      let(x=22.5,y=14)translate([-2,-y/2,0])cube([x,y,.1]);
      translate([0,0,-2]) linear_extrude(4) projection() intersection(){
	let(x=80)translate([-x/2,-10,0])cube([x,20,.1]);
	prusa_guide();
      }
    }

    // don't block the screw holes in the sides
    let(y=16)translate([0,-y/2,.75])cube([20.5,y,4]);

    // cut the PTFE tube hole for the -X axis side of the hole
    cylinder($fn=120, r=6.9,h=4,center=true);
  }

  prusa_guide();

  translate([20.15,0,0]) {
    // extend the deck of the flex chamber
    let(x=5,y=11,z=4){
      difference(){
	translate([.5,-y/2,0])cube([x,y,z]);

	// remove protruding corners
	let(dx=5,dy=3) {
	  translate([dx,dy,-1]) rotate([0,0,45]) cube([3,3,z+2]);
	  mirror([0,-1,0])translate([dx,dy,-1]) rotate([0,0,45]) cube([3,3,z+2]);
	}
      }
    }

    // close the flex chamber keeping both inside and outside walls flush
    intersection(){
      scale([1,1.025,1]) guide_end();
      guide_end();
    }
  }
}

enclosure_top_filament_guide();
