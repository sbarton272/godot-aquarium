extends Node2D

class_name TankManager

@export var substrate_particle_scene: PackedScene
@export var game_manager: GameManager

@onready var entities: Node2D = $Entities
@onready var substrate: Node2D = $Substrate

var placing_substrate: bool = false
var vacuuming_substrate: bool = false
var substrate_place_timer: Timer

func _ready():
	game_manager.connect("place_substrate_start",start_spawning_substrate)
	game_manager.connect("place_substrate_stop",stop_spawning_substrate)
	game_manager.connect("vacuum_substrate_start",start_vacuuming_substrate)
	game_manager.connect("vacuum_substrate_stop",stop_vacuuming_substrate)

func spawn_entity(entity_data: EntityData):
	var new_entity: TankEntity = entity_data.entity_scene.instantiate()
	new_entity.data = entity_data
	entities.add_child(new_entity)

func start_spawning_substrate():
	placing_substrate = true
	substrate_place_timer = Timer.new()
	substrate_place_timer.one_shot = false
	substrate_place_timer.connect("timeout",spawn_substrate)
	add_child(substrate_place_timer)
	substrate_place_timer.start(0.1)

func stop_spawning_substrate():
	placing_substrate = false
	substrate_place_timer.stop()

func spawn_substrate():
	if PlayerData.player_substrate > 0:
		var new_substrate: Node2D = substrate_particle_scene.instantiate()
		new_substrate.global_position = get_global_mouse_position()
		new_substrate.tank_manager = self
		substrate.add_child(new_substrate)
		PlayerData.player_substrate -= 1
	else:
		stop_spawning_substrate()

func start_vacuuming_substrate():
	vacuuming_substrate = true

func stop_vacuuming_substrate():
	vacuuming_substrate = false
