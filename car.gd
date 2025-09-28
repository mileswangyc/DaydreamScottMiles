extends CharacterBody2D

var acceleration = 700
var max_speed = 400
var friction = 200
var turn_speed = 3

var velocity_vector = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		input_vector.y -= 1
	if Input.is_action_pressed("down"):
		input_vector.y += 1

	if velocity_vector.length() > 0.1:
		if Input.is_action_pressed("left"):
			rotation -= turn_speed * delta
		if Input.is_action_pressed("right"):
			rotation += turn_speed * delta

	if input_vector.y != 0:
		var direction = Vector2.UP.rotated(rotation) * input_vector.y
		velocity_vector += direction * acceleration * delta

	if input_vector.y == 0:
		var speed = velocity_vector.length()
		speed -= friction * delta
		speed = max(speed, 0)
		velocity_vector = velocity_vector.normalized() * speed if speed > 0 else Vector2.ZERO

	if velocity_vector.length() > max_speed:
		velocity_vector = velocity_vector.normalized() * max_speed

	velocity = velocity_vector
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.queue_free()
	if body.is_in_group("win"):
		print("win")
