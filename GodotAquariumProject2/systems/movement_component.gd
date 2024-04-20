extends Node2D

var velocity: Vector2
var speed: float = 20

@export var parent_object: Node2D

func _ready():
	var rand_angle: float = randf_range(0, 2 * PI)
	velocity = Vector2.from_angle(rand_angle) * speed
	parent_object.rotation = rand_angle
	if rand_angle > (PI / 2) and rand_angle < (3 * PI / 2):
		parent_object.get_node("Sprite2D").flip_v = true

func _process(delta):
	parent_object.position += velocity * delta
