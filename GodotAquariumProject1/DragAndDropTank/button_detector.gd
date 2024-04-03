extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_fish_button_clicked(scene: PackedScene):
	
	for i in 10:
		var new_scene = scene.instantiate()
		new_scene.position = Vector2(randf_range(draganddropglobals.min_x,draganddropglobals.max_x),randf_range(draganddropglobals.min_y,draganddropglobals.max_y))
		add_child(new_scene)
