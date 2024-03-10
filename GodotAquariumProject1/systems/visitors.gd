extends Node2D

@onready var spectator_scene: PackedScene = load("res://visitor.tscn")

func _on_tank_spectate_entered() -> void:
	
	var spectator_count: int = randi_range(0,globals.fish_count)
	
	for n in spectator_count:
		var spawn_point: Vector2 = Vector2(randi_range(-520,520),300)
		var new_spectator = spectator_scene.instantiate()
		new_spectator.position = spawn_point
		add_child(new_spectator)
	
	globals.total_spectator_count += spectator_count
	globals.daily_spectator_count = spectator_count

func _on_tank_result_entered() -> void:
	for child in get_children():
		child.queue_free()
