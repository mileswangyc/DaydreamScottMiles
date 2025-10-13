extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)
signal boom(pos, direction)


var gunlock = false
var grenadelock = false
var boomlock = false
var cool = true
var speed= 400.0 
var choice = 0
var carmode = false
@onready var cam = $Camera2D
@onready var new_parent = $"../Car"
@onready var line = $Line2D

func _physics_process(delta: float) -> void:
	var dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = dir * speed
	var mousepos = get_global_mouse_position()
	rotation = (global_position-mousepos).angle()
	var player_direction = (global_position-mousepos).normalized()
	var direction = (mousepos-global_position).normalized()
	
	if Input.is_action_just_pressed("1") and gunlock == true:
		choice = 1
		$"../CanvasLayer/bull2".modulate = Color(0.968, 0.8, 0.452, 1.0)
		$"../CanvasLayer/boom3".modulate = Color(1, 1, 1)
		$"../CanvasLayer/gren3".modulate = Color(1, 1, 1)
		$AnimatedSprite2D.play("Normal")
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame=1
		line.clear_points()
	if Input.is_action_just_pressed("2") and grenadelock == true:
		choice = 2
		$"../CanvasLayer/gren3".modulate = Color(0.968, 0.8, 0.452, 1.0)
		$"../CanvasLayer/boom3".modulate = Color(1, 1, 1)
		$"../CanvasLayer/bull2".modulate = Color(1, 1, 1)
		$AnimatedSprite2D.play("Normal")
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame=2
		line.clear_points()
		line.add_point(Vector2.ZERO)  
		line.add_point(to_local(mousepos).normalized() * 600)	
	if Input.is_action_just_pressed("3") and boomlock == true:
		choice = 3
		$"../CanvasLayer/boom3".modulate = Color(0.968, 0.8, 0.452, 1.0)
		$"../CanvasLayer/bull2".modulate = Color(1, 1, 1)
		$"../CanvasLayer/gren3".modulate = Color(1, 1, 1)
		$AnimatedSprite2D.play("Normal")
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.frame=3
		line.clear_points()
		line.add_point(Vector2.ZERO)  
		line.add_point(to_local(mousepos).normalized() * 2000)
		
	if Input.is_action_just_pressed("shoot") and choice == 0 and cool == true:
		cool = false
		$AnimatedSprite2D.visible = false
		$AnimatedSprite2D2.play("default")
		$Area2D.monitoring = true
		await get_tree().physics_frame 
		$Area2D.monitoring = false
		$Timer.start(0.8)
		$Punch.play()
		print("shouldplay")
		
		
	if Input.is_action_just_pressed("shoot") and choice == 1:
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D2.visible = false
		if SharedVar.bullet > 0:
			laser.emit(position, player_direction)
			SharedVar.bullet -= 1
			$Bullet.play()
	if Input.is_action_just_pressed("shoot") and choice == 2:
		if SharedVar.grenades > 0:
			grenade.emit(position, player_direction)
			SharedVar.grenades -= 1
			$Timer2.start(1.17)
		
	if Input.is_action_just_pressed("shoot") and choice == 3:
		if SharedVar.boom > 0:
			boom.emit(position, player_direction)
			SharedVar.boom -= 1
			
		
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
		Input.action_release("1")
		SharedVar.bullet += 8
		gunlock = true


func _on_grenade_pickup_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../Pickups/GrenadePickup".queue_free()
		$"../Pickups/GrenadePickup2".queue_free()
		Input.action_press("2")
		Input.action_release("2")
		SharedVar.grenades += 2
		grenadelock = true


func _on_boom_pickup_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../Pickups/BoomPickup".queue_free()
		$"../Pickups/BoomPickup2".queue_free()
		Input.action_press("3")
		Input.action_release("3")
		SharedVar.boom += 2
		boomlock = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.hitenemy()


func _on_timer_timeout() -> void:
	cool = true


func _on_car_pickup_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Input.action_press("Test")


func _on_tv_pickup_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../CanvasLayer/Win".visible = true
		$Win.play()
		


func _on_timer_2_timeout() -> void:
	$Timer2.stop()
	var grenade_explosion = get_node("Grenade")
	grenade_explosion.play()
	print("Exploded")
	return
