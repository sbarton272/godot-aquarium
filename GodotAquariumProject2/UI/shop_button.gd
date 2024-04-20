extends Button

signal shop_item_purchased

var entity_data: EntityData

@export var my_entity_name: String
@export var my_entity_entertainment: int
@export var my_entity_scene: PackedScene
@export var my_entity_cost: int

func _ready():
	var new_data: EntityData = EntityData.new()
	new_data.entity_name = my_entity_name
	new_data.entertainment = my_entity_entertainment
	new_data.entity_scene = my_entity_scene
	new_data.cost = my_entity_cost
	add_child(new_data)
	entity_data = new_data

func _on_button_up():
	if PlayerData.player_money >= my_entity_cost:
		PlayerData.player_money -= my_entity_cost
		emit_signal("shop_item_purchased",entity_data)
