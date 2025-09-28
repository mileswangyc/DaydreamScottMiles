extends Node2D
		
var laser_scene = preload("res://bullets.tscn")
var grenade_scene = preload("res://grenade.tscn")

func _on_mc_laser(pos: Variant, direction: Variant) -> void:
	var laser = laser_scene.instantiate()
	$Projectiles.add_child(laser)
	laser.position = pos
	var angle_degrees = rad_to_deg(direction.angle()) +90
	var angle_radians = deg_to_rad(angle_degrees)
	laser.fixeddirection = Vector2(cos(angle_radians), sin(angle_radians))
	
	
	


func _on_mc_grenade(pos: Variant, direction: Variant) -> void:
	var grenade = grenade_scene.instantiate()
	$Projectiles.add_child(grenade)
	grenade.position = pos
	var angle_degrees = rad_to_deg(direction.angle()) +180
	var angle_radians = deg_to_rad(angle_degrees)
	grenade.fixeddirection = Vector2(cos(angle_radians), sin(angle_radians))
	grenade.linear_velocity = grenade.fixeddirection * grenade.speed
