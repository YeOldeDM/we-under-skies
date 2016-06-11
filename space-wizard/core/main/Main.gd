
extends Control

#############
#	MAIN	#
#############

# Root-level object of the game.
# Manages high-level system functions,
# and management of sub-scenes.

onready var console = get_node('Console')
onready var quitpop = get_node('QuitPopup')

func _ready():
	# over-ride normal quit procedure
	get_tree().set_auto_accept_quit(false)
	quitpop.connect("confirmed",self,"Quit")

func _notification( id ):
	# Raise a confirmation dialog on window close request
	if id == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		quitpop.raise()
		quitpop.popup()


# save my configfile and quit the game
func Quit():
	Sys.save_config()
	get_tree().quit()
