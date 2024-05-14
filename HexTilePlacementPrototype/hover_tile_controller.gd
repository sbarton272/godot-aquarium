extends Node2D

@export var tile_map: TileMap

func _process(delta):
	var tile_pos: Vector2 = tile_map.local_to_map(get_global_mouse_position())
	var snap_pos: Vector2 = tile_map.map_to_local(tile_pos)
	
	position = snap_pos
