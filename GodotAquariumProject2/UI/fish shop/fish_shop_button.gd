extends Button

signal shop_item_purchased(entity_data: EntityData)

var entity_data: EntityData

var my_entity_scene: PackedScene
var cost: int

func _ready():
	icon = entity_data.icon_texture
	text = entity_data.display_name #and tooltip and cost
	my_entity_scene = entity_data.scene
	cost = entity_data.cost

func _on_button_up():
	if PlayerData.player_money >= cost:
		PlayerData.player_money -= cost
		emit_signal("shop_item_purchased",entity_data)
