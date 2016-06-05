
extends Node

var StellarColors = {
	"O":	Color(0.2,0.2,0.8),
	"F":	Color(0.8,0.8,1.0),
	"K":	Color(0.8,0.5,0.0),
	"L":	Color(1.0,0.2,0.2)
	}

var min_bounds = Vector2(32,32)
var max_bounds = Vector2(1024-32,800-32)*4

class Star:
	var name
	var pos
	var lum
	
	var stellar_class
	var lumin_class
	
	var worlds
	
	func _init(name,pos,lum):
		self.name = name
		self.pos = pos
		self.lum = lum
	
	func get_distance_to(other_pos):
		return int((self.pos - other_pos).length())


var STAR_COUNT = 1200

var HYPERGIANTS = 0.005
var GIANTS = 0.025
var MAIN_SEQUENCE = 0.28
#var DWARVES = 0.61

func make_galaxy():
	
	# Find number of stars in each stellar class
	var HG = max(2,int(STAR_COUNT * HYPERGIANTS))
	var G = int(STAR_COUNT * GIANTS)
	var MS = int(STAR_COUNT * MAIN_SEQUENCE)
	var DW = STAR_COUNT - (HG + G + MS)
	
	print("\n making ",HG," Hypergiants")
	print("\n making ",G," Giants")
	print("\n making ",MS," MainSequence")
	print("\n making ",DW," Dwarves")
	# Container for stars made
	var made_stars = []

	#Start with the largest stars, and generate down
	for chunk in [[HG,'_make_hypergiant'],
					[G,'_make_giant'],
					[MS,'_make_mainsequence'],
					[DW,'_make_dwarf']]:
		_make_stars(made_stars,chunk[0],chunk[1])
	
	# Generate Worlds on each Star
	for star in made_stars:
		star.worlds = WorldGen.make_system(star)
	
	return made_stars

func _make_stars( made_stars, count, star_factory ):
	while count > 0:
		var tries = 5
		while tries > 0:
			var pos = _rpos()
			var new_star = call(star_factory,pos)
			new_star.name = skana.makeName(int(rand_range(1,3)),2,4)
			var made = true
			for star in made_stars:
				var D = star.get_distance_to(pos)
				var L = (star.lum + new_star.lum)*1.8
				if D < L:
					made = false
			if made:
				made_stars.append(new_star)
				tries = 0
			else: tries -= 1; 
		count -= 1


func _make_hypergiant(pos):
	var S = Star.new("Hypergiant",pos,round(rand_range(80,100)))
	S.stellar_class = "O"
	return S

func _make_giant(pos):
	var S = Star.new("Giant",pos,round(rand_range(40,60)))
	S.stellar_class = "F"
	if randf() < 0.07:
		S.stellar_class = "L"
	return S

func _make_mainsequence(pos):
	var S = Star.new("Main Sequence",pos,round(rand_range(15,39)))
	S.stellar_class = "K"
	return S

func _make_dwarf(pos):
	var S = Star.new("Dwarf",pos,round(rand_range(10,14)))
	S.stellar_class = "L"
	if randf() < 0.05:
		S.stellar_class = "F"
	return S





func _rpos():
	#return a random position within global bounds
	var x = round(rand_range(min_bounds.x,max_bounds.x))
	var y = round(rand_range(min_bounds.y,max_bounds.y))
	return Vector2(x,y)