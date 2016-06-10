
extends Control

#############
#	MAIN	#
#############

# Root-level object of the game.
# Manages high-level system functions,
# and management of sub-scenes.

onready var console = get_node('Console')

func _ready():
	get_tree().set_auto_accept_quit(false)

func _notification( id ):
	if id == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		var pos = OS.get_window_position()
		pos.x += rand_range(-50,50)
		pos.y += rand_range(-50,50)
		OS.set_window_position(pos)

