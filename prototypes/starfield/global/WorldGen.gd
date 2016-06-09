
extends Node

var PlanetOrders = [
	'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
	'Q','R','S','T','U','V','W','X','Y','Z'
	]

class SolarSystem:
	var star
	var age
	
	var orbits = []
	
	func _init(star,age):
		self.star = star
		self.age = age
		_generate()
#		for i in range(self.age):
#			_iterate()
		
	func _generate():
		var base = self.star.lum
		var stardust = round(rand_range(10,100))
		stardust = int(base * stardust)
		var density = float(base)
		var distance = 0
		while stardust > 0:
			var dust = rand_range(density*2,density*3)*2
			var entry = {'dust':	int(dust)}
			var ice = rand_range(density,density*4)*2
			entry['ice'] = int(ice)
			var gas = rand_range(density,density*2)*2
			entry['gas'] = int(gas)
			var microbe_chance = randi()%5
			if microbe_chance <= 0:
				var microbes = rand_range(density/2,density)
				entry['microbes'] = int(microbes)
			distance += rand_range(20,50)+(density/4)
			entry['dist'] = int(distance)
			entry['heat'] = int((base*100) / distance)
			orbits.append(entry)
			stardust -= dust+ice



	func _iterate():
		for i in range(self.orbits.size()-1):
			var o = self.orbits[i]
			if i > 0:
				self._trade_material(o,orbits[i-1],'dust')
				self._trade_material(o,orbits[i-1],'ice')
				self._trade_material(o,orbits[i-1],'gas')
			if i < self.orbits.size()-1:
				self._trade_material(o,orbits[i+1],'dust')
				self._trade_material(o,orbits[i+1],'ice')
				self._trade_material(o,orbits[i+1],'gas')
			_spread_microbes(i)
			for mat in o:
				if o[mat] <= 0:
					self.orbits[i].erase(mat)

	func _trade_material(from, to, material):
		if material in from:
			if !material in to or from[material] < to[material]:
				var diff = from[material]/4
				from[material] -= diff
				if material in to:
					to[material] += diff
				else:	to[material] = diff
	
	func _spread_microbes(i):
		if 'microbes' in self.orbits[i]:
			var m = self.orbits[i]['microbes']
			var h = self.orbits[i]['heat']
			#kill microbes if too hot or cold
			if h > 90:
				m = 0
			elif h < 10:
				m = 0
			else:
				var deviation = abs(50-h)
				printt(deviation)
				var D = 0.4-(deviation*0.1)
				m += int(rand_range(100,300)*D)
			self.orbits[i]['microbes'] = m


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


