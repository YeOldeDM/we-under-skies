
extends RigidBody2D

var SPEED = 264

onready var cam = get_node('eyes')

func _ready():
	set_process_input(true)

func _input(event):
	if event.type == InputEvent.KEY:
		var z = null
		var i = event.scancode
		if i == KEY_1:
			z = 0.25
		if i == KEY_2:
			z = 1.0
		if i == KEY_3:
			z = 2.0
		if i == KEY_4:
			z = 2.5
		if i == KEY_5:
			z = 3.0
		if i == KEY_6:
			z = 3.5
		if i == KEY_7:
			z = 4.0
		if i == KEY_8:
			z = 6.0
		if i == KEY_9:
			z = 8.0
		if i == KEY_0:
			z = 10.0
		if i == KEY_BRACERIGHT:
			z = cam.get_zoom().x * 1.02
		if i == KEY_BRACELEFT:
			z = cam.get_zoom().x * 0.98
		if z and cam.get_zoom().x != z:
			cam.set_zoom(Vector2(z,z))

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

