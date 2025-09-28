extends Node2D
		
var laser_scene = preload("res://bullets.tscn")


func _on_mc_laser(pos: Variant, direction: Variant) -> void:
	var laser = laser_scene.instantiate()
	add_child(laser)
	laser.position = pos
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	
