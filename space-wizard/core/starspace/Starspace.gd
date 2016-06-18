
extends Viewport

# Main
onready var main = get_node('/root/Main')

# Update Panel
onready var updater = main.get_node('UpdatePop')

# children
onready var star_parent = get_node('Space')



# instancers
var star_scn = preload('res://resources/star/Star.tscn')

# Array of Star class instances (bound to Star objects)
var Stars = []


# GALAXY GENERATION STUFF
var thread = Thread.new()

var total_stars
var count = 0
var hg
var g
var ms
var d

# Galaxy Big-Bootsrapper
func generate_galaxy():
	# Set Seed
	seed(Sys.STAR_SEED)
	# Updater stuff
	updater.set_opacity(1.0)
	var bar = updater.get_node('box/ProgressBar')
	var txt = updater.get_node('box/Title')
	
	# get values from Sys data
	var radius = Sys.GALAXY_RADIUS
	var total = radius * Sys.STAR_DENSITY
	# init progBar
	txt.set_text('Generating Galaxy...')
	bar.set_max(total)
	bar.set_value(0)
	# Calc total stars and numbers of each class
	total_stars = total
	hg = total * Sys.GEN_HYPERGIANTS
	g = total * Sys.GEN_GIANTS
	ms = total * Sys.GEN_MAINSEQUENCE
	d = total - (hg+g+ms)
	
	# Start making the first star, if Thread is free
	if thread.is_active():
		return null
	else:
		thread.start(self, '_make_star', 'hypergiant')



# Generate Star data and append successful generations
# to the Stars list.
func _make_star(factory):
	var star = StarGen.generate_star(Stars, factory)
	if star:
		Stars.append(star)
	call_deferred('_place_star')
	return star


# Place a star in starspace, based on a Star class instance.
# Deferred by _make_star
func _place_star():
	# incoming from Thread
	var star = thread.wait_to_finish()
	# place the star if thread gets data
	if star:
		var S = star_scn.instance()
		star_parent.add_child(S)
		S.data = star # Bind Star class to object
		S.Setup()	# Set star's size/color/etc from data
	
	# Update the update panel
	var bar = updater.get_node('box/ProgressBar')
	count += 1
	bar.set_value(count)
	updater.set_opacity(1.0-((1.0*bar.get_value())/(1.0*bar.get_max())))
	
	# Keep pumping out stars, large to small, until it hits the total
	if count <= hg:
		thread.start(self,'_make_star','hypergiant')
	elif count <= g:
		thread.start(self,'_make_star','giant')
	elif count <= ms:
		thread.start(self,'_make_star','mainsequence')
	elif count <= d:
		thread.start(self,'_make_star','dwarf')
	elif count <= total_stars:
		updater.hide()


# Select a Star in the Galaxy
func select_star(star):
	print(star.data.name)


# It Presses the Generate Button
func _on_Generate_pressed():
	updater.get_node('box/Generate').set_disabled(true)
	var gal = generate_galaxy()
