
extends Sprite



onready var label = get_node('Label')

func set_text( text ):
	assert text.is_valid_string()
	label.set_text(text)


