extends CharacterBody2D

@export var speed: float = 100.0
@export var move_time: float = 1.0

var direction_V2
var timer: float = 0.0

func _ready():
	randomize()
	pick_new_direction()

func _physics_process(delta):
	timer -= delta
	if timer <= 0:
		pick_new_direction()

	velocity = direction_V2 * speed
	
	rotation = direction_V2.angle() +PI
	
	move_and_slide()

func pick_new_direction():
	direction_V2 = Vector2(1,randf_range(-1,1))
	timer = move_time
