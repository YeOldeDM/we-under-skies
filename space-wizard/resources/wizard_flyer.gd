
extends RigidBody2D

var fire_bullet_obj = preload('res://resources/bullets/fire_bullet.tscn')

var bullets = [
	preload('res://resources/bullets/fire_bullet.tscn'),
	preload('res://resources/bullets/water_bullet.tscn'),
	preload('res://resources/bullets/earth_bullet.tscn'),
	preload('res://resources/bullets/air_bullet.tscn'),
	]

var tex_pants = preload('res://assets/graphics/wiz_legs_sheet.png')
var tex_nopants = preload('res://assets/graphics/wiz_shorts_sheet.png')

onready var main = get_node('/root/Main')

onready var prograde = get_node('prograde')
onready var base = get_node('base')
onready var pants = base.get_node('pants')
onready var arms = base.get_node('arms')
onready var head = base.get_node('head')

onready var current_element = get_node('current_element')

onready var shoot_point = get_node('shoot_point')
onready var shoot_left = shoot_point.get_node('shoot_left')
onready var shoot_right = shoot_point.get_node('shoot_right')
onready var shoot_timer = get_node('shoot_timer')

var fire_count = 0 setget _set_fire_count
var water_count = 0 setget _set_water_count
var earth_count = 0 setget _set_earth_count
var air_count = 0 setget _set_air_count
var magic_count = 0 setget _set_magic_count

var X_SPEED = 350 setget _set_speed
var Y_SPEED = X_SPEED / 3

var dir = 1

var arm_state = 0

var can_shoot = true
var shoot_element = 0 setget _set_element
var shoot_rate = 6 setget _set_shoot_rate

var has_pants = true setget _set_pants

func _set_speed( value ):
	X_SPEED = value
	Y_SPEED = X_SPEED / 3

func _set_shoot_rate( value ):
	shoot_rate = value
	arms.get_node('anim').set_speed(value)

func _set_pants( value ):
	has_pants = value
	if value == false:
		pants.set_texture(tex_nopants)
	else:
		pants.set_texture(tex_pants)

func _set_element( value ):
	shoot_element = value
	current_element.set_frame(value)

func _integrate_forces(state):
	# get delta (if we need it)
	var delta = state.get_step()
	# flag input from actions
	var UP = Input.is_action_pressed("fly_up")
	var DOWN = Input.is_action_pressed("fly_down")
	var LEFT = Input.is_action_pressed("fly_left")
	var RIGHT = Input.is_action_pressed("fly_right")
	
	var SHOOT = Input.is_action_pressed("shoot")
	
	var ch_fire = Input.is_key_pressed(KEY_1)
	var ch_water = Input.is_key_pressed(KEY_2)
	var ch_earth = Input.is_key_pressed(KEY_3)
	var ch_air = Input.is_key_pressed(KEY_4)
	
	#initial motion vector (or for no input)
	var v = Vector2(X_SPEED,0)
	
	# set up values for pants frame and facing
	var pants_f = 1
	var new_dir = dir
	

	if !main.is_console_active():
		# Set values based on input
		if UP:	v.y = -Y_SPEED
			pants_f = 2
		if DOWN:	v.y = Y_SPEED
			pants_f = 0
		
		if LEFT:	new_dir = -1
		if RIGHT:	new_dir = 1
		
		# set new pants frame
		if pants_f != pants.get_frame():
			pants.set_frame(pants_f)
		# set new facing
		if new_dir != dir:	
			dir = new_dir

		if ch_fire:		set('shoot_element', 0)
		if ch_water:	set('shoot_element', 1)
		if ch_earth:	set('shoot_element', 2)
		if ch_air:		set('shoot_element', 3)
		
		
		# Shooting logic
		#if can_shoot:
		if SHOOT and !arms.get_node('anim').is_playing():
			#can_shoot = false
			#shoot_timer.start()
			if arm_state == 0:
				arms.get_node('anim').play('main')
				arm_state = 1
			else:
				arms.get_node('anim').play_backwards('main')
				arm_state = 0
			
			var B = bullets[shoot_element].instance()
			get_parent().add_child(B)
			var P = shoot_right
			if arm_state == 1:
				
				P = shoot_left
			
			P = P.get_global_pos()
	
			B.fire(P,dir)

	# set new offset for shootpoint
	var P = 90*dir
	P = Vector2(P,0)
	if P != shoot_point.get_pos():
		shoot_point.set_pos(P)
	
	# set new sprite facing
	if dir != base.get_scale().x:
		base.set_scale(Vector2(dir*2,2))
	
	# set X velocity and apply linear velocity
	v.x *= dir
	set_linear_velocity(v)
	
	# set prograde offset (for camera tracking)
	var pp = Vector2(v.x*0.8,0)
	prograde.set_pos(pp)
	





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