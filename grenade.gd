extends RigidBody2D

@export var speed: int = 3000
var fixeddirection
var explode 

func _ready():
	$Timer.start(1)

	
func _process(delta):
	pass





func _on_timer_timeout() -> void:
	$Area2D.explode()
	var grenade_explosion = get_node("AudioStreamPlayer2D")
	grenade_explosion.play()
	print("Exploded")

	
#func _on_body_entered(body):
	#if explode == true:
		#if body.is_in_group("player"):
			#return 
		#if body.is_in_group("enemies"):
			#body.hitenemy()
		#elif "hit" in body:
			#body.hit()
		#queue_free()
