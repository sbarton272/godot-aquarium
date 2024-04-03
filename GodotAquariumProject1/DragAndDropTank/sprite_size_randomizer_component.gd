extends Node2D

@export var target_sprite: Sprite2D
@export var min_scale: float
@export var max_scale: float

#attach this node to any scene, select a sprite, and choose min and max scale values, and the sprite will be scaled at runtime
#the sprite's scale is multiplied, so the default scale can be customized (e.g. a very large image can be scaled down, then randomized with relative values)

func _ready():
	var new_scale_float: float = randf_range(min_scale,max_scale)
	target_sprite.scale *= new_scale_float
