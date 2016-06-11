
extends Patch9Frame


# Handles the console UI
# Takes incoming commands,
# stores and handles cmd history,
# and writes output to the
# console terminal.


onready var output = get_node('box/out')
onready var input = get_node('box/in')
onready var clock = get_node('box/status/clock')
onready var version = get_node('box/status/version')
onready var toggle = get_node('box/status/toggle')


var SlideSpeed = 3
onready var height = -get_rect().size.height + 30

var active = false

var command_history = []
var history_steps = -1




# PUBLIC FUNCTIONS

func display_history(step):
	var txt = command_history[step]
	input.set_text(txt)
	input.set_cursor_pos(txt.length())

func write_output( text, style=null ):
	if style == ConsoleCommand.CMD_NOTFOUND:
		text = '[color=gray][i]'+text+'[/i][/color]'
	if style == ConsoleCommand.CMD_SET:
		text = '[color=cyan][b]'+text+'[/b][/color]'
	if style == ConsoleCommand.CMD_GET:
		text = '[color=yellow][b]'+text+'[/b][/color]'
	if style == ConsoleCommand.CMD_ERROR:
		text = '[color=red][b]'+text+'[/b][/color]'
	if style == ConsoleCommand.CMD_SPECIAL:
		text = '[color=fuchsia]'+text+'[/color]'
	if style == ConsoleCommand.CMD_ANNOUNCE:
		text = '[color=lime][b]'+text+'[/b][/color]'
	output.append_bbcode(text)


func parse_input( text ):
	# convert all text to lowercase and trim
	# any whitespace
	var str_list = text.to_lower().strip_edges()
	# split the line into an array of words
	str_list = str_list.split(" ")
	
	return str_list





# PRIVATE FUNCTIONS


func _ready():
	# Set console to up position
	set_pos(Vector2(0,height))
	
	# Connect Children signals
	input.connect("text_entered", self, "_on_in_text_entered")
	toggle.connect("toggled",self,"_on_toggle_toggled")
	get_node('tick').connect("timeout",self,"_tick")
	
	# follow the bottom line of text
	output.set_scroll_follow(true)
	output.clear()
	
	# enable input for toggle and history navigation
	set_process_input(true)
	
	
	# Send a welcome message
	for i in range(11):
		output.newline()
	write_output("Welcome to Space Wizard!!\n", ConsoleCommand.CMD_ANNOUNCE)
	
	# display game & build no.
	var check = File.new()
	if check.file_exists(Sys.CONFIGPATH):
		print("found config")
		Sys.load_config()
	else:
		print("making new config")
		Sys.init_config()
	check.close()
	
	# get build number from System
	if Sys.IS_BUILDING:
		Sys.BUILDS += 1
		print("Adding Build")
		Sys.save_config()
	version.set_text("Space Wizard build no. "+str(Sys.BUILDS))
	
	#tick the clock
	_tick()	
	
func _input(event):
	# Console button toggle ~
	if event.is_action_pressed('console'):
		if active:	
			active = false
			toggle.set_pressed(false)
		else:	
			active = true
			toggle.set_pressed(true)
			_tick()
		set_process(true)
	
	# Command history navigation
	if !command_history.empty():
		# go back one step in history
		if event.is_action_pressed('ui_up'):
			history_steps -= 1
			history_steps = max(0,history_steps)
			display_history(history_steps)
		# go forward one step in history
		if event.is_action_pressed('ui_down'):
			history_steps += 1
			history_steps = min(max(0,command_history.size()),history_steps)
			if history_steps == command_history.size():
				input.clear()
			else:
				display_history(history_steps)


# Process should only be active while the console
# is sliding up or down. Once it reaches its destination
# process is halted
func _process(delta):
	var y = get_pos().y
	var done = false
	if active:
		y += SlideSpeed
	else:
		y -= SlideSpeed
	set_pos(Vector2(0,y))
	if not active and y <= height:
		set_pos(Vector2(0,height))
		input.release_focus()
		done = true
	elif active and y >= 0:
		set_pos(Vector2(0,0))
		input.grab_focus()
		input.clear()
		done = true
	if done:
		set_process(false)



func _tick():
	# update clock
	var T = _get_date_and_time()
	clock.set_text(T)


func _get_date_and_time():
	# Get date info
	var date = OS.get_date()
	var Y = date['year']
	var M = date['month']
	var D = date['day']
	var txt = str(D)+"/"+str(M)+"/"+str(Y).right(2)
	# Get time info
	var time = OS.get_time()
	var AMPM = "AM"
	var H = time['hour']
	if H == 0:
		H = 12
	elif H > 12:
		AMPM = "PM"
		H = H-12
	var M = time['minute']
	var S = time['second']
	# Concatenate
	txt += " "+str(H)+":"+str(M)+":"+str(S)+" "+AMPM
	# return string
	return txt


	


func _on_in_text_entered( text ):
	if active:
		var str_list = parse_input(text)
		var callback = ConsoleCommand.process_command(str_list)
		if callback != null:
			var style = null
			if callback.size() > 1:	style = callback[1]
			write_output(callback[0],style)
			input.clear()
		output.newline()
		if text.strip_edges() != "":
			command_history.append(text)
		history_steps = command_history.size()

func _on_toggle_toggled( pressed ):
	if pressed:
		active = true
		
	else:
		active = false

	set_process(true)
