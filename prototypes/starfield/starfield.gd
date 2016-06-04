
extends Node2D

var star_obj = preload('res://star.xml')

var SEED = PI*randi()

func _ready():
	randomize()
	var stars = StarGen.make_galaxy()
	print(stars.size(),' STARS\n')
	for star in stars:
		var S = star_obj.instance()
		add_child(S)
		S.data = star
		S.set_pos(S.data.pos)
		var sc = S.data.lum*0.02
		S.set_scale(Vector2(sc,sc))
		var color = StarGen.StellarColors[S.data.stellar_class]
		S.set_modulate(color)
		S.get_node('Haze').set_modulate(color)
		S.data.name = skana.makeName(int(rand_range(1,3)),2,4)
		print(S.data.name)
	


