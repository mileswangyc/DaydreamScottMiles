extends Area2D

@export var speed: int = 1500
var fixeddirection
signal hitenemy

func _ready():
	$Timer.start()

func _process(delta):
	position += fixeddirection * speed * delta
	

func _on_body_entered(body):
	if body.is_in_group("player"):
		return 
	if body.is_in_group("enemies"):

		body.hitenemy()
	elif "hit" in body:
		body.hit()
	queue_free()



func _on_timer_timeout() -> void:
	queue_free()
