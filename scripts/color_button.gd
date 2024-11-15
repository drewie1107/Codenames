extends Button

@export var label_setting: LabelSettings

var parent: Button
var root_node: Node

func _ready():
	root_node = get_tree().current_scene
	parent = get_parent() # Connect signals automatically
	
	var node_name: String = self.name.to_lower()
	var button_color: String
	
	if "red" in node_name: button_color = "red"
	if "blue" in node_name: button_color = "blue"
	if "white" in node_name: button_color = "white"
	if "black" in node_name: button_color = "black"
	if "erase" in node_name: button_color = "erase"
	
	set_toggle_mode(true) # Make sure button is in toggle_mode
	
	# Connects "pressed" signal to parent method to update color and root method to update score
	self.connect("pressed", Callable(parent,"_on_button_update_color",).bind(label_setting))
	self.connect("pressed", Callable(root_node,"_update_score"))
