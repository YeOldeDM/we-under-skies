
extends RigidBody2D

onready var limit

func _ready():
	#set_fixed_process(true)
	pass
	
func _fixed_process(delta):
	var pos = get_pos()
	if pos.x < 0:
		pos.x += limit.x
	if pos.x > limit.x:
		pos.x -= limit.x
	if pos.y < 0:
		pos.y += limit.y
	if pos.y > limit.y:
		pos.y -= limit.y
	if pos != get_pos():
		set_pos(pos)


