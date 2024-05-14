extends TileMap

const TILEMAP_HEIGHT = 4
const TILEMAP_WIDTH = 4

@onready var tile_label_scene: PackedScene = load("res://tile_label.tscn")

@export var camera_controller: Camera2D

func _ready():
	create_tile_labels()

func _input(event: InputEvent):
	if event.is_action_pressed("mouse_button_left"):
		var point_clicked: Vector2 = get_global_mouse_position()
		var tile_hovered: Vector2 = local_to_map(get_global_mouse_position())
		set_cell(0,tile_hovered,0,Vector2(0,0))
	if event.is_action_pressed("mouse_button_right"):
		var point_clicked: Vector2 = get_global_mouse_position()
		var tile_hovered: Vector2 = local_to_map(get_global_mouse_position())
		set_cell(0,tile_hovered,0,Vector2(-1,-1))
		

func create_tile_labels():
	
	var width: int = TILEMAP_WIDTH
	var height: int = TILEMAP_HEIGHT
	
	for i in TILEMAP_WIDTH:
		for j in TILEMAP_HEIGHT:
			var tile_global_pos: Vector2 = map_to_local(Vector2(i,j))
			var new_label: Label = tile_label_scene.instantiate() as Label
			new_label.text = str("(",i,", ",j,")")
			new_label.position = tile_global_pos
			camera_controller.zoom_changed.connect(new_label.set_new_size)
			add_child(new_label)
