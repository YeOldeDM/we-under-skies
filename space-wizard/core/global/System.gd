
extends Node

# SYSTEM - not to be confused with SolarSystem!


var IS_BUILDING = true
var BUILDS = 0		# number of times this scene has been run while IS_BUILDING

const PATH = 'res://core/system.cfg'

onready var _config = ConfigFile.new()

func _init_config():
	_config = ConfigFile.new()
	_build_config()
	save_config()

func _build_config():
	var c = _config
	c.set_value('DEV','IS_BUILDING',IS_BUILDING)
	print(BUILDS)
	c.set_value('DEV','BUILDS',BUILDS)

func _set_from_config():
	var c = _config
	IS_BUILDING = c.get_value('DEV','IS_BUILDING')
	BUILDS = c.get_value('DEV','BUILDS')
	
func save_config():
	_build_config()
	_config.save(PATH)

func load_config():
	var loaded = _config.load(PATH)
	if loaded == OK:
		_set_from_config()
	else:	OS.alert("no config file found!"+str(loaded))

