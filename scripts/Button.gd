
extends BaseButton

var children: Array
var root_node: Node

signal update_map

func _ready():
	children = get_children()
	root_node = get_tree().current_scene
	
	set_toggle_mode(true) # Make sure button is in toggle_mode
	#self.connect(str(self.toggled),Callable(self,"_on_toggled"))
	self.connect("toggled",Callable(self,"_on_toggled"))
	self.connect("update_map",Callable(root_node,"_update_cards"))

func _on_toggled(toggled_on):
	#print("toggled parent button")
	emit_signal("update_map",self)
	for child in children:
		if child is Button:
			child.visible = !child.visible

func _on_button_update_color(color: LabelSettings):
	for child in children:
		if child is Label:
			child.set_label_settings(color)
		else:
			child.visible = !child.visible
