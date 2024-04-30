extends Node2D

class_name PlayerManager

signal update_inventory

@export var tank_manager: TankManager

var inventory_entities: Array[EntityData]

func _ready():
	var profit_timer: Timer = Timer.new()
	add_child(profit_timer)
	profit_timer.start(1)
	profit_timer.connect("timeout",generate_revenue)
	
	#starting cash - for test purposes
	PlayerData.player_money = 50
	PlayerData.player_substrate = 200

func generate_revenue():
	PlayerData.player_revenue = 0
	
	for entity in tank_manager.entities.get_children():
		if entity.has_method("calculate_revenue"):
			PlayerData.player_revenue += entity.calculate_revenue()
	
	PlayerData.player_money += PlayerData.player_revenue

func on_entity_purchased(entity_data: EntityData):
	inventory_entities.append(entity_data)
	emit_signal("update_inventory")
