
extends RigidBody2D

onready var sprite = get_node('Sprite')

const FIRE = 0
const WATER = 1
const EARTH = 2
const AIR = 3
const MAGIC = 4

var element = FIRE

func set_element( ele ):
	element = ele
	sprite.set_frame(element)






func _hit_wizard( body ):
	if body.has_method('get_powerup'):
		body.call('get_powerup', self)
	queue_free()
