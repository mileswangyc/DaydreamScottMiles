extends Area2D


func explode():
	$CollisionShape2D.disabled = false


func _ready() -> void:
	$CollisionShape2D.disabled = true


func _on_body_entered(body):
		if body.is_in_group("player"):
			return 
		if body.is_in_group("enemies"):
			body.hitenemy()
		$"..".queue_free()
