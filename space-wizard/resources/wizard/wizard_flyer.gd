
extends RigidBody2D

onready var prograde = get_node('prograde')
onready var base = get_node('base')
onready var pants = base.get_node('pants')
onready var arms = base.get_node('arms')
onready var head = base.get_node('head')

onready var shoot_timer = get_node('shoot_timer')

var fire_count = 0 setget _set_fire_count
var water_count = 0 setget _set_water_count
var earth_count = 0 setget _set_earth_count
var air_count = 0 setget _set_air_count
var magic_count = 0 setget _set_magic_count

var X_SPEED = 420
var Y_SPEED = X_SPEED / 2

var dir = 1

var arm_state = 0

var can_shoot = true

func _integrate_forces(state):
	# get delta (if we need it)
	var delta = state.get_step()
	# flag input from actions
	var UP = Input.is_action_pressed("fly_up")
	var DOWN = Input.is_action_pressed("fly_down")
	var LEFT = Input.is_action_pressed("fly_left")
	var RIGHT = Input.is_action_pressed("fly_right")
	
	var SHOOT = Input.is_action_pressed("shoot")
	
	#initial motion vector (or for no input)
	var v = Vector2(X_SPEED,0)
	
	var pants_f = 1
	var new_dir = dir
	
	if UP:	v.y = -Y_SPEED
		pants_f = 2
	if DOWN:	v.y = Y_SPEED
		pants_f = 0
	
	if LEFT:	new_dir = -1
	if RIGHT:	new_dir = 1
	
	if pants_f != pants.get_frame():
		pants.set_frame(pants_f)
	if new_dir != dir:	dir = new_dir
	if dir != base.get_scale().x:
		base.set_scale(Vector2(dir*2,2))
	v.x *= dir
	set_linear_velocity(v)
	prograde.set_pos(v*0.5)
	
	
	if can_shoot:
		if SHOOT and !arms.get_node('anim').is_playing():
			can_shoot = false
			shoot_timer.start()
			if arm_state == 0:
				arms.get_node('anim').play('main')
				arm_state = 1
			else:
				arms.get_node('anim').play_backwards('main')
				arm_state = 0



func _on_shoot_timer_timeout():
	can_shoot = true
	shoot_timer.stop()

func _set_fire_count( value ):
	fire_count = value
	print(fire_count)

func _set_water_count( value ):
	water_count = value
	print(fire_count)
	
func _set_earth_count( value ):
	earth_count = value
	print(fire_count)
	
func _set_air_count( value ):
	air_count = value
	print(fire_count)
	
func _set_magic_count( value ):
	magic_count = value
	print(fire_count)


func get_powerup( item ):
	if 'element' in item:
		var E = item.element
		if E == item.FIRE:
			set('fire_count', fire_count+1)
		if E == item.WATER:
			set('water_count', water_count+1)
		if E == item.EARTH:
			set('earth_count', earth_count+1)
		if E == item.AIR:
			set('air_count', air_count+1)
		if E == item.MAGIC:
			set('magic_count', magic_count+1)