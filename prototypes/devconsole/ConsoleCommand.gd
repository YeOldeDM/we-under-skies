
extends Node


const CMD_NOTFOUND = 0
const CMD_GET = 1
const CMD_SET = 2
const CMD_ERROR = 3
const CMD_SPECIAL = 4
const CMD_ANNOUNCE = 5

var Quacks = 0
# Process an incoming console command, and return a callback string.
# Input is a StringArray. First string calls a command (getter), second
# string acts as a modifier (setter)
func process_command( data ):
	if !data.size()<=0:
		if has_method(data[0]):
			if data.size() > 1:
				return call(data[0],data[1])
			elif data.size() == 1:
				return call(data[0])
		else:
			return ["No command found: "+data[0], CMD_NOTFOUND]
	return null


# Console Command Functions
# Name of function == console command
# all commands must be oneword & lowercase
# use snake_case for categories (ie r_fullscreen)
# mashcase for all others (ie regenworld)

func quit():
	get_tree().quit()

func consoleslide( value=null ):
	var console = get_node('/root/Main/Console')
	if !value:
		var V = console.SlideSpeed
		return ["Console slide rate is "+str(V), CMD_GET]
	else:
		if value.is_valid_integer():
			var V = int(value)
			console.SlideSpeed = clamp(V,0,256)
			return ["Console slide rate set to "+str(V), CMD_SET]

func fullscreen( value=null ):
	var fullscreen = OS.is_window_fullscreen()
	if !value:
		var status = 'OFF'
		if fullscreen:	status='ON'
		return ["Fullscreen mode is "+status, CMD_GET]
	else:
		if value.is_valid_integer():
			var V = int(value)
			if V == 0 and fullscreen:
				OS.set_window_fullscreen(false)
				return ["Fullscreen OFF", CMD_SET]
			elif V == 1 and !fullscreen:
				OS.set_window_fullscreen(true)
				return ["Fullscreen ON", CMD_SET]
			else:
				return ["No fullscreen mode: "+str(V), CMD_ERROR]

func help():
	var methods = get_method_list()
	var allmethods = get_node('/root/Main').get_method_list()
	var losers = []
	for m in allmethods:
		losers.append(m.name)
	for m in methods:
		if m.name in losers:
			methods.remove(methods.find(m))
			#print("KICKOUT "+m.name)
		if m.name == "process_command":
			methods.remove(methods.find(m))
	
	var text = "Valid Command List:\n\n"
	for m in methods:
		text += m.name+'\n'
	text += "\nEnd of Command List\n"
	return [text]

func quack():
	Quacks += 1
	return ["The Duck Has Quacked "+str(Quacks)+" times.",CMD_SPECIAL]

func timescale( value=null ):
	if !value:
		var V = OS.get_time_scale()
		return ["Time Scale is "+str(V), CMD_GET]
	else:
		if value.is_valid_float():
			var V = float(value)
			OS.set_time_scale(V)
			return ["Time Scale set to "+str(V), CMD_SET]

func say( text=null ):
	if text:
		return [text, CMD_ANNOUNCE]