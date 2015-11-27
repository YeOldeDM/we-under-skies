
extends Sprite

var starName

var name
var lumin

var spectrals = [
	Color(1.0,0.3,0.3),	#red
	Color(1.0,0.4,0.2),	#orange
	Color(1.0,1.0,0.2),	#yellow
	Color(1.0,1.0,0.5),	#yellow-white
	Color(1.0,1.0,1.0),	#white
	Color(0.7,0.7,1.0),	#blue-white
	Color(0.4,0.4,1.0),	#blue
			]
	
func _ready():
	starName = get_node('/root/skana')
	
	var size = rand_range(0.1,0.7)
	if rand_range(0,1) < 0.01:
		size *= 2.0
	set_scale(Vector2(size+0.2,size+0.2))
	
	name = starName.makeName(int(rand_range(1,3)),2)
	lumin = round(size *100)
	set_color()
	set_process(true)

func _process(delta):
	var twink = rand_range(0.8,1.0)
	if randi() < 0.04:
		twink *= rand_range(2.0,15.0)
	get_node('twinkle').set_scale(Vector2(twink,twink))
	get_node('Sprite').set_scale(Vector2(8+(twink*2),8+(twink*1.5)))
	
func set_color():
	var l = lumin
	var color = clamp(int(l/10)-1,0,6)

	set_modulate(spectrals[color])
	get_node('Sprite').set_modulate(spectrals[color])


func _on_Area2D_mouse_enter():
	get_node('/root/Node/starname').set_text(name+" (L "+str(lumin)+")")
