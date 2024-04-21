extends Control

@export var player_money_label: Label
@export var player_substrate_label: Label

func _ready():
	player_money_label.text = str("Cash: ",PlayerData.player_money)
	player_substrate_label.text = str("Substrate: ",PlayerData.player_substrate)
	PlayerData.update_player_money.connect(_on_player_data_update_player_money)
	PlayerData.update_player_substrate.connect(_on_player_data_update_player_substrate)

func _on_player_data_update_player_money(value):
	player_money_label.text = str("Cash: ",value)

func _on_player_data_update_player_substrate(value):
	player_substrate_label.text = str("Substrate: ",value)
