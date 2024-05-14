extends Node2D

enum TileType {Red, Green, Blue, SIZE}

var tile_counts: Dictionary = {}
var tile_commands: Dictionary = {}
var tile_colors: Dictionary = {}

func _ready():
	tile_counts[TileType.Red] = 1
	tile_counts[TileType.Green] = 1
	tile_counts[TileType.Blue] = 1
	
	tile_commands[TileType.Red] = "keyboard_1"
	tile_commands[TileType.Green] = "keyboard_2"
	tile_commands[TileType.Blue] = "keyboard_3"
	
	tile_colors[TileType.Red] = Color(0.9,0.4,0.4,1)
	tile_colors[TileType.Green] = Color(0.4,0.8,0.4,1)
	tile_colors[TileType.Blue] = Color(0.1,0.3,1,1)

func _input(event):
	for tile_type in TileType.SIZE:
		if event.is_action_pressed(tile_commands[tile_type]) and tile_counts[tile_type] > 0:
			$HoverTile.position = get_global_mouse_position()
			$HoverTile.get_node("Sprite2D").modulate = tile_colors[tile_type]
			$HoverTile.show()
	if event.is_action_pressed("esc"):
		$HoverTile.hide()
	if event.is_action_pressed("mouse_button_left"):
		#if we're hovering a tile, apply it to the tilemap current tile
		pass
