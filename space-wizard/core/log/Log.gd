
extends Tabs

onready var tree = get_node('Tree')
var root

func _ready():
	root = tree.create_item()
	root.set_text(0, "Discoveries")
	


