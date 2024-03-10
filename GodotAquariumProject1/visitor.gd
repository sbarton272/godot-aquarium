extends Node2D

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.frame = randi_range(0,3)
	position += (Vector2.DOWN * 20)
	var tween_distance: float = randf_range(10,60)
	var tween_time: float = randf_range(0.5,2)
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self,"position",position + (Vector2.UP * tween_distance),tween_time)
