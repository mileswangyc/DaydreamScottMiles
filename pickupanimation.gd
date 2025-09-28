extends Area2D

var t = 0.0

func _process(delta):
	t += delta
	var scale_value = 1.05 + 0.05 * sin(2.0 * PI * t) 
	scale = Vector2(scale_value, scale_value)
