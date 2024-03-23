extends Node2D

@onready var light: PointLight2D = $PointLight2D

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

func _on_diver_flashlight_toggle() -> void:
	light.enabled = !light.enabled
