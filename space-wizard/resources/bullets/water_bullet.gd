
extends RigidBody2D

var SPEED = 1200
var DMG = 12

var Power = 1

func fire(global_pos, dir):
	set_global_pos(global_pos)
	get_node('Sprite').set_scale(Vector2(dir*Power,Power))
	var V = Vector2(SPEED*dir, 0)
	set_linear_velocity(V)



func _die():
	queue_free()


func _on_Collider_body_enter( body ):
	if body.has_method('got_hit'):
		body.call('got_hit', DMG, 1)
		_die()


func _on_Visibility_exit_screen():
	_die()