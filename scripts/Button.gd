
extends BaseButton

@export var current_color: String = "default"

var children: Array
var root_node: Node

var word_label: Label
var labels: Array[Label]
var buttons: Array[Button]

signal toggle_other_cards

func _ready():
	# Gets and classifies own children
	children = get_children()
	for child in children:
		if child is Label:
			labels.append(child)
		elif child is Button:
			buttons.append(child)
	word_label = labels[0]
	
	set_toggle_mode(true) # Make sure button is in toggle_mode
	self.connect("toggled",Callable(self,"_on_toggled"))
	
	root_node = get_tree().current_scene
	self.connect("toggle_other_cards",Callable(root_node,"_update_cards"))

func _on_toggled(toggled_on):
	#print("toggled parent button")
	emit_signal("toggle_other_cards",self.name)
	for button in buttons:
		button.visible = !button.visible
		button.button_pressed = false

func _update_buttons(color: String):
	current_color = color
	for button in buttons:
		button.visible = !button.visible
		button.button_pressed = false
