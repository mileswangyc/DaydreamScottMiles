extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)
signal boom(pos, direction)

var gunlock = false
var grenadelock = false
var boomlock = false

var speed= 400.0 
var choice = 0
var carmode = false
@onready var cam = $Camera2D
@onready var new_parent = $"../Car"

func _physics_process(delta: float) -> void:
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = dir * speed
	var mousepos = get_global_mouse_position()
	rotation = (global_position-mousepos).angle()
	var player_direction = (global_position-mousepos).normalized()
	
	if Input.is_action_just_pressed("1") and gunlock == true:
		choice = 1
		$"../CanvasLayer/bull2".modulate = Color(0, 0, 0)
		$"../CanvasLayer/boom3".modulate = Color(1, 1, 1)
		$"../CanvasLayer/gren3".modulate = Color(1, 1, 1)
		$AnimatedSprite2D.play("Normal")
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame=1
	if Input.is_action_just_pressed("2") and grenadelock == true:
		choice = 2
		$"../CanvasLayer/gren3".modulate = Color(0, 0, 0)
		$"../CanvasLayer/boom3".modulate = Color(1, 1, 1)
		$"../CanvasLayer/bull2".modulate = Color(1, 1, 1)
		$AnimatedSprite2D.animation.play("Normal")
		$AnimatedSprite2D.frame=2
	if Input.is_action_just_pressed("3") and boomlock == true:
		choice = 3
		$"../CanvasLayer/boom3".modulate = Color(0, 0, 0)
		$"../CanvasLayer/bull2".modulate = Color(1, 1, 1)
		$"../CanvasLayer/gren3".modulate = Color(1, 1, 1)
		$AnimatedSprite2D.animation.play("Normal")
		$AnimatedSprite2D.frame=3

	
	if Input.is_action_just_pressed("shoot") and choice == 1:

		if SharedVar.bullet > 0:
			laser.emit(position, player_direction)
			SharedVar.bullet -= 1
	if Input.is_action_just_pressed("shoot") and choice == 2:
		grenade.emit(position, player_direction)
		
	if Input.is_action_just_pressed("shoot") and choice == 3:
		boom.emit(position, player_direction)
		
	if Input.is_action_just_pressed("Test"):
		$"../Car".rotation_degrees = -90
		$"../Car".position = position
		carmode = true
		
	if carmode == true:
		visible = false
		cam.get_parent().remove_child(cam)
		new_parent.add_child(cam)
		position = $"../Car".position
		$CollisionShape2D.disabled = true
		
	move_and_slide()


func _on_gun_pickup_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../Pickups/GunPickup".queue_free()
		Input.action_press("1")
		SharedVar.bullet += 5
		gunlock = true
