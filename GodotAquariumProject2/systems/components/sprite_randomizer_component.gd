extends Node2D

@export var scale_min: float
@export var scale_max: float
@export var target_sprite: Sprite2D

@export var scales_collider: bool
@export var target_collider: Node2D

func _ready():
	var new_scale: float = randf_range(scale_min,scale_max)
	target_sprite.scale = Vector2(new_scale,new_scale)
	if scales_collider:
		target_collider.scale = Vector2(new_scale,new_scale)
