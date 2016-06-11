
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
	get_tree().set_auto_accept_quit(false)

func _notification( id ):
	if id == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		quitpop.popup()


func _on_QuitPopup_confirmed():
	Sys.save_config()
	get_tree().quit()
