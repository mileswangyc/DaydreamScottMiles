extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)
signal boom(pos, direction)

var speed= 400.0 
var can_laser = false
var can_grenade = false
var can_boom = true

func _physics_process(delta: float) -> void:
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = dir * speed
	var mousepos = get_global_mouse_position()
	rotation = (global_position-mousepos).angle()
	var player_direction = (global_position-mousepos).normalized()
	
	if Input.is_action_just_pressed("shoot") and can_laser:
		laser.emit(position, player_direction)
		
	if Input.is_action_just_pressed("shoot") and can_grenade:
		grenade.emit(position, player_direction)
		
	if Input.is_action_just_pressed("shoot") and can_boom:
		boom.emit(position, player_direction)
		
	move_and_slide()
