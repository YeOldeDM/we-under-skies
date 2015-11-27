
extends Node

var star = preload('res://star.xml')

var SEED = ""

func _ready():
	gen_stars()
	
func gen_stars():
	for y in range(20):
		for x in range(20):
			make_star(x,y)
	print('-----------')
	
func make_star(x,y):
	var base = hash(SEED)
	var coord = hash(str(x,y))
	var S = hash(str(base,coord))
	print(S)
	seed(float(S))
	var r = randf(0.0,1.0)
	if r <= 0.3:
		var s = star.instance()
		var px = (x*10)+10
		var py = (y*10)+60
		s.set_pos(Vector2(px,py))
		get_node('Stars').add_child(s)

func _clear_stars():
	for s in get_node('Stars').get_children():
		s.queue_free()


func _on_LineEdit_text_changed( text ):
	SEED = text
	_clear_stars()
	gen_stars()
