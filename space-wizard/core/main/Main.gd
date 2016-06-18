
extends Control

#############
#	MAIN	#
#############

# Root-level object of the game.
# Manages high-level system functions,
# and management of sub-scenes.

const TAB_MENU = 0
const TAB_GALAXY = 1
const TAB_SOLARSYSTEM = 2
const TAB_WORLD = 3
const TAB_LOG = 4

# scene references
var star_scn = preload('res://resources/star/Star.tscn')


# children
onready var core = get_node('Core')
onready var console = get_node('Console')
onready var quitpop = get_node('QuitPopup')

# game screen tabs
onready var menu = core.get_node('Menu')
onready var galaxy = core.get_node('Galaxy')
onready var solarsys = core.get_node('StarSys')
onready var world = core.get_node('World')
onready var discoveries = core.get_node('Log')

# Game Spaces
onready var starspace = galaxy.get_node('Starfield/Starspace')
onready var worldspace = world.get_node('Worldfield/Worldspace')

# common game elements
onready var player = worldspace.get_node('Player')
onready var vignette = get_node('Vignette')



func _ready():
	# over-ride normal quit procedure
	get_tree().set_auto_accept_quit(false)
	# connect quit message OK response
	quitpop.connect("confirmed",self,"Quit")
	
	# Bring us to the initial Core tab
	show_galaxy()
	starspace.updater.popup()
	#_generate_galaxy()


func _notification( id ):
	# Raise a confirmation dialog on window close request
	if id == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		quitpop.popup()
		quitpop.raise()



# PUBLIC FUNCTIONS

func is_console_active():
	return console.active

# Show core game screens
func show_menu():
	core.set_current_tab(0)

func show_galaxy():
	core.set_current_tab(1)

func show_system():
	core.set_current_tab(2)

func show_world():
	core.set_current_tab(3)

# save my configfile and quit the game
func Quit():
	Sys.save_config()
	get_tree().quit()



