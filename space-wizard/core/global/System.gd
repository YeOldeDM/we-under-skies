
extends Node

# SYSTEM - not to be confused with SolarSystem!


# CONSTANTS
# Stellar classes
const STAR_HYPERGIANT = 0
const STAR_GIANT = 1
const STAR_MAINSEQUENCE = 2
const STAR_DWARF = 3

# CONFIGPATH to system.cfg file
const CONFIGPATH = 'res://core/system.cfg'




# PARAMETERS

# is we keeping track of builds?
# (disable for public build)
var IS_BUILDING = true
# number of times this scene has been run while IS_BUILDING
var BUILDS = 0		

# StarGen Parameters
var STAR_SEED = 0.0
var STAR_DENSITY = 1.2
var GALAXY_RADIUS = 512
# % of each class of star to appear
# (dwarves will make up the remainder)
var GEN_HYPERGIANTS = 0.005
var GEN_GIANTS = 0.011
var GEN_MAINSEQUENCE = 0.28


# my working config object
onready var _config = ConfigFile.new()







# PRIVATE FUNCTIONS

# set values to the configfile based
# on my members
func _build_config():
	var c = _config
	# set DEV settings
	c.set_value('DEV','IS_BUILDING',IS_BUILDING)
	c.set_value('DEV','BUILDS',BUILDS)
	# set STARGEN settings
	c.set_value('STARGEN','SEED', STAR_SEED)
	c.set_value('STARGEN','SIZE', GALAXY_RADIUS)
	c.set_value('STARGEN','DENSITY', STAR_DENSITY)
	c.set_value('STARGEN','HYPERGIANTS', GEN_HYPERGIANTS)
	c.set_value('STARGEN','GIANTS', GEN_GIANTS)
	c.set_value('STARGEN','MAINSEQUENCE', GEN_MAINSEQUENCE)
	

# set my members to those of the configfile
func _set_from_config():
	var c = _config
	# set DEV settings
	IS_BUILDING = c.get_value('DEV','IS_BUILDING')
	BUILDS = c.get_value('DEV','BUILDS')
	# set STARGEN settings
	STAR_SEED = c.get_value('STARGEN','SEED')
	GALAXY_RADIUS = c.get_value('STARGEN','SIZE')
	STAR_DENSITY = c.get_value('STARGEN','DENSITY')
	
	GEN_HYPERGIANTS = c.get_value('STARGEN','HYPERGIANTS')
	GEN_GIANTS = c.get_value('STARGEN','GIANTS')
	GEN_MAINSEQUENCE = c.get_value('STARGEN','MAINSEQUENCE')







# PUBLIC FUNCTIONS

# build a fresh system.cfg file
# (for when none exists)
func init_config():
	_config = ConfigFile.new()
	_build_config()
	save_config()

# build config and save file
func save_config():
	_build_config()
	_config.save(CONFIGPATH)

# load from file and set my values
func load_config():
	var loaded = _config.load(CONFIGPATH)
	if loaded == OK:
		_set_from_config()
	else:	OS.alert("no config file found!"+str(loaded))

