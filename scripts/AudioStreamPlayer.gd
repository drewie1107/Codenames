extends AudioStreamPlayer

var music_enabled = false

func _ready():
	pass


func _process(delta):
	if music_enabled:
		if Input.is_action_pressed("play_music"):
			play()
		if Input.is_action_just_pressed("pause_music"):
			if playing:
				stream_paused = true
			else:
				stream_paused = false

func _on_timer_timeout():
	music_enabled = true
