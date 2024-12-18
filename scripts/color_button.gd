extends Button

var parent: Button
var root_node: Node

var all_cards: Array[Sprite2D]
@export var button_cards: Array[Sprite2D]
var random_card: Sprite2D

var color: String

func _ready():
	root_node = get_tree().current_scene
	parent = get_parent() # Connect signals automatically
	
	var node_name: String = self.name.to_lower()
	if "red" in node_name: color = "red"
	if "blue" in node_name: color = "blue"
	if "white" in node_name: color = "white"
	if "black" in node_name: color = "black"
	if "erase" in node_name: color = "default"
	
	for child in parent.get_children():
		if child is Sprite2D:
			all_cards.append(child)
	
	set_toggle_mode(true) # Make sure button is in toggle_mode
	
	# Connects "pressed" signal to parent method to update color and root method to update score
	self.connect("pressed", Callable(self,"_select_card"))
	self.connect("pressed", Callable(parent,"_update_buttons",).bind(color))
	#self.connect("pressed", Callable(parent,"_on_button_apply_card").bind())
	self.connect("pressed", Callable(root_node,"_update_score"))
	
func _select_card():
	for card in all_cards:
		if card.is_visible(): card.set_visible(false)
	if button_cards.size() != 0:
		random_card = button_cards[randi() % button_cards.size()]
		random_card.set_visible(true)
