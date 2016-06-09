
extends Sprite

onready var twinkle = get_node('Twinkle')

var data
var twinkle_strength = 0.01

func _ready():
	set_process(true)

func _process(delta):
	var T = twinkle_strength
	var tscale = twinkle.get_scale()
	var true_scale = get_scale()
	var vari = true_scale * 1.1
	var R = rand_range(-T,T)
	R = Vector2(R,R)
	if tscale > true_scale+vari:
		tscale = (true_scale+vari)-R
	elif tscale < Vector2(1.0-vari.x,1.0-vari.y):
		tscale = (true_scale+vari)+R
	else:
		var c = randi()%5
		if c == 0:
			c = randi()%2
			if c == 0:
				tscale += R
			else: tscale -= R
	twinkle.set_scale(tscale)
	

func _on_Area2D_mouse_enter():
	get_parent().set_star_label_text(data.name, get_modulate())
	get_parent().set_star_label_pos(self)


func _on_Area2D_mouse_exit():
	get_parent().set_star_label_text("")


func _on_Selector_pressed():
	get_parent().show_world_info(self.data)


# Start twinkling when on-screen
func _on_Visibility_enter_screen():
	if !is_processing():
		set_process(true)

# Stop twinkling while off-screen
func _on_Visibility_exit_screen():
	if is_processing():
		set_process(false)
