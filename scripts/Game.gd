extends TextureRect

const SAVE_PATH = "res://wordlist.cfg" # res://wordlist.cfg # unused

var config: ConfigFile = ConfigFile.new()
var text_array: Array = []

const codenames_list: int = 25

var time_since_last_reload: float = 0.0 # Used in _process for reloading
var reload_codenames_cooldown_seconds = 0

var node_children: Array[Node]
var red_label: Label
var blue_label: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load data from a file.
	var err: Error = config.load("wordlist.cfg")
	node_children = get_children()
	
	red_label = get_node("Red Team Label")
	blue_label = get_node("Blue Team Label")
	
# If the file didn't load, ignore it and log error.
	if err != OK:
		print("Error loading file")
		return
	else:
		text_array = config.get_value("Default_Words_Pack", "default_words_pack")
		print(text_array.size())
		_set_board()

###############################################################################

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_since_last_reload += delta
	if Input.is_action_just_pressed("reset_board"):
		if time_since_last_reload >= reload_codenames_cooldown_seconds:
			_set_board()
			time_since_last_reload = 0

# Change the button's color to the next color in the array

func _set_board():
	# Iterate through each child of TextureRect
	for child in node_children:
		# Check if the child is a Button
		if child is Button:
			if text_array.size() < 25:
				print("text_array was reset")
				config.load("wordlist.cfg")
				text_array = config.get_value("Default_Words_Pack", "default_words_pack")
				print(text_array.size())
			
			# Access the Label child of the Button and edit its text
			var label = child.get_node("Label")
			if label:
				var random_index = randi() % text_array.size()
				label.text = text_array[random_index]
				text_array.remove_at(random_index)
	print(text_array.size())

func _update_cards(card_to_keep):
	#print(card_to_keep)
	for child in card_to_keep.get_children():
		if child is Label:
			var label_color: LabelSettings = child.get_label_settings()
			print(label_color.font_color)
			if label_color.font_color == Color(.4,.655,.753,1):
				red_label.text = "Changed"
			if label_color.font_color == Color(.722,.247,.255,1):
				blue_label.text = "Changed"

	
	for child in node_children:
		if child is Button and child.name != card_to_keep.name:
			var current_button = child
			for button_child in current_button.get_children():
				if button_child is Button:
					button_child.set_visible(false)
