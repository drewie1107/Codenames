extends Node2D

var _click_data: Array = []

var color = Color.WHITE
var thickness = 20
var filled = false
var size = Vector2(700,400)

func _input(event: InputEvent) -> void:
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		return
		
	_click_data.append({"position": get_local_mouse_position(), "color": color}) # Horrible
	queue_redraw()

func _draw() -> void:
	for data in _click_data:
		var position = data["position"]
		var color = data["color"]
		draw_circle(position, thickness, color)
		#draw_rect(Rect2(position - (size/2),size), color, filled,thickness)

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		color = Color.RED
		thickness = 20
	if Input.is_key_pressed(KEY_B):
		color = Color.BLUE
		thickness = 20
	if Input.is_key_pressed(KEY_W):
		color = Color.WHITE
		thickness = 20
	if Input.is_key_pressed(KEY_L):
		color = Color.BLACK
		thickness = 20
	if Input.is_key_pressed(KEY_E):
		#color = Color.TRANSPARENT
		#thickness = 60
		_click_data.clear()
		queue_redraw()
	
