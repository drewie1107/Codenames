extends Node2D

@export var disable: bool = false

var _click_data: Array = []

var color = Color.WHITE
var thickness = 20
var filled = false
var size = Vector2(700,400)

signal whos_on_first

func _ready():
	connect("whos_on_first", Callable(get_parent(),"_update_score"))

func _input(event: InputEvent) -> void:
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or disable:
		return
		
	_click_data.append({"position": get_local_mouse_position(), "color": color}) # Horrible
	queue_redraw()
	print("running")

func _draw() -> void:
	for data in _click_data:
		var position = data["position"]
		var color = data["color"]
		draw_circle(position, thickness, color)
		#draw_rect(Rect2(position - (size/2),size), color, filled,thickness)

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		get_parent().red_team_first = true
		whos_on_first.emit()
		color = Color.RED
		thickness = 20
	if Input.is_key_pressed(KEY_B):
		get_parent().red_team_first = false
		whos_on_first.emit()
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
	
