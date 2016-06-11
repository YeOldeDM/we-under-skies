
extends Node2D

onready var starlabel = get_node('HUD/StarLabel')
onready var worldinfo = get_node('HUD/WorldInfo')

onready var camera = get_node('Camera/eyes')


var star_obj = preload('res://star.xml')



var SEED = randi()*randf()


var target
var target_targets = []

var starList = []

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
		var sc = S.data.get_lum_scale()
		S.set_scale(Vector2(sc,sc)*1.5)
		var color = StarGen.StellarColors[S.data.stellar_class]
		S.set_modulate(color)
		S.get_node('Twinkle/Haze').set_modulate(color)
		S.get_node('Twinkle/Haze').set_self_opacity((S.data.lum*0.01)*0.35)
		starList.append(S)
	#bring the seed out of the RNG
	randomize()	
	
	target = int(round(rand_range(0,starList.size()-1)))
	target = starList[target]
	for other_star in starList:
		if target.data.get_distance_to(other_star.data.pos) <= 200.0:
			target_targets.append(other_star)
	get_node('Camera').set_pos(Vector2(0,0))
	#update()

func set_star_label_text( text, color=Color(0,0,0) ):
	starlabel.set_text(text)
	color = color.linear_interpolate(Color('black'),0.4)
	starlabel.set('custom_colors/font_color_shadow',color)

func set_star_label_pos( pos ):
	var real_pos = get_viewport().get_mouse_pos()
	real_pos += Vector2(6,-16)
	starlabel.set_pos(real_pos)

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


#func _draw():
#	if target:
#		for t in target_targets:
#			draw_line(target.get_global_pos(),t.get_global_pos(),Color(0.5,0.5,1,0.4))