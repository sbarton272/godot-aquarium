extends Node2D

class_name PlayerManager

@export var tank_manager: TankManager

func _ready():
	var profit_timer: Timer = Timer.new()
	add_child(profit_timer)
	profit_timer.start(1)
	profit_timer.connect("timeout",generate_revenue)
	
	#starting cash - for test purposes
	PlayerData.player_money = 100
	PlayerData.player_substrate = 20

func generate_revenue():
	PlayerData.player_revenue = 0
	
	for entity in tank_manager.entities.get_children():
		if entity.calculate_revenue():
			PlayerData.player_revenue += entity.calculate_revenue()
	
	PlayerData.player_money += PlayerData.player_revenue
