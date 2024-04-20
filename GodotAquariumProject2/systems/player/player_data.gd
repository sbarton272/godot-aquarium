extends Node

signal update_player_money(value: int)

var player_money: int:
	get:
		return player_money
	set(value):
		player_money = value
		emit_signal("update_player_money",value)
var player_revenue: int
