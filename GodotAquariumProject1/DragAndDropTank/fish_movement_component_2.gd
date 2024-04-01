extends Node2D

var is_moving: bool = true
var facing: float
var speed: float = 50
var turn_speed: float
var move_time: float
var move_time_max: float

@onready var parent_object: Node2D = $".."
@onready var sprite: Sprite2D = $"../FishSprite"

func _ready() -> void:
	get_new_direction()
	is_moving = true

func _process(delta: float) -> void:
	if is_moving:
		move(delta)
	
	#keep fish within bounds
	if parent_object.position.x > draganddropglobals.max_x:
		parent_object.position.x = draganddropglobals.max_x
		
	if parent_object.position.x < draganddropglobals.min_x:
		parent_object.position.x = draganddropglobals.min_x
		
	if parent_object.position.y > draganddropglobals.max_y:
		parent_object.position.y = draganddropglobals.max_y
		
	if parent_object.position.y < draganddropglobals.min_y:
		parent_object.position.y = draganddropglobals.min_y

func move(delta: float):
	parent_object.position += Vector2.RIGHT.rotated(facing) * speed * delta
	facing += turn_speed
	parent_object.rotation = facing
	move_time += delta
	if move_time >= move_time_max:
		get_new_direction()

func get_new_direction():
	move_time = 0
	facing = randf_range(0, (2*PI))
	turn_speed = randf_range(-0.05,0.05)
	move_time_max = randf_range(0.5,5)
	if facing > PI/2 and facing < 3*PI/2:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
