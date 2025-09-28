extends CharacterBody2D

signal laser(pos, direction)
 
var speed= 400.0 
var can_laser = true
func _physics_process(delta: float) -> void:
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = dir * speed
	var mousepos = get_global_mouse_position()
	rotation = (global_position-mousepos).angle()
	
	var player_direction = (global_position-mousepos).normalized()
	if Input.is_action_just_pressed("shoot") and can_laser:
		laser.emit(position, player_direction)
	move_and_slide()
