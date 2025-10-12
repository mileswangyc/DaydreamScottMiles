extends Area2D

@export var speed: int = 2000
var fixeddirection
signal hitenemy
var type = 1

func _ready():
	$Timer.start()

func _process(delta):
	if type == 1:
		position += fixeddirection * speed * delta
	if type == 2:
		position -= fixeddirection * speed * delta
	#Add boomerang sound
	

func _on_body_entered(body):
	if body.is_in_group("player"):
		return 
	if body.is_in_group("enemies"):
		body.hitenemy()
	elif body.is_in_group("walls"):
		queue_free()



func _on_timer_timeout() -> void:
	type = 2
	$Timer2.start(0.95)
	#position -= fixeddirection * speed * delta


func _on_timer_2_timeout() -> void:
	print("timer2")
	queue_free()
