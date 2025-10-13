extends RigidBody2D

@export var speed: int = 3000
var exploded: bool = false

func _ready():
	$Timer.start(1)

func _on_Timer_timeout() -> void:
	explode()

func explode():
	if exploded:
		return
	exploded = true

	$AudioStreamPlayer2D.play()
	print("Grenade exploded!")

	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("player"):
			continue
		elif body.is_in_group("enemies"):
			body.hitenemy()
		elif "hit" in body:
			body.hit()

	var duration = $AudioStreamPlayer2D.stream.get_length()
	await get_tree().create_timer(duration).timeout

	queue_free()
