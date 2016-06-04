
extends Node

var StellarColors = {
	"O":	Color(0.2,0.2,0.8),
	"F":	Color(0.8,0.8,1.0),
	"K":	Color(0.8,0.5,0.0),
	"L":	Color(1.0,0.2,0.2)
	}

var min_bounds = Vector2(32,32)
var max_bounds = Vector2(1024-32,800-32)

class Star:
	var name
	var pos
	var lum
	var stellar_class
	var lumin_class
	
	func _init(name,pos,lum):
		self.name = name
		self.pos = pos
		self.lum = lum
	
	func get_distance_to(other_pos):
		return int((self.pos - other_pos).length())


var STAR_COUNT = 250

var HYPERGIANTS = 0.005
var GIANTS = 0.075
var MAIN_SEQUENCE = 0.23
var DWARVES = 0.61

func make_galaxy():
	
	# Find number of stars in each stellar class
	var HG = max(1,int(STAR_COUNT * HYPERGIANTS))
	var G = int(STAR_COUNT * GIANTS)
	var MS = int(STAR_COUNT * MAIN_SEQUENCE)
	var DW = STAR_COUNT - (HG + G + MS)
	
	print("\n making ",HG," Hypergiants")
	print("\n making ",G," Giants")
	print("\n making ",MS," MainSequence")
	print("\n making ",DW," Dwarves")
	# Container for stars made
	var made_stars = []
	var gen_tries = 10
	#Start with the largest stars, and generate down
	var tries
	while HG > 0:
		tries = gen_tries
		while tries > 0:
			var pos = _rpos()
			var new_star = _make_hypergiant(pos)
			var made = true
			for star in made_stars:
				var D = star.get_distance_to(pos)
				var L = (star.lum + new_star.lum)*0.75
				printt(D,L)
				if D < L:
					made = false
					print("rejected pos ",pos)
			if made:
				made_stars.append(new_star)
				print("ADDED HYPERGIANT")
				tries = 0
			else: tries -= 1
		HG -= 1
	
	
	while G > 0:
		tries = gen_tries
		while tries > 0:
			print(tries)
			var pos = _rpos()
			var new_star = _make_giant(pos)
			var made = true
			for star in made_stars:
				var D = star.get_distance_to(pos)
				var L = (star.lum + new_star.lum)*0.75
				printt(D,L)
				if D < L:
					made = false
					print("rejected pos ",pos)
			if made:
				made_stars.append(new_star)
				print("ADDED GIANT")
				tries = 0
			else: tries -= 1; 
		G -= 1

	
	while MS > 0:
		tries = gen_tries
		while tries > 0:
			var pos = _rpos()
			var new_star = _make_mainsequence(pos)
			var made = true
			for star in made_stars:
				var D = star.get_distance_to(pos)
				var L = (star.lum + new_star.lum)*0.75
				printt(D,L)
				if D < L:
					made = false
					print("rejected pos ",pos)
			if made:
				made_stars.append(new_star)
				print("ADDED MAINSEQUENCE")
				tries = 0
			else: tries -= 1; 
		MS -= 1

	
	while DW > 0:
		tries = gen_tries
		while tries > 0:
			var pos = _rpos()
			var new_star = _make_dwarf(pos)
			var made = true
			for star in made_stars:
				var D = star.get_distance_to(pos)
				var L = (star.lum + new_star.lum)*0.75
				printt(D,L)
				if D < L:
					made = false
					print("rejected pos ",pos)
			if made:
				made_stars.append(new_star)
				print("ADDED DWARF")
				tries = 0
			else: tries -= 1; 
		DW -= 1

	return made_stars

func _make_hypergiant(pos):
	var S = Star.new("Hypergiant",pos,round(rand_range(80,100)))
	S.stellar_class = "O"
	print("Made a Hypergiant")
	return S

func _make_giant(pos):
	var S = Star.new("Giant",pos,round(rand_range(40,60)))
	S.stellar_class = "F"
	if randf() < 0.05:
		S.stellar_class = "L"
	print("Made a Giant")
	return S

func _make_mainsequence(pos):
	var S = Star.new("Main Sequence",pos,round(rand_range(15,39)))
	S.stellar_class = "K"
	print("Made a Main Sequence")
	return S

func _make_dwarf(pos):
	var S = Star.new("Dwarf",pos,round(rand_range(10,14)))
	S.stellar_class = "L"
	if randf() < 0.05:
		S.stellar_class = "F"
	print("Made a Dwarf")
	return S





func _rpos():
	#return a random position within global bounds
	var x = round(rand_range(min_bounds.x,max_bounds.x))
	var y = round(rand_range(min_bounds.y,max_bounds.y))
	return Vector2(x,y)