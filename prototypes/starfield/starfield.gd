
extends Node2D

onready var starlabel = get_node('StarLabel')
onready var worldinfo = get_node('WorldInfo')


var star_obj = preload('res://star.xml')



var SEED = randi()*randf()

func _ready():
	randomize()
	# Define the almighty SEED
	#seed(SEED)
	
	# Generate star data
	var stars = StarGen.make_galaxy()
	print(stars.size(),' STARS\n')
	
	# Generate star objects
	for star in stars:
		var S = star_obj.instance()
		add_child(S)
		S.data = star
		S.set_pos(S.data.pos)
		var sc = S.data.lum*0.02
		S.set_scale(Vector2(sc,sc)*2)
		var color = StarGen.StellarColors[S.data.stellar_class]
		S.set_modulate(color)
		S.get_node('Haze').set_modulate(color)
		S.get_node('Haze').set_self_opacity((S.data.lum*0.01)/4)
	
	#bring the seed out of the RNG
	randomize()	


func set_star_label_text( text, color=Color("black") ):
	starlabel.set_text(text)
	color = color.linear_interpolate(Color('black'),0.4)
	starlabel.set('custom_colors/font_color_shadow',color)

func set_star_label_pos( pos ):
	pos.x = min(StarGen.max_bounds.x-64, pos.x)
	pos += Vector2(8,-16)
	starlabel.set_pos(pos)
	starlabel.raise()

func show_world_info( star ):
	worldinfo.clear()
	if !star.worlds.empty():
		for world in star.worlds:
			var name = world.name
			var order = str(world.order)
			var size = str(world.size)
			var dist = str(world.distance)
			worldinfo.append_bbcode(order+"  "+name+"  Size "+size+"   Dist. "+dist)
			worldinfo.newline()
	else: worldinfo.append_bbcode("No Worlds")
	worldinfo.raise()