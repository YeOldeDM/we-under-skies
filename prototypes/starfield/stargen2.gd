
extends Node

var star = preload('res://star.xml')
const SEED = 1.61803398875

const STAR_DENSITY = 0.032

var X = 0
var Y = 0

var chunkhash


func _ready():
	X = int(rand_range(-5000,5000))
	Y = int(rand_range(-5000,5000))
	get_node('/root/Node/Panel2/X').set_value(X)
	get_node('/root/Node/Panel2/Y').set_value(Y)
	gen_stars()
	set_process(true)

	
func gen_stars():
	clear_stars()
	seed(SEED+int(str(X,Y)))
	for y in range(32):
		for x in range(32):
			var coord = hash(str(x,y))
			#seed(float(SEED+coord))
			make_star(x,y)
	print('-----------')
	
	chunkhash = hash(str(X)+str(Y))
	
	get_node('/root/Node/chunk').set_text(str(chunkhash))

func make_star(x,y):
	var r = randf()

	if r <= STAR_DENSITY:
		var s = star.instance()
		var px = (x*20)+20 + int(rand_range(-5,5))
		var py = (y*20)+20 + int(rand_range(-5,5))
		s.set_pos(Vector2(px,py))
		get_node('Stars').add_child(s)

func clear_stars():
	for s in get_node('Stars').get_children():
		s.queue_free()

func _process(delta):
	if Input.is_action_pressed('reset'):
		clear_stars()
		gen_stars()

func _on_X_value_changed( value ):
	X = value
	gen_stars()

func _on_Y_value_changed( value ):
	Y = value
	gen_stars()