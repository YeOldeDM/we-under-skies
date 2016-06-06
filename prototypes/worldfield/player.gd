
extends RigidBody2D

var SPEED = 145

func _integrate_forces(state):
	var delta = state.get_step()
	# Get flags for Input
	var UP = Input.is_action_pressed('ui_up')
	var DOWN = Input.is_action_pressed('ui_down')
	var LEFT = Input.is_action_pressed('ui_left')
	var RIGHT = Input.is_action_pressed('ui_right')
	
	# Set an initial vector (or for no input)
	var v = Vector2(0,0)
	
	# modify vector by Input
	if UP: v.y = -1
	if DOWN: v.y = 1
	if LEFT: v.x = -1
	if RIGHT: v.x = 1
	
	# cancel out movement if conflicting directions are pressed
	if UP and DOWN: v.y=0
	if LEFT and RIGHT: v.x=0
	
	# Normalize and scale speed
	v = v.normalized()*(SPEED)
	
	# Apply movement
	set_linear_velocity(v)


