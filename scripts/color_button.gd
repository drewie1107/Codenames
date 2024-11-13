extends Button

signal update_color

@export var label_setting: LabelSettings

var parent: Button

func _ready():
	parent = get_parent() # Connect signals automatically
	#print(parent.name)
	
	set_toggle_mode(true) # Make sure button is in toggle_mode
	
	# Top one doesn't work for some reason
	#self.connect(str(self.toggled),Callable(self,"_on_toggled")) 
	#self.connect("pressed",Callable(self,"_on_pressed"))
	
	# Connects update_color to parent method
	self.connect("pressed", Callable(parent,"_on_button_update_color").bind(label_setting))

#func _on_pressed():
	#print("emitted child button")
	#emit_signal("update_color",label_setting)
