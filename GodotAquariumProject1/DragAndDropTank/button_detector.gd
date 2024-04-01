extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_fish_button_clicked(scene: PackedScene):
	var new_scene = scene.instantiate()
	new_scene.position = get_viewport_rect().get_center()
	add_child(new_scene)
