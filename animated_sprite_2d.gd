extends AnimatedSprite2D

@export var speed: float = 200.0
@export var rotation_speed: float = 3.0  # radians per second

var velocity: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	var input_vector := Vector2.ZERO
	
	# Forward/backward
	if Input.is_action_pressed("ui_up"): # W
		input_vector.x += 1
	if Input.is_action_pressed("ui_down"): # S
		input_vector.x -= 1
	
	# Rotation
	if Input.is_action_pressed("ui_left"): # A
		rotation -= rotation_speed * delta
	if Input.is_action_pressed("ui_right"): # D
		rotation += rotation_speed * delta
	
	# Movement in facing direction
	if input_vector.x != 0:
		var direction := Vector2.RIGHT.rotated(rotation)
		velocity = direction * speed * input_vector.x
	else:
		velocity = Vector2.ZERO
	
	position += velocity * delta
