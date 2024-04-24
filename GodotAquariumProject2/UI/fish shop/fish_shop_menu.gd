extends Control

signal entity_purchased(entity_scene: PackedScene)

@export var game_manager: GameManager
@export var entity_data_manager: EntityDataManager
@export var player_manager: PlayerManager

@export var fish_types: Array[String]

@onready var fish_shop_button_scene: PackedScene = load("res://UI/fish shop/fish_shop_button.tscn")

func _ready():
	for fish_string in fish_types:
		var new_button: Button = fish_shop_button_scene.instantiate()
		new_button.entity_data = entity_data_manager.generate_entity_data(fish_string)
		$Panel/MarginContainer/VBoxContainer/GridContainer.add_child(new_button) 
	
	for button in $Panel/MarginContainer/VBoxContainer/GridContainer.get_children():
		button.connect("shop_item_purchased",_on_shop_button_shop_item_purchased)
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
