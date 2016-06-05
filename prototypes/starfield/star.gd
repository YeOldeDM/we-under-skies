
extends Sprite

var data

func _ready():
	pass

func _on_Area2D_mouse_enter():
	get_parent().set_star_label_text(data.name, get_modulate())
	get_parent().set_star_label_pos(self.get_pos())


func _on_Area2D_mouse_exit():
	get_parent().set_star_label_text("")


func _on_Selector_pressed():
	get_parent().show_world_info(self.data)
