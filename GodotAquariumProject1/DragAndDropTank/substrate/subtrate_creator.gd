extends Node2D

@onready var particle_scene: PackedScene = load("res://DragAndDropTank/substrate/substrate_particle.tscn")
@onready var particle_scene_2: PackedScene = load("res://DragAndDropTank/substrate/substrate_particle_w_physics.tscn")

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		for i in 10:
			var new_particle: Node2D = particle_scene_2.instantiate()
			new_particle.position = get_global_mouse_position() + Vector2(randf_range(-5,5),randf_range(-5,5))
			add_child(new_particle)
