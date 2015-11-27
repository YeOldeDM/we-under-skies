
extends Sprite

var starName

var name

func _ready():
	starName = get_node('/root/skana')
	
	var size = rand_range(0.25,0.5)
	if rand_range(0,1) < 0.01:
		size *= 2.0
	set_scale(Vector2(size,size))
	
	name = starName.makeName(int(rand_range(1,3)),2)




func _on_Area2D_mouse_enter():
	get_node('/root/Node/starname').set_text(name)
