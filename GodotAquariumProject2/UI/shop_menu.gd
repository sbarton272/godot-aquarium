extends Control

signal entity_purchased(EntityData)

@export var game_manager: GameManager
@export var tank_entity_manager: Node2D

func _ready():
	hide()
	game_manager.connect("shop_opened", open_shop)

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		hide()

func open_shop():
	show()

func _on_shop_button_shop_item_purchased(entity_data: EntityData):
	emit_signal("entity_purchased",entity_data)
