
extends Node

var m_pos = null

func _ready():
	# Initialization here
	set_process(true)
	
func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		if m_pos == null:
			m_pos = get_tree().get_root().get_mouse_pos()
		var new_pos = get_tree().get_root().get_mouse_pos()
		var diff = m_pos - new_pos
		for o in get_children():
			var pos = o.get_pos()
			#print(pos)
			pos -= diff
			o.set_pos(pos)
		m_pos = new_pos
	else:
		m_pos = null



func _on_VisibilityNotifier2D_exit_screen():
	pass # replace with function body
