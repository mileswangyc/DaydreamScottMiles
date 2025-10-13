extends CanvasLayer

func _ready() -> void:
	goagain()

func _process(delta: float) -> void:
	if int($"TV's Left".text) < 0:
		$Lose.visible = true

func goagain():
	$Timer.start(randf_range(0.3,0.5))
	 

func _on_timer_timeout() -> void:
	var current = int($"TV's Left".text)
	current -= 1
	$"TV's Left".text =str(current)
	goagain()
