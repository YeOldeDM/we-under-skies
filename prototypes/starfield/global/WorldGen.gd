
extends Node

var PlanetOrders = [
	'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
	'Q','R','S','T','U','V','W','X','Y','Z'
	]

class World:
	var name
	var parent		# parent star
	var order		# which order the World is in the system (Earth is order 3)
	var distance	# distance from parent star
	var size		# world Size (colonizable surface)
	
	var geosphere
	var hydrosphere
	var atmosphere
	var biosphere
	
	func _init(name,parent,order,distance,size):
		self.name = name
		self.parent = parent
		self.order = order
		self.distance = distance
		self.size = size


func make_world( parent, order, distance ):
	var name = parent.name + " " + PlanetOrders[order]
	var size = int(round(rand_range(2,100)))
	return World.new(name,parent,order,distance,size)

func make_system( parent ):
	var worlds = []
	var orbits = int(round(rand_range(0,8)))
	var distance = parent.lum
	for i in range(orbits):
		var new_world = make_world(parent,i,int(distance))
		worlds.append(new_world)
		distance += parent.lum * (0.1*(i+2))
	return worlds


