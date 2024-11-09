
extends Node2D
'''
func _input(event: InputEvent) -> void:
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
		
	_click_pos.append(get_local_mouse_position())
	queue_redraw()

func _draw() -> void:
	for point in _click_pos:
		draw_circle(point, 10, color)

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		color = Color.RED
	if Input.is_key_pressed(KEY_B):
		color = Color.BLUE
	if Input.is_key_pressed(KEY_W):
		color = Color.WHITE
	if Input.is_key_pressed(KEY_B):
		color = Color.BLACK
'''
