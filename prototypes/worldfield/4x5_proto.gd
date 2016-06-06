
extends Node

onready var tilemap = get_node('TileMap')

var Size = 64

var noise_map = []

func _ready():
	randomize()
	noise_map = _gen_noise(Size)
	for row in noise_map:
		var line = ''
		for col in row:
			line += str(col)+','
	draw_map()

func _gen_noise(size):
	var map = []
	for x in range(Size):
		var row = []
		for y in range(Size):
			var R = randi()%2
			row.append(R)
		map.append(row)
	return map

func _iterate(N=5):
	var change = []
	for x in range(Size):
		var row = []
		for y in range(Size):
			if noise_map[x][y] == 0:
				row.append(_find_tile(x,y,[1],N))
			elif noise_map[x][y] == 1:
				row.append(_find_tile(x,y,[0],N))
			elif noise_map[x][y] == 2:
				row.append(_find_tile(x,y,[1,0],N))
		change.append(row)
	
	for x in range(Size):
		for y in range(Size):
			if change[x][y]:
				if noise_map[x][y]==0:
					noise_map[x][y]=1
				elif noise_map[x][y]==1:
					noise_map[x][y]=0
				elif noise_map[x][y]==2:
					noise_map[x][y] = 1
	draw_map()

func _grow_water():
	var change = []
	for x in range(Size):
		var row = []
		for y in range(Size):
			if noise_map[x][y]==2:
				row.append(true)
			else: row.append(false)
		change.append(row)
	
	for X in range(Size):
		for Y in range(Size):
			if noise_map[X][Y] == 2:
				var neighbors = _find_neighbors(X,Y)
	
	for x in range(Size):
		for y in range(Size):
			if change[x][y] == true:
				noise_map[x][y] = 2
	draw_map()

func _find_neighbors(X,Y):
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
	for tile in neighbors:
		if tile.x < 0:
			tile.x = Size-1
		elif tile.x > Size-1:
			tile.x = 0
		if tile.y < 0:
			tile.y = Size-1
		elif tile.y > Size-1:
			tile.y = 0
	return neighbors

func _find_tile(X,Y,T,N):
	var walls = 0
	#find north neighbor
	var neighbors = _find_neighbors(X,Y)
	for tile in neighbors:
		if tile.x < 0:
			tile.x = Size-1
		elif tile.x > Size-1:
			tile.x = 0
		if tile.y < 0:
			tile.y = Size-1
		elif tile.y > Size-1:
			tile.y = 0
		if noise_map[tile.x][tile.y] in T:
			walls += 1
	if walls >= N:
		return true
	return false


func draw_map():
	for x in range(Size):
		for y in range(Size):
			tilemap.set_cell(x,y,noise_map[x][y])

func _on_Button_pressed():
	_iterate(5)


func _on_Button_2_pressed():
	_grow_water()
