extends Control

signal entity_purchased(EntityData)

@export var game_manager: GameManager

func _ready():
	hide()
	game_manager.connect("open_fish_shop", open_shop)
	game_manager.connect("ui_panel_opened", close_shop)

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		close_shop()

func open_shop():
	show()

func close_shop():
	hide()

func _on_shop_button_shop_item_purchased(entity_data: EntityData):
	emit_signal("entity_purchased",entity_data)
