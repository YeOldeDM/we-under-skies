
extends RigidBody2D

onready var player = get_parent().get_node('Player')
onready var sprite = get_node('Sprite')

var safe_distance = 80

func _integrate_forces(state):
	var delta = state.get_step()
	var lv = get_linear_velocity()
	
	var dv = get_pos() - player.get_pos()
	
	var D = dv.length()
	if D > safe_distance:
		lv -= dv*delta
	elif D < safe_distance:
		lv += dv*delta
	
	if lv != get_linear_velocity():
		set_linear_velocity(lv)
	
	if sprite.get_scale() != player.base.get_scale():
		sprite.set_scale(player.base.get_scale())

