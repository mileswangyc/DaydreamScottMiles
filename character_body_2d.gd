extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)
signal boom(pos, direction)

var speed= 400.0 
var can_laser = false
var can_grenade = false
var can_boom = true

var using_alt_sprite: bool = false
@onready var sprite = $AnimatedSprite2D

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
		
	if Input.is_action_just_pressed("switch_sprite"):  # define in InputMap
		using_alt_sprite = !using_alt_sprite
		if using_alt_sprite:
			sprite.animation = "Vehicle_animation"  # Name of your alternate animation
		else:
			sprite.animation = "Player_Sprite"     # Name of your default animation
		sprite.play()

		
	move_and_slide()
