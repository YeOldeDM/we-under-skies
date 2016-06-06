
extends TileMap

var Size = 128
var water = 0.5
var map

func generate():
	randomize()
	map = MapGen.generate_map(Size,0,water)
	_draw_map()


func _draw_map():
	for x in range(Size):
		for y in range(Size):
			if map[x][y] == 0:
				set_cell(x,y,2)
			else:
				set_cell(x,y,map[x][y])




func _on_IterateMap_pressed():
	MapGen._iterate(map,Size)
	_draw_map()
