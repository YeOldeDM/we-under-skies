
extends Sprite

var data

func _ready():
	pass

func _on_Area2D_mouse_enter():
	get_parent().get_node('NAME').set_text(data.name)


func _on_Area2D_mouse_exit():
	get_parent().get_node('NAME').set_text("")
