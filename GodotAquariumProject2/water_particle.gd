extends Node2D

var tank_manager: TankManager
var active: bool = true

func _ready():
	rotation = randf_range(0,2*PI)
	$Sprite2D.modulate.a = randf_range(0.7,0.9)
	tank_manager = get_parent()

func _process(delta):
	if active:
		position.y += 400 * delta
		if position.y >= tank_manager.max_y - tank_manager.water_level:
			$CPUParticles2D.emitting = true
			rotation = 0
			$Sprite2D.hide()
			tank_manager.water_level += 1
			active = false

func die():
	queue_free()
