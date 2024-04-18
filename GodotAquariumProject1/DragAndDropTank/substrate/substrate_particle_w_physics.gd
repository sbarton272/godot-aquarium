extends RigidBody2D

func _ready():
	var sprite: Sprite2D = $Sprite2D
	var red: float = randf_range(0.85,0.95)
	var green: float = randf_range(0.8,0.9)
	var blue: float = randf_range(0.7,0.8)
	sprite.modulate = Color(red,blue,green,1)
