extends Node2D

@export var water_particle_scene: PackedScene

var water_spawn_timer: Timer
var is_spawning_water: bool

func _process(delta):
	position.x = get_global_mouse_position().x
	position.y = clamp(get_global_mouse_position().y,-300,0)
	if Input.is_mouse_button_pressed(1) and not is_spawning_water:
		is_spawning_water = true
		water_spawn_timer = Timer.new()
		water_spawn_timer.one_shot = false
		water_spawn_timer.connect("timeout",spawn_water)
		add_child(water_spawn_timer)
		water_spawn_timer.start(0.02)
	if not Input.is_mouse_button_pressed(1) and water_spawn_timer and is_spawning_water:
		is_spawning_water = false
		water_spawn_timer.call_deferred("queue_free")

func spawn_water():
	var water_particle: Node2D = water_particle_scene.instantiate()
	var offset: Vector2 = Vector2(randf_range(-30,30),randf_range(0,20))
	water_particle.position = global_position + offset
	get_parent().add_child(water_particle)
