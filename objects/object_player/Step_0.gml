/// @description happens every frame of the game
// You can write your code in this editor


// vk stands for "virtual keyboard"
key_left = keyboard_check(vk_left); // check evaluates to 1 or 0
key_right = keyboard_check(vk_right); // check evaluates to 1 or 0
key_jump = keyboard_check_pressed(vk_space); // check evaluates to 1 or 0

// this will evaluated whether or not these things happened ON this frame

// var establishes that the value exists only for one frame
var move = key_right - key_left; // right = 1, left = -1, both/no move = 0;

horizontal_speed = move * walk_speed;
vertical_speed = vertical_speed + custom_gravity;
eventual_x_location = x + horizontal_speed;
custom_gravity = .2;
// HORIZONTAL COLLISION
// we want to stop when we hit walls
// we also want to stop on sub walk speeds to go flush against walls
if (place_meeting(eventual_x_location, y, object_wall)) {
	// sign(number) = 1 if num is positive, -1 if num is negative
	// this accounts for both directions
	while (!place_meeting(x+sign(horizontal_speed), y, object_wall)) { // this while runs on a SINGLE frame
		x += sign(horizontal_speed);
	}
	double_jump_used = 0;
	horizontal_speed = 0;
	custom_gravity = .05;
}
// x and y is a built in variable for the sprite's x coordinate
// changing these physically moves the sprite
x += horizontal_speed;

// check if on floor
// if (place_meeting(x, y+1, object_wall) && key_jump && !double_jump_used) {


// allow for double jump
if (!double_jump_used && key_jump) {
	vertical_speed = jump_height;
	double_jump_used = 1;
}

// recharge double jump
if (place_meeting(x, y+1, object_wall)) {
	double_jump_used = 0;	
}

eventual_y_location = y + vertical_speed;
// VERTICAL COLLISION
// we want to stop when we hit walls
// we also want to stop on sub walk speeds to go flush against walls
if (place_meeting(x, eventual_y_location, object_wall)) {
	// sign(number) = 1 if num is positive, -1 if num is negative
	// this accounts for both directions
	while (!place_meeting(x, y+sign(vertical_speed), object_wall)) { // this while runs on a SINGLE frame
		y += sign(vertical_speed);
	}
	vertical_speed = 0;
}
// x and y is a built in variable for the sprite's x coordinate
// changing these physically moves the sprite
y += vertical_speed;

// fall out of the board, respawn up top
if (y > 800) {
	x = 34;
	y = 64;
}

