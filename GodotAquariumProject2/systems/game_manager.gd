extends Node

class_name GameManager

signal open_fish_shop
signal open_supplies_shop
signal toggle_inventory
signal ui_panel_opened
signal place_substrate_start
signal place_substrate_stop
signal vacuum_substrate_start
signal vacuum_substrate_stop
signal pour_water_start
signal pour_water_end

@export var tank_manager: TankManager

func _ready():
	pass

func _input(event: InputEvent):
	
	#these are overlapping menus that need to be closed before another is opened
	if event.is_action_released("open_fish_shop"):
		emit_signal("ui_panel_opened")
		emit_signal("open_fish_shop")
		get_tree().paused = true
	if event.is_action_released("open_supplies_shop"):
		emit_signal("ui_panel_opened")
		emit_signal("open_supplies_shop")
		get_tree().paused = true
	
	if event.is_action_released("toggle_inventory"):
		emit_signal("toggle_inventory")
	
	if event.is_action_released("ui_cancel"):
		get_tree().paused = false
	
	if event.is_action_pressed("place_substrate"):
		emit_signal("place_substrate_start")
	if event.is_action_released("place_substrate"):
		emit_signal("place_substrate_stop")
	
	if event.is_action_pressed("vacuum_substrate"):
		emit_signal("vacuum_substrate_start")
	if event.is_action_released("vacuum_substrate"):
		emit_signal("vacuum_substrate_stop")
	
	if event.is_action_pressed("pour_water"):
		emit_signal("pour_water_start")
	if event.is_action_released("pour_water"):
		emit_signal("pour_water_end")
