extends Node2D

class_name Tank

@onready var entities: Node2D = $Entities

func spawn_entity(entity_data: EntityData):
	var new_entity: TankEntity = entity_data.entity_scene.instantiate()
	new_entity.data = entity_data
	entities.add_child(new_entity)
