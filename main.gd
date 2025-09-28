extends Node2D
		
var laser_scene = preload("res://bullets.tscn")


func _on_mc_laser(pos: Variant, direction: Variant) -> void:
	var laser = laser_scene.instantiate()
	$Projectiles.add_child(laser)
	laser.position = pos
	var angle_degrees = rad_to_deg(direction.angle()) +90
	var angle_radians = deg_to_rad(angle_degrees)
	laser.fixeddirection = Vector2(cos(angle_radians), sin(angle_radians))
	
	
	
