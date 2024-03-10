extends Node2D

class_name Fish

const OXYGEN_CHANGE = -1

var max_x: float
var min_x: float
var max_y: float
var min_y: float

var speed: float
var progress: float
var destination: Vector2
var strength: float

var is_moving: bool = false

@onready var curve: Curve2D = Curve2D.new()
@onready var fish_sprite: Sprite2D = $Sprite2D

@onready var tank_sprite = get_parent().get_parent().get_node("TankSprite")

@onready var mover: Mover = $Mover

func _ready() -> void:
	var tank_rect: Rect2 = tank_sprite.get_rect()
	max_x = tank_rect.end.x * tank_sprite.scale.x
	max_y = tank_rect.end.y * tank_sprite.scale.y
	min_x = -max_x
	min_y = -max_y
	
	set_new_path()
	set_random_speed()
	
	fish_sprite.modulate = Color(1,randf_range(0,1),randf_range(0,1),1)
	
	strength = randf_range(0, 1)

func _process(delta: float) -> void:
	if is_moving:
		move(delta)

func set_new_path():
	progress = 0
	curve.clear_points()
	
	#choose a random point anywhere
	destination = Vector2(randf_range(min_x,max_x),randf_range(min_y,max_y))
	
	#bezier curve points: opposite quadrants to wiggle (i.e. 0,0 to 1,1 uses controls 0,1 and 1,0 to wiggle)
	var start_control: Vector2 = position + (Vector2.RIGHT.rotated(randf_range(0,2 * PI) * randf_range(45,500)))
	var end_control: Vector2 = destination + (Vector2.RIGHT.rotated(randf_range(0,2 * PI) * randf_range(45,500)))
	
	curve.add_point(position,start_control)
	curve.add_point(destination,end_control)
	
	var path: Path2D = Path2D.new()
	path.curve = curve
	get_parent().add_child(path)

func set_random_speed():
	speed = randf_range(10,80)

func move(delta: float):
	progress += delta
	var new_pos = curve.sample_baked(progress * speed, true)
	position.x = clamp(new_pos.x,min_x,max_x)
	position.y = clamp(new_pos.y,min_y,max_y)
	
	if position.distance_to(destination) <= 10:
		set_new_path()
		set_random_speed()
	
	#this portion has an issue where it sets a new path but may linger within the area
	#and continue to generate paths until it just happens to bounce out
	if abs(position.x) >= max_x - 2 or abs(position.y) >= max_y - 2:
		set_new_path()
		set_random_speed()

func _on_tank_setup_entered():
	mover.hoverable = true

func _on_tank_spectate_entered():
	globals.oxygen += OXYGEN_CHANGE
	mover.hoverable = false
	set_new_path()
	set_random_speed()
	is_moving = true

func _on_tank_result_entered():
	is_moving = false


func _on_eating_radius_area_entered(area):

	var colliding_fish = area.get_parent() as Fish
	#print("collision:", area, " other: ", colliding_fish.strength, " us: ", strength)
	if colliding_fish.strength > strength:
		# Die :(
		queue_free()
