extends Button

signal update_color

@export var label_setting: LabelSettings

func _ready():
	pass

func _on_child_button_toggled(toggled_on):
	print("emitted child button")
	emit_signal("update_color",label_setting)
