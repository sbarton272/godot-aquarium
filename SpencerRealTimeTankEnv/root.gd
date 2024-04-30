extends Node2D

var fish_scene: PackedScene = load("res://creature.tscn")
var viewport_size

# Called when the node enters the scene tree for the first time.
func _ready():
	viewport_size = get_viewport_rect().size
	var new_fish = fish_scene.instantiate()
	new_fish.position = Vector2(viewport_size.x / 2, viewport_size.y / 2)
	add_child(new_fish)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
