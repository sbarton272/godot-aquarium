extends Node2D

class_name EntityDataManager

@export var entity_data_master_resource: Resource

var entity_display_name: Dictionary = {
	"Garibaldi": "Garibaldi",
	"Purplegari": "Purple Garibaldi",
	"Kelp": "Kelp"
}

var entity_tooltip_text: Dictionary = {
	"Garibaldi": "orange boy",
	"Purplegari": "purple boy",
	"Kelp": "a piece of kelp"
}

var entity_texture: Dictionary = {
	"Garibaldi": "res://graphics/garibaldi_scaled.png",
	"Purplegari": "res://graphics/spencer_purple_fish_1.png",
	"Kelp": "res://graphics/kelp_2_frames_scaled.png"
}

var entity_icon_texture: Dictionary = {
	"Garibaldi": "res://graphics/garibaldi_icon.png",
	"Purplegari": "res://graphics/garibaldi_icon.png",
	"Kelp": "res://graphics/kelp_2_frames_scaled.png"
}

var entity_scene: Dictionary = {
	"Garibaldi": "res://entities/entity scenes/garibaldi.tscn",
	"Purplegari": "res://entities/entity scenes/purplegari.tscn",
	"Kelp": "res://entities/entity scenes/test_tree.tscn"
}

var entity_cost: Dictionary = {
	"Garibaldi": 10,
	"Purplegari": 40,
	"Kelp": 5
}

var entity_revenue: Dictionary = {
	"Garibaldi": 2,
	"Purplegari": 5,
	"Kelp": 0
}

func generate_entity_data(entity_name: String) -> EntityData:
	var new_entity_data_resource: EntityData = entity_data_master_resource.duplicate()
	new_entity_data_resource.display_name = entity_display_name[entity_name]
	new_entity_data_resource.tooltip_text = entity_tooltip_text[entity_name]
	new_entity_data_resource.texture = load(entity_texture[entity_name])
	new_entity_data_resource.icon_texture = load(entity_icon_texture[entity_name])
	new_entity_data_resource.scene = load(entity_scene[entity_name])
	new_entity_data_resource.cost = entity_cost[entity_name]
	new_entity_data_resource.revenue = entity_revenue[entity_name]
	return new_entity_data_resource
