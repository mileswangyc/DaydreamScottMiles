extends CharacterBody2D

@export var speed: float = 400.0  # pixels per second

func _physics_process(delta: float) -> void:
	
	var direction = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized()
	

	velocity = direction * speed

	move_and_slide()
