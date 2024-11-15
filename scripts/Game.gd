extends TextureRect

const SAVE_PATH = "res://wordlist.cfg" # res://wordlist.cfg # unused

@export var default_label_settings: LabelSettings

@export var first_team: String = "red"

enum teams { Red, Blue}

var config: ConfigFile = ConfigFile.new()
var text_array: Array = []

const codenames_list: int = 25

var time_since_last_reload: float = 0.0 # Used in _process for reloading
var reload_codenames_cooldown_seconds = 0

var node_children: Array[Node]
var button_label_children: Array[Label]
var red_team_label: Label
var blue_team_label: Label

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
	# Need to clear buton label children to stop it from appending
	button_label_children.clear() 
	
	# Iterate through each child of TextureRect
	for child in node_children:
		# Check if the child is a Button
		if child is Button and "card" in child.name.to_lower():
			
			if text_array.size() < 25:
				print("Deck has been used up. Resetting...")
				config.load("wordlist.cfg")
				text_array = config.get_value("Default_Words_Pack", "default_words_pack")
				print(text_array.size())
			# Get label settings from each color button
			for button_child in child.get_children():
				if button_child is Label:
					var random_index = randi() % text_array.size()
					button_child.text = text_array[random_index]
					text_array.remove_at(random_index)
					button_label_children.append(button_child)
		
		# Find red team label and blue team label
		elif child is Label and "red" in child.name.to_lower():
			red_team_label = child
		elif child is Label and "blue" in child.name.to_lower():
			blue_team_label = child
			
	print(text_array.size())
	_update_score()
	print("reset board")

func _update_cards(card_to_keep: String = "reset"):
	#print(card_to_keep)
	for child in node_children:
		if child is Button and child.name != card_to_keep:
			for button_child in child.get_children():
				if button_child is Button:
					button_child.set_visible(false)
				elif button_child is Label and card_to_keep == "reset":
					button_child.label_settings = default_label_settings

func _update_score(): 
	if first_team == "red":
		red_score = 9
		blue_score = 8
	else: 
		blue_score = 9
		red_score = 8
	#print(button_label_children)
	for label in button_label_children:
		if label.label_settings.font_color == red_team_label.label_settings.font_color:
			num_red_cards += 1
			print("red")
		if label.label_settings.font_color == blue_team_label.label_settings.font_color:
			num_blue_cards += 1
			print("blue")
	print("red count ",num_red_cards)
	print("blue count ",num_blue_cards)
	red_score -= num_red_cards
	blue_score -= num_blue_cards
	red_team_label.text = str(red_score)
	blue_team_label.text = str(blue_score)
	num_red_cards = 0
	num_blue_cards = 0
