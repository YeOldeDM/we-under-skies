
extends Node

var path = 'starnames_raw.txt'

func _ready():
	var file = File.new()
	if file.file_exists(path):
		file.open(path, File.READ)
		
		var list = []
		while !file.eof_reached():
			list.append(file.get_line())
		
		file.close()
		print("Got "+str(list.size())+" names!!!")
		
		var new = ConfigFile.new()
		new.set_value('STARS', 'names', list)
		new.save('res://starnames.ini')

	else:
		OS.alert("BAD PATH OR FILE")
		get_tree().quit()


