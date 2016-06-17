
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
onready var stargenpop = get_node('GeneratorPopup')
onready var quitpop = get_node('QuitPopup')

# game screen tabs
onready var menu = core.get_node('Menu')
onready var galaxy = core.get_node('Galaxy')
onready var solarsys = core.get_node('StarSys')
onready var world = core.get_node('World')
onready var discoveries = core.get_node('Log')

# common game elements
onready var starspace = galaxy.get_node('Starfield/Worldspace/Space')
onready var worldspace = world.get_node('Worldfield/Worldspace')
onready var player = worldspace.get_node('Player')
onready var vignette = get_node('Vignette')


var Stars = []	# Array of Star class instances
var starthread = Thread.new()

var total_stars
var count = 0
var hg
var g
var ms
var d
# PRIVATE FUNCTIONS

func _generate_galaxy():
	seed(Sys.STAR_SEED)
	stargenpop.popup()
	var bar = stargenpop.get_node('box/ProgressBar')
	
	var radius = Sys.GALAXY_RADIUS
	var total = radius * Sys.STAR_DENSITY
	
	bar.set_max(total)
	bar.set_value(0)
	
	total_stars = total
	hg = total * Sys.GEN_HYPERGIANTS
	g = total * Sys.GEN_GIANTS
	ms = total * Sys.GEN_MAINSEQUENCE
	d = total - (hg+g+ms)
	
	if starthread.is_active():
		return
	else:
		starthread.start(self, '_make_star', 'hypergiant')



# Generate Star data and append successful generations
# to the Stars list.
func _make_star(factory):
	var star = StarGen.generate_star(Stars, factory)
	if star:
		Stars.append(star)
	call_deferred('_place_star')
	return star


# Place a star in starspace, based on a Star class instance.
func _place_star():
	var star = starthread.wait_to_finish()

	if star:
		var S = star_scn.instance()
		starspace.add_child(S)
		S.data = star
		S.Setup()

	var bar = stargenpop.get_node('box/ProgressBar')
	count += 1
	bar.set_value(count)
	stargenpop.set_self_opacity(1.0-((1.0*bar.get_value())/(1.0*bar.get_max())))
	
	if count <= hg:
		starthread.start(self,'_make_star','hypergiant')
	elif count <= g:
		starthread.start(self,'_make_star','giant')
	elif count <= ms:
		starthread.start(self,'_make_star','mainsequence')
	elif count <= d:
		starthread.start(self,'_make_star','dwarf')
	elif count <= total_stars:
		stargenpop.hide()
		


		



func _ready():
	# over-ride normal quit procedure
	get_tree().set_auto_accept_quit(false)
	# connect quit message OK response
	quitpop.connect("confirmed",self,"Quit")
	
	# Bring us to the initial Core tab
	show_galaxy()
	stargenpop.popup()
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


func _on_Generate_pressed():
	stargenpop.get_node('box/Generate').set_disabled(true)
	_generate_galaxy()
