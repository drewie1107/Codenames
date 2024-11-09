extends TextureRect

const SAVE_PATH = "res://wordlist.cfg" # res://wordlist.cfg # unused

var config = ConfigFile.new()
var text_array = []

var codenames_list = 25

var time_since_last_reload = 0.0 # Used in _process for reloading
var reload_codenames_cooldown_seconds = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load data from a file.
	var err = config.load("wordlist.cfg")

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
	for child in get_children():
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
