extends Node

class_name GameManager

signal shop_opened()

@export var tank: Tank

func _ready():
	var profit_timer: Timer = Timer.new()
	add_child(profit_timer)
	profit_timer.start(1)
	profit_timer.connect("timeout",generate_revenue)
	
	#starting cash - for test purposes
	PlayerData.player_money = 30

func _input(event: InputEvent):
	if event.is_action_released("OpenShop"):
		emit_signal("shop_opened")

func generate_revenue():
	PlayerData.player_revenue = 0
	
	for entity in tank.entities.get_children():
		if entity.calculate_revenue():
			PlayerData.player_revenue += entity.calculate_revenue()
	
	PlayerData.player_money += PlayerData.player_revenue
	print(PlayerData.player_money)
