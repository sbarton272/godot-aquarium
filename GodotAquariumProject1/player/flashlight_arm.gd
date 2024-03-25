extends Node2D

@onready var beam_light: PointLight2D = $FlashlightBeamLight
@onready var surround_light: PointLight2D = $FlashlightSurroundLight

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

func _on_diver_flashlight_toggle() -> void:
	beam_light.enabled = !beam_light.enabled
	surround_light.enabled = !surround_light.enabled
