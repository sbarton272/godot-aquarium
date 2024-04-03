extends Node2D

@onready var stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var sounds: Array[AudioStream]

func _ready():
	stream_player.stream = sounds.pick_random()
	stream_player.pitch_scale = randf_range(0.9,1.1)
	stream_player.play()
