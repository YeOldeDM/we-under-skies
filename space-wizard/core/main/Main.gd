
extends Control

#############
#	MAIN	#
#############

# Root-level object of the game.
# Manages high-level system functions,
# and management of sub-scenes.

# children
onready var core = get_node('Core')
onready var console = get_node('Console')
onready var quitpop = get_node('QuitPopup')

onready var menu = core.get_node('Menu')
onready var galaxy = core.get_node('Galaxy')
onready var solarsys = core.get_node('SolarSystem')
onready var world = core.get_node('World')



# PRIVATE FUNCTIONS

func _ready():
	# over-ride normal quit procedure
	get_tree().set_auto_accept_quit(false)
	quitpop.connect("confirmed",self,"Quit")


func _notification( id ):
	# Raise a confirmation dialog on window close request
	if id == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		quitpop.raise()
		quitpop.popup()



# PUBLIC FUNCTIONS

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
