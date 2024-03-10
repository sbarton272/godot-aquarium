extends Node2D

signal setup_entered
signal spectate_entered
signal result_entered

enum TankState {setup,spectate,result}

@onready var fish_scene: PackedScene = load("res://tank entities/fish_1.tscn")
@onready var kelp_scene: PackedScene = load("res://tank entities/kelp.tscn")
@onready var all_fish: Node2D = $AllFish
@onready var all_plants: Node2D = $AllPlants

var state: TankState = TankState.setup

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("fish_spawn") and state == TankState.setup:
		place_fish()
	if event.is_action_released("kelp_spawn") and state == TankState.setup:
		place_kelp()
	if event.is_action_released("advance_tank_state"):
		if state == TankState.setup:
			state = TankState.spectate
			spectate_entered.emit()
		elif state == TankState.spectate:
			state = TankState.result
			result_entered.emit()
		elif state == TankState.result:
			state = TankState.setup
			setup_entered.emit()

func place_fish():
	var new_fish = fish_scene.instantiate() as Fish
	new_fish.position = get_global_mouse_position()
	connect("setup_entered",new_fish._on_tank_setup_entered)
	connect("spectate_entered",new_fish._on_tank_spectate_entered)
	connect("result_entered",new_fish._on_tank_result_entered)
	all_fish.add_child(new_fish)
	
	globals.fish_count += 1

func place_kelp():
	var new_kelp = kelp_scene.instantiate() as Kelp
	new_kelp.position = get_global_mouse_position()
	connect("setup_entered",new_kelp._on_tank_setup_entered)
	connect("spectate_entered",new_kelp._on_tank_spectate_entered)
	connect("result_entered",new_kelp._on_tank_result_entered)
	all_plants.add_child(new_kelp)
	
	#globals.fish_count += 1
	

func _on_spectate_entered():
	print("Oxygen", globals.oxygen)
