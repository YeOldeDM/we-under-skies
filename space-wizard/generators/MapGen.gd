
extends Node



func generate_map(size, generations, water_level):
	var map = _gen_noise(size, water_level)
	for i in range(generations):
		_iterate(map,size)
	return map

func _gen_noise(size, water_level):
	var map = []
	for x in range(size):
		var row = []
		for y in range(size):
			var R = randf()
			if water_level >= R:
				row.append(0)
			else:
				row.append(1)
		map.append(row)
	return map

func _iterate(noise_map, size, N=5):
	var change = []
	for x in range(size):
		var row = []
		for y in range(size):
			if noise_map[x][y] == 0:
				row.append(_smooth_tile(noise_map,x,y,[1],N,size))
			elif noise_map[x][y] == 1:
				row.append(_smooth_tile(noise_map,x,y,[0],N,size))
		change.append(row)
	
	for x in range(size):
		for y in range(size):
			if change[x][y]:
				if noise_map[x][y]==0:
					noise_map[x][y]=1
				elif noise_map[x][y]==1:
					noise_map[x][y]=0

func _find_neighbors(X, Y, size):
	var neighbors = [
		Vector2(X,Y-1),
		Vector2(X+1,Y-1),
		Vector2(X+1,Y),
		Vector2(X+1,Y+1),
		Vector2(X,Y+1),
		Vector2(X-1,Y+1),
		Vector2(X-1,Y),
		Vector2(X-1,Y-1)
		]

	for i in range(neighbors.size()):
		if neighbors[i].x < 0:
			neighbors[i].x = size-1
		if neighbors[i].x > size-1:
			neighbors[i].x = 0
		if neighbors[i].y < 0:
			neighbors[i].y = size-1
		if neighbors[i].y > size-1:
			neighbors[i].y = 0

	return neighbors

# Examine tile XY's neighbors for tile T,
# If N or higher neighbors T, return True
func _smooth_tile(noise_map,X,Y,T,N, size):
	var walls = 0
	var neighbors = _find_neighbors(X,Y,size)
	for tile in neighbors:
		if noise_map[tile.x][tile.y] in T:
			walls += 1
	if walls >= N:
		return true
	return false
