extends Node2D

var max_y: float = draganddropglobals.max_y

var speed: float = 100
var ray_start_pos: Vector2 = Vector2(0,3)

@onready var collision_area: Area2D = $Area2D
@onready var down_ray: RayCast2D = $Area2D/RayCast2D

# to improve performance:
# make the movement and ray detection part of a separate component
# when we hit the floor, delete the component
# when detecting a substrate particle that lacks the component, do the same
# allowing for "sideways" falling first as well

func _ready():
	pass

func _process(delta):
	down_ray.target_position = Vector2(0,speed * delta)
	
	if down_ray.is_colliding() == false and position.y < max_y:
		position.y += speed * delta
