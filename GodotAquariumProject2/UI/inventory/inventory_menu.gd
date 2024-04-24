extends Control

@export var player_manager: PlayerManager
@export var tank_manager: TankManager
@export var inventory_button_scene: PackedScene
@export var placement_ghost_scene: PackedScene

@onready var button_container: VBoxContainer = $Panel/VBoxContainer

func _ready():
	hide()

func toggle_visibility():
	visible = !visible

func populate_inventory():
	for i in button_container.get_children():
		button_container.remove_child(i)
		i.queue_free()

	for entity_data in player_manager.inventory_entities:
		var new_button: Button = inventory_button_scene.instantiate()
		new_button.entity_data = entity_data
		new_button.connect("inventory_entity_selected",create_entity_placement_ghost)
		$Panel/VBoxContainer.add_child(new_button)

func create_entity_placement_ghost(entity_data: EntityData):
	var entity_index: int = player_manager.inventory_entities.find(entity_data)
	player_manager.inventory_entities.remove_at(entity_index)
	var new_inventory_ghost: Node2D = placement_ghost_scene.instantiate()
	new_inventory_ghost.entity_data = entity_data
	new_inventory_ghost.spawn_entity.connect(tank_manager.spawn_entity)
	player_manager.add_child(new_inventory_ghost)
