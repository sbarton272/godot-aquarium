extends RigidBody2D

@export var my_sprite: Sprite2D
@export var textures: Array[CompressedTexture2D]
@export var bacteria_grow_time: float

var tank_manager: TankManager

var bacteria: float

@onready var starting_r: float = randf_range(0.8,0.9)
@onready var starting_g: float = randf_range(0.7,0.8)
@onready var starting_b: float = randf_range(0.8,0.9)

func _ready():
	my_sprite.modulate = Color(starting_r,starting_g,starting_b,1)
	bacteria = randf_range(0,0.1)

func _process(delta):
	if bacteria < 1:
		grow_bacteria(delta / bacteria_grow_time)

func grow_bacteria(delta):
	bacteria *= 1 + (delta)
	bacteria = clamp(bacteria,0,1)
	var index: int = int(roundf(bacteria*100.0)/25.0)
	my_sprite.texture = textures[index]
	var new_r: float = starting_r * clamp(1-bacteria,0.7,1)
	var new_g: float = starting_g * clamp(1-bacteria,0.7,1)
	var new_b: float = starting_b * clamp(1-bacteria,0.7,1)
	my_sprite.modulate = Color(new_r,new_g,new_b,1)

func vacuum():
	PlayerData.player_substrate += 1
	queue_free()

func _on_mouse_entered():
	if tank_manager.vacuuming_substrate:
		vacuum()
