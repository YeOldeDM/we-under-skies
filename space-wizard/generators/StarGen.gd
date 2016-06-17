
extends Node

const STAR_TRIES = 5	# number of tries to generate a star
						# before giving up

# Colors by luminocity class
var StellarColors = {
	"O":	Color(0.2,0.2,0.8),
	"F":	Color(0.8,0.8,1.0),
	"K":	Color(0.8,0.5,0.0),
	"L":	Color(1.0,0.2,0.2)
	}


# Star Class
class Star:
	var name
	var pos
	var lum
	
	var stellar_class
	var lumin_class
	
	var worlds
	
	# Init
	func _init(name,pos,lum):
		self.name = name
		self.pos = pos
		self.lum = lum
	
	# find distance to another star
	func get_distance_to(other_star):
		return (self.pos - other_star.pos).length()

	func get_lum_scale():
		return self.lum*0.02





# Generator functions

# get random values
func _rand( radius ):
	return int(round(rand_range(-radius,radius)))

# get random vectors (star positions)
func _get_random_pos( radius ):
	var vector = Vector2(_rand(radius),_rand(radius))
	#if vector.length() > radius:
		#return null
	return vector



# Return a procedural Star class instance, or null
func generate_star( star_list, factory ):
	var tries = 0
	var R = Sys.GALAXY_RADIUS
	# Make a star at a position, test it against 
	# existing stars. Move on to the next star if
	# a valid position is not found after x number
	# of attempts.
	while tries < STAR_TRIES:
		var pos = _get_random_pos(R)
		assert has_method(factory)
		var star = call(factory, pos)
		var valid = true
		# check against other stars
		if not star_list.empty():
			for other_star in star_list:
				var D = star.get_distance_to(other_star)
				var L = (star.lum + other_star.lum)*((1.0/Sys.STAR_DENSITY))
				if D < L:
					valid = false
		if valid:
			return star
		else:
			tries += 1
	# return null if we run out of tries
	return null


# Star Factories
func hypergiant(pos):
	var S = Star.new(NameGen.MakeName(),pos,round(rand_range(80,100)))
	S.stellar_class = "O"
	return S

func giant(pos):
	var S = Star.new(NameGen.MakeName(),pos,round(rand_range(40,60)))
	S.stellar_class = "F"
	if randf() < 0.07:
		S.stellar_class = "L"
	return S

func mainsequence(pos):
	var S = Star.new(NameGen.MakeName(),pos,round(rand_range(15,39)))
	S.stellar_class = "K"
	return S

func dwarf(pos):
	var S = Star.new(NameGen.MakeName(),pos,round(rand_range(10,14)))
	S.stellar_class = "L"
	if randf() < 0.05:
		S.stellar_class = "F"
	return S