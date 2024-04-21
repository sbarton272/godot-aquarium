extends Control

signal supplies_purchased(Supplies)

enum Supplies {SUBSTRATE,FOOD}

@export var game_manager: GameManager

func _ready():
	hide()
	game_manager.connect("open_supplies_shop", open_shop)
	game_manager.connect("ui_panel_opened", close_shop)

func _input(event: InputEvent):
	if event.is_action_pressed("ui_cancel"):
		close_shop()

func open_shop():
	show()

func close_shop():
	hide()

func _on_shop_button_shop_item_purchased(supplies: Supplies, quantity: int, cost: int):
	if PlayerData.player_money >= cost:
		if supplies == Supplies.SUBSTRATE:
			PlayerData.player_substrate += quantity
	PlayerData.player_money -= cost
