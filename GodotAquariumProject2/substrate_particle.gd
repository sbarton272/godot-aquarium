extends RigidBody2D

@export var my_sprite: Sprite2D
var tank_manager: TankManager

func _ready():
	var rand_r: float = randf_range(0.8,0.9)
	var rand_g: float = randf_range(0.7,0.8)
	var rand_b: float = randf_range(0.8,0.9)
	my_sprite.modulate = Color(rand_r,rand_g,rand_b,1)

func vacuum():
	PlayerData.player_substrate += 1
	queue_free()

func _on_mouse_entered():
	if tank_manager.vacuuming_substrate:
		vacuum()
