extends Button

signal inventory_entity_selected(entity_data: EntityData)

var entity_data: EntityData

func _ready():
	icon = entity_data.icon_texture
	text = entity_data.display_name

func _on_pressed():
	emit_signal("inventory_entity_selected",entity_data)
	queue_free()
