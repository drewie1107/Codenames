extends TextureRect

const SAVE_PATH = "res://wordlist.cfg" # res://wordlist.cfg # unused

@export var default_label_settings: LabelSettings

@export var red_team_first: bool = true

enum teams { Red, Blue}

var config: ConfigFile = ConfigFile.new()
var text_array: Array = []

const codenames_list: int = 25

var time_since_last_reload: float = 0.0 # Used in _process for reloading
var reload_codenames_cooldown_seconds = 0

var node_children: Array[Node]
var button_children: Array[Button]

@export var red_team_label: Label
@export var blue_team_label: Label

var red_score: int = 8
var blue_score: int = 8

var num_red_cards: int = 0
var num_blue_cards: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	# Load data from a file.
	var err: Error = config.load("wordlist.cfg")
	node_children = get_children(false) # Set false to exclude internal children.
	
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
	_update_cards("reset")
	button_children.clear() # Need to clear button_children to stop it from appending

	# Iterate through each child of TextureRect
	for node_child in node_children:
		# Check if the child is a Button
		if node_child is Button and "card" in node_child.name.to_lower():
			button_children.append(node_child)
			if text_array.size() < 25:
				print("Deck has been used up. Resetting...")
				config.load("wordlist.cfg")
				text_array = config.get_value("Default_Words_Pack", "default_words_pack")
				print(text_array.size())
				
			# Give each label a random word from the list of words
			for button in button_children:
				for child in button.get_children():
					if child is Label:
						var random_index = randi() % text_array.size()
						child.text = text_array[random_index]
						text_array.remove_at(random_index)
		
		# Find red team label and blue team label if not assigned
		elif node_child is Label and "red" in node_child.name.to_lower():
			red_team_label = node_child
		elif node_child is Label and "blue" in node_child.name.to_lower():
			blue_team_label = node_child
			
	print(text_array.size()," words unused.")
	_update_score()
	print("reset board")

func _update_cards(button_selected: String = "reset"):
	var reset: bool = false
	if button_selected == "reset": reset = true
	else: reset = false
	#print(card_to_keep)
	for button in button_children:
		if button.name != button_selected:
			if reset: button.current_color = "default"
			for child in button.get_children():
				if child is Button: child.set_visible(false) 
				if child is Sprite2D and reset: 
					child.set_visible(false)
	if reset: _update_score()

func _update_score(): 
	if red_team_first:
		red_score = 9
		blue_score = 8
	else: 
		blue_score = 9
		red_score = 8
		
	for button in button_children:
		if button.current_color == "red":
			num_red_cards += 1
		if button.current_color == "blue":
			num_blue_cards += 1

	red_score -= num_red_cards
	blue_score -= num_blue_cards
	red_team_label.text = str(red_score)
	blue_team_label.text = str(blue_score)
	num_red_cards = 0
	num_blue_cards = 0
