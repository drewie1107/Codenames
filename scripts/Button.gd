
extends BaseButton

var current_color: String = "default"

var children: Array
var root_node: Node

var word_label: Label
var labels: Array[Label]
var buttons: Array[Button]

var default_label: LabelSettings

signal toggle_other_cards

func _ready():
	children = get_children()
	root_node = get_tree().current_scene
	
	for child in children:
		if child is Label:
			default_label = child.get_label_settings()
			labels.append(child)
		elif child is Button:
			buttons.append(child)
	word_label = labels[0]
	
	set_toggle_mode(true) # Make sure button is in toggle_mode
	#self.connect(str(self.toggled),Callable(self,"_on_toggled"))
	self.connect("toggled",Callable(self,"_on_toggled"))
	self.connect("toggle_other_cards",Callable(root_node,"_update_cards"))

func _on_toggled(toggled_on):
	#print("toggled parent button")
	emit_signal("toggle_other_cards",self.name)
	for button in buttons:
		button.visible = !button.visible

func _update_button(color: String):
	current_color = color
	for button in buttons:
		button.visible = !button.visible
		button.button_pressed = false

#func _on_button_apply_card(card: String = "erase"):
	#if card = "red":
		#
	#var random_index: int = randi() % red_cards.size()
	#red_cards[random_index].visible = !red_cards[random_index].visible
