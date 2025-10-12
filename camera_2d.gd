extends Camera2D

@export var shake_strength := 100.0
@export var smoothness := 8       # higher = smoother, less twitchy
@export var sensitivity := 0.1
@export var shake_update_rate := 0.1  # seconds between shake updates

var speakers: Array[AudioStreamPlayer2D] = []
var original_position: Vector2
var current_offset := Vector2.ZERO
var target_offset := Vector2.ZERO
var shake_timer := 0.0
var current_intensity := 0.0

func _ready():
	original_position = position

	speakers = [
		get_node("../../Map/AudioStreamPlayer2D"),
		get_node("../../Map/FarAudio")
	]

func _process(delta):
	var total_volume = 0.0

	# --- Measure how loud the nearby speakers are ---
	for speaker in speakers:
		if speaker and speaker.playing:
			var dist = global_position.distance_to(speaker.global_position)
			var loudness = clamp(1.0 - dist / 4000.0, 0.0, 1.0)
			total_volume += loudness

	# --- Smoothly approach new intensity ---
	var target_intensity = max(total_volume - sensitivity, 0.0)
	current_intensity = lerp(current_intensity, target_intensity, delta * smoothness)

	# --- Only randomize occasionally ---
	shake_timer -= delta
	if shake_timer <= 0.0:
		shake_timer = shake_update_rate
		target_offset = Vector2(
			randf_range(-shake_strength, shake_strength) * current_intensity,
			randf_range(-shake_strength, shake_strength) * current_intensity
		)

	# --- Smoothly move toward the target offset ---
	current_offset = current_offset.lerp(target_offset, delta * smoothness)
	position = original_position + current_offset
