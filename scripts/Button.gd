
extends Node
'''
#Colors for buttons
var colors = [
	Color(1, 1, 1),   # White
	Color(1, 0, 0),   # Red
	Color(0, 0, 0),   # Black
	Color(0, 0, 1)    # Blue
]
var current_color_index = 0

func _on_toggled(toggled_on):
	current_color_index = (current_color_index + 1) % colors.size()
	self.modulate = colors[current_color_index]
'''
