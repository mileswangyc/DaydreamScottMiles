extends CharacterBody2D

@export var speed: float = 100.0
@export var move_time: float = 1.0
@export var turn_speed: float = 5.0 

var y1 = -1
var y2 =1
var current_direction: Vector2
var target_direction: Vector2
var timer: float = 0.0

func _ready():
	var hue = randf_range(0.07, 0.09)
	var saturation = randf_range(0.1, 0.35)
	var lightness = randf_range(0.7, 0.95)
	modulate =  Color.from_hsv(hue, saturation, lightness)
	pick_new_direction()
	current_direction = target_direction

func _physics_process(delta):

	timer -= delta
	if timer <= 0:
		pick_new_direction()

	
	var current_angle = current_direction.angle()
	var target_angle = target_direction.angle()
	var new_angle = lerp_angle(current_angle, target_angle, turn_speed * delta)


	current_direction = Vector2.RIGHT.rotated(new_angle)

	
	velocity = current_direction * speed
	rotation = new_angle + PI
	move_and_slide()

func pick_new_direction():
	target_direction = Vector2(1, randf_range(y1, y2)).normalized()
	timer = randf_range(0.5,1.5)
func hitenemy():
	queue_free()
