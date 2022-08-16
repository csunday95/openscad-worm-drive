
include <MCAD/involute_gears.scad>

$fs = 0.01;
$fa = 0.02;

worm_teeth = 6;
gear_ratio = 6;
wheel_teeth = worm_teeth * gear_ratio;
worm_length = 12;
wheel_thickness = 2;
worm_shaft_addendum = 6;
worm_shaft_radius = 1 / 2;
worm_shaft_key_size = 0.25;
worm_shaft_key_length = 6;
wheel_shaft_radius = 2 / 2;
wheel_shaft_key_size = 0.5;
wheel_shaft_key_length = 1.5;
cage_depth = 6;
diametral_pitch = 2;
circular_pitch = pi / diametral_pitch;
worm_pitch_diameter = worm_teeth * circular_pitch / pi;
worm_addendum = worm_pitch_diameter / worm_teeth;
worm_pitch_radius = worm_pitch_diameter / 2;
worm_outer_radius = worm_pitch_radius + worm_addendum;
wheel_pitch_diameter = wheel_teeth * circular_pitch / pi;
wheel_addendum = wheel_pitch_diameter / wheel_teeth;
wheel_pitch_radius = wheel_pitch_diameter / 2;
wheel_outer_radius = wheel_pitch_radius + wheel_addendum;
center_dist = wheel_pitch_radius + worm_pitch_radius;
cage_width = worm_length + worm_shaft_addendum;
wheel_cage_slice_size = 2 * sqrt(wheel_outer_radius ^ 2 - (cage_width / 2) ^ 2);
cage_worm_shaft_offset = 4;
involute_teeth_facets=24;

// worm
difference() {
    linear_extrude(worm_length, center=true, convexity=3, twist=360) {
        gear(
            number_of_teeth=6,
            diametral_pitch=2,
            clearance=0,
            pressure_angle=30,
            circles=0,
            backlash=0,
            bore_diameter=0,
            involute_facets=involute_teeth_facets,
            flat=true
        );
    }
    cylinder(r=worm_shaft_radius * 0.98, h=worm_length + 2, center=true);
    translate([worm_shaft_radius * 0.98, 0, 0])
        cube([2 * worm_shaft_key_size, worm_shaft_key_size, worm_length + 1], center=true);
}

//// worm shaft
//translate([-6, -6, 0])
//    union() {
//        cylinder(h=worm_length + worm_shaft_addendum, r=worm_shaft_radius * 0.975, center=true);
//        translate([worm_shaft_radius * 0.975, 0, 0])
//            cube([
//                2 * worm_shaft_key_size * 0.98,
//                worm_shaft_key_size * 0.98,
//                worm_shaft_key_length
//            ], center=true);
//    }
//
//// wheel
//translate([center_dist + 0.5, 0, 0])
//rotate([90, 0, 0])
//difference() {
//    linear_extrude(wheel_thickness, center=true, convexity=2, twist=atan2(2, 12)) {
//        gear(
//            number_of_teeth=6*6,
//            diametral_pitch=2,
//            clearance=0,
//            pressure_angle=30,
//            circles=0,
//            backlash=0,
//            bore_diameter=2 * wheel_shaft_radius,
//            involute_facets=involute_teeth_facets,
//            flat=true
//        );
//    }
//    translate([wheel_shaft_radius, 0, 0])
//        cube([2 * wheel_shaft_key_size, wheel_shaft_key_size, wheel_thickness + 2], center=true);
//}
//
//// wheel shaft
//translate([-6, 0, 0]) {
//    union() {
//        cylinder(h=cage_depth, r=(wheel_shaft_radius * 0.98), center=true);
//        translate([wheel_shaft_radius * 0.98, 0, 0])
//            cube([
//                2 * wheel_shaft_key_size * 0.95,
//                wheel_shaft_key_size * 0.95,
//                wheel_shaft_key_length
//            ], center=true);
//    }
//}
//
//// cage
//cage_height = 30;
//worm_shaft_x = -cage_height/2 + cage_worm_shaft_offset;
//wheel_shaft_x = worm_shaft_x + center_dist;
//large_slot_length = wheel_outer_radius * 2.1;
//
//translate([10, 10, 0]) {
//    difference() {
//        cube([cage_height, cage_depth + 2, cage_width], center=true);
//        // main interior volume
//        cube([cage_height + 2, cage_depth, cage_width - 2], center=true);
//        // upper slice for wheel during rotation
//        translate([wheel_shaft_x, 0, cage_width / 2]) {
//            linear_extrude(cage_width + 2, center=true) {
//                square([wheel_cage_slice_size * 1.2, wheel_thickness * 1.2], center=true);
//                translate([-wheel_cage_slice_size * 1.2 * 0.5, 0])
//                    circle(r=wheel_thickness * 1.2 * 0.5);
//                translate([wheel_cage_slice_size * 1.2 * 0.5, 0])
//                    circle(r=wheel_thickness * 1.2 * 0.5);
//            }
//        }
//        // lower slice for wheel insertion
//        translate([worm_shaft_x + center_dist + worm_outer_radius, 0, -cage_width / 2])
//            linear_extrude(cage_width + 2, center=true) {
//                square([large_slot_length, wheel_thickness * 1.2], center=true);
//                translate([-large_slot_length / 2, 0])
//                    circle(r=(wheel_thickness * 1.2) / 2);
//                translate([large_slot_length / 2, 0])
//                    circle(r=(wheel_thickness * 1.2) / 2);
//            }
//        // worm shaft hole
//        translate([worm_shaft_x, 0 ,0]) {
//            cylinder(h=cage_width + 2, r=worm_shaft_radius, center=true);
//            translate([worm_shaft_radius, 0, 1])
//                cube([2 * worm_shaft_key_size, worm_shaft_key_size, cage_width], center=true);
//        }
//        // wheel shaft hole
//        translate([wheel_shaft_x, 0, 0])
//            rotate([90, 0, 0]) {
//                cylinder(h=cage_width + 2, r=wheel_shaft_radius, center=true);
//                translate([wheel_shaft_radius, 0, 2])
//                    cube([2 * wheel_shaft_key_size, wheel_shaft_key_size, cage_depth], center=true);
//            }
//    }
//}
