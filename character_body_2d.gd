extends CharacterBody2D

@export var speed: float = 400.0  # pixels per second

func _physics_process(delta: float) -> void:
	# Read WASD/arrow input (left, right, up, down must match Input Map action names)
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	# Set the kinematic velocity (CharacterBody2D has a built-in `velocity` property)
	velocity = dir * speed
	
	var mousepos = get_global_mouse_position()
	rotation = (global_position-mousepos).angle()
	# Apply movement & collision response (call in _physics_process)
	move_and_slide()
