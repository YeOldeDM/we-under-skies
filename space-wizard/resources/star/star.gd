
extends Sprite

onready var main = get_node('/root/Main')

onready var twinkle = get_node('Twinkle')

var data

var tw_time = (randi()%60)+20



func _twinkle():
	var s = twinkle.get_scale()
	var tscale = 0.5
	var vari = tscale * 0.3
	var R = rand_range(-0.008,0.008)
	
	if s.x >= vari+R:
		R = vari-R
	elif s.x <= -vari-R:
		R = -vari+R
	else: var c = randi()%2
		if c==0:	R = s.x+R
		else:	R = s.x-R
		
	R = Vector2(R+0.5,R+0.5)
	twinkle.set_scale(R)

func _process(delta):
	if tw_time <= 0:
		tw_time = (randi()%60)+20
		_twinkle()
		return
	tw_time -= 1

func _input(event):
	print("SEF")
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == 1 and event.pressed:
			print("Selecting ")
		

func _on_Area2D_mouse_enter():
	print("SADFA")
	set_process_input(true)


func _on_Area2D_mouse_exit():
	set_process_input(false)


func _on_Selector_pressed():
	print('askdje')
	main.starspace.select_star(self)


# Start twinkling when on-screen
func _on_Visibility_enter_screen():
	if !is_processing():
		set_process(true)

# Stop twinkling while off-screen
func _on_Visibility_exit_screen():
	if is_processing():
		set_process(false)


func Setup():
	assert data != null
	set_pos(data.pos)
	var sc = data.get_lum_scale()
	set_scale(Vector2(sc*2,sc*2))
	var C = StarGen.StellarColors[data.stellar_class]
	set_modulate(C)
	twinkle.get_node('Haze').set_modulate(C)
	twinkle.set_opacity(data.get_lum_scale()*0.2)
	set_process(true)
	set_rotd(rand_range(0,360))
	
	get_node('Area2D').set_scale(Vector2(1,1))
	

