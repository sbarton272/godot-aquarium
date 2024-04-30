extends Node2D

signal spawn_entity(entity_data: EntityData, pos: Vector2)

var entity_data: EntityData

func _ready():
	var sprite: Sprite2D = $Sprite2D
	sprite.texture = entity_data.texture

func _process(_delta):
	global_position = get_global_mouse_position()

func _input(event: InputEvent):
	if event.is_action_released("select"):
		
		emit_signal("spawn_entity",entity_data,position)
		
		queue_free()
