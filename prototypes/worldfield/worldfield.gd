
extends Node2D

onready var map_layer = get_node('BG/MapLayer')
onready var worldmap = map_layer.get_node('TileMap')
onready var cloud_layer = get_node('BG/CloudLayer')
onready var cloudparts = cloud_layer.get_node('Clouds')
onready var orbit_layer = get_node('BG/OrbitLayer')

var Size = 128
var WaterCoverage = 0.5

func _ready():
	worldmap.Size = Size
	worldmap.water = WaterCoverage
	worldmap.generate()
	for i in range(10):
		worldmap._on_IterateMap_pressed()
	set_distance(0.25)

func set_distance(Distance=1.0):
	#Calculate scales for parallax mirroring
	var maplayer_size = Size*(32*Distance)
	var cloudlayer_size = maplayer_size*2
	
	#Adjust parallax to fit the map
	worldmap.set_scale(Vector2(Distance,Distance))
	map_layer.set_mirroring(Vector2(maplayer_size,maplayer_size))
	var sc = max(0.09, Distance*0.25)
	map_layer.set_motion_scale(Vector2(sc*0.5,sc*0.5))
	cloud_layer.set_motion_scale(Vector2(sc*1.5,sc*1.5))
	cloud_layer.set_mirroring(Vector2(cloudlayer_size,cloudlayer_size))
	cloudparts.set_emission_half_extents(Vector2(cloudlayer_size,cloudlayer_size))
	cloudparts.set_amount(min(maplayer_size/16,1024))
	