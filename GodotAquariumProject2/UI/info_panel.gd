extends Control

@export var player_money_label: Label

func _ready():
	PlayerData.update_player_money.connect(_on_player_data_update_player_money)

func _on_player_data_update_player_money(value):
	player_money_label.text = str("Cash: ",value)
