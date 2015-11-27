
extends Panel

var screen_pos
var chunk = [0,0]

func _ready():
	get_node('label').set_text(str(chunk))
	set_process(true)
	
	
func _process(delta):
	screen_pos = get_pos() + (get_size()/2)





func _on_VisibilityNotifier2D_exit_screen():
	print("BING")
	queue_free()
