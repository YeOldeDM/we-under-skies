
extends Control

onready var bar = get_node('HUD/bar')
var thread = Thread.new()
var star_dat = []

var M = 50
var count = 0

func _load_starfield( path ):
	print("Loading..")
	var stars = load(path).instance()
	call_deferred("_load_done")
	return stars

func _load_done():
	var stars = thread.wait_to_finish()
	add_child(stars)
	get_node('Label').queue_free()
	print("Done!")


func _make_star( path ):
	var star = load(path).instance()
	call_deferred('_add_star')
	return star
	
func _add_star():
	var star = thread.wait_to_finish()
	star_dat.append(star)
	count += 1
	bar.set_value(count)
	if count < M:
		thread.start(self, '_make_star', 'res://star.xml')
	else:
		bar.queue_free()
		print("DONE!")

func _ready():
	if thread.is_active():
		return
	bar.set_max(M)
	bar.set_value(0)
	thread.start(self, '_make_star', 'res://star.xml')


