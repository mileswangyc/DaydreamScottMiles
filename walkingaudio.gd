extends AudioStreamPlayer2D

func _ready():
	if stream == null:
		print("ERROR: No audio stream assigned!")
	else:
		print("Audio stream loaded: ", stream)

func _process(_delta):
	var is_moving = Input.is_action_pressed("up") or \
					Input.is_action_pressed("down") or \
					Input.is_action_pressed("left") or \
					Input.is_action_pressed("right")
	
	if is_moving:
		if not playing:
			print("Starting walk sound")
			play()
	else:
		if playing:
			print("Stopping walk sound")
			stop()
