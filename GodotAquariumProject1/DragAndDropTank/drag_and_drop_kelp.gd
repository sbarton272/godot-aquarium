extends Node2D

@onready var kelp_sprite: Sprite2D = $KelpSprite

func _ready():
	var shader_material: ShaderMaterial = kelp_sprite.material as ShaderMaterial
	var rand_distance: float = randf_range(1,150)
	shader_material.set_shader_parameter("sway_distance",rand_distance)
	var rand_scale: float = randf_range(0.4,1)
	kelp_sprite.scale = Vector2(rand_scale,rand_scale)
	position.y = 600
	position.x = randi_range(50,1150)
