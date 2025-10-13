extends Camera2D

@export var max_opacity := 0.5
@export var color_rect: ColorRect
@export var bass_threshold := 0.0 
@export var bass_multiplier := 2.0  

var speakers: Array[AudioStreamPlayer2D] = []
var spectrum: AudioEffectSpectrumAnalyzerInstance

func _ready():
	speakers = [
		get_node("../../Map/AudioStreamPlayer2D"),
		get_node("../../Map/FarAudio")
	]
	
	if color_rect:
		color_rect.color = Color(1.0, 0.0, 0.0, 0.0)
	
	var idx = AudioServer.get_bus_index("Master")
	var effect = AudioEffectSpectrumAnalyzer.new()
	AudioServer.add_bus_effect(idx, effect)
	spectrum = AudioServer.get_bus_effect_instance(idx, 0)

func _process(delta):
	
	var bass_energy = 0.0
	var freq_range = [20.0, 60.0, 100.0, 150.0, 200.0, 250.0]
	
	for freq in freq_range:
		var magnitude = spectrum.get_magnitude_for_frequency_range(freq, freq + 20.0)
		bass_energy += magnitude.length()
	
	bass_energy = (bass_energy / freq_range.size()) * bass_multiplier
	bass_energy = clamp(bass_energy - bass_threshold, 0.0, 1.0)
	
	color_rect.color.a = bass_energy * max_opacity
