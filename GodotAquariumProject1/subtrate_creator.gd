extends Node2D

@onready var particle_scene: PackedScene = load("res://substrate_particle.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		for i in 10:
			var new_particle: Node2D = particle_scene.instantiate()
			new_particle.position = get_global_mouse_position() + Vector2(randf_range(-5,5),randf_range(-5,5))
			add_child(new_particle)
