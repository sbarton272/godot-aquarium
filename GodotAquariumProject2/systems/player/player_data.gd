extends Node

signal update_player_money(value: int)
signal update_player_substrate(value: int)

var player_money: int:
	get:
		return player_money
	set(value):
		player_money = value
		emit_signal("update_player_money",value)

var player_substrate: int:
	get:
		return player_substrate
	set(value):
		player_substrate = value
		emit_signal("update_player_substrate",value)

var player_revenue: int
