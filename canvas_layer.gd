extends CanvasLayer

func _ready() -> void:
	goagain()

func goagain():
	$Timer.start(randf_range(0.6,0.9))
	 

func _on_timer_timeout() -> void:
	var current = int($"TV's Left".text)
	current -= 1
	$"TV's Left".text =str(current)
	goagain()
