
extends Node

var children: Array

func _ready():
	children = get_children()

func _on_toggled(toggled_on):
	print("toggled parent button")
	for child in children:
		if child is Button:
			child.visible = !child.visible

func _on_button_update_color(color: LabelSettings):
	for child in children:
		if child is Label:
			child.set_label_settings(color)
