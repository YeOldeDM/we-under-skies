
extends Node2D

var star

var world_space = [100,1024]
var y = 300

var distances = []

func _ready():
	randomize()
	star = StarGen.Star.new('Star',Vector2(0,0),50)
	print("Made Star")
	star.worlds = WorldGen.SolarSystem.new(star,3)
	print("Made Solar System")
	for i in range(star.worlds.age):
		star.worlds._iterate()
	draw_worlds()


func draw_worlds():
	for node in get_children():
		if node extends Label:
			node.queue_free()
	var distances = []
	var orbits = star.worlds.orbits
	for i in range(orbits.size()):
		var amt = orbits[i]
		var Q = i*1.0 / orbits.size()*1.0
		var x = lerp(world_space[0]+100,world_space[1],Q)
		distances.append([amt,x])
		var label = Label.new()
		add_child(label)
		var txt = ""
		for entry in amt:
			txt += entry+": "+str(amt[entry])+"\n"
		label.set_text(txt)
		label.set_pos(Vector2(x,y))
		
		#printt(i, amt)
	
	








func _on_Button_pressed():
	star.worlds._iterate()
	draw_worlds()
