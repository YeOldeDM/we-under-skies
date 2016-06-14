
extends RigidBody2D

onready var player = get_parent().get_node('Player')
onready var sprite = get_node('Sprite')

var safe_distance = 80
var max_speed = 150

func _ready():
	set_linear_velocity(player.get_linear_velocity())
	
func _integrate_forces(state):
	var delta = state.get_step()
	var lv = get_linear_velocity()
	var tlv = player.get_linear_velocity()
	var D = (player.get_pos() - get_pos()).length()

	print(D)
	lv.x -= tlv.x
	lv.y -= tlv.x
	
	set_linear_velocity(lv)
	
	if sprite.get_scale() != player.base.get_scale():
		sprite.set_scale(player.base.get_scale())

