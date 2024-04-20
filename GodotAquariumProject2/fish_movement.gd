extends Node2D

@export var parent_object: Node2D

@export var speed: float
@export var border_check_distance: float
@export var separation_min_distance: float
@export var neighbor_separation_weight: float
@export var neighbor_alignment_weight: float
@export var obstacle_avoidance_weight: float

@export var neighbor_detector: Area2D
@export var my_body: StaticBody2D

var velocity: Vector2

#grab tank bounds, with some extra margin
@onready var max_x: float = get_viewport_rect().size.x/2 - 20
@onready var min_x: float = -get_viewport_rect().size.x/2 + 20
@onready var max_y: float = get_viewport_rect().size.y/2 - 20
@onready var min_y: float = -get_viewport_rect().size.y/2 + 20

func _ready():
	velocity = Vector2.RIGHT.rotated(randf_range(0, 2 * PI)) * speed

func _process(delta):
	parent_object.position += velocity * delta
	parent_object.rotation = velocity.angle()
	
	var neighbor_bodies: Array[Node2D] = neighbor_detector.get_overlapping_bodies()
	
	if neighbor_bodies.size() > 1:
		
		var neighbor_vel_total_x: float
		var neighbor_vel_total_y: float
		
		for body in neighbor_bodies:
			if not body == my_body:
				#separate from any nearby neighbors
				if global_position.distance_to(body.global_position) < 30:
					var separation_direction: Vector2 = global_position - body.global_position
					velocity += separation_direction * neighbor_separation_weight * delta
				
				#get nearby neighbors' total velocities
				neighbor_vel_total_x += body.get_parent().get_node("FishMovementComponent").velocity.x
				neighbor_vel_total_y += body.get_parent().get_node("FishMovementComponent").velocity.y
		
		#use nearby neighbors total velocities to get an average velocity
		var neighbor_vel_avg_x: float = neighbor_vel_total_x/(neighbor_bodies.size()-1)
		var neighbor_vel_avg_y: float = neighbor_vel_total_y/(neighbor_bodies.size()-1)
		var neighbor_vel_avg: Vector2 = Vector2(neighbor_vel_avg_x,neighbor_vel_avg_y)
		
		#add average velocity of neighbors to my velocity
		velocity += neighbor_vel_avg * neighbor_alignment_weight * delta
	
	#move towards avg position of neighbors, either in current detection area or a wider area
	
	#finally, normalize the velocity with all the added vectors
	velocity = velocity.normalized() * speed
	
	
	#avoid tank borders - this should be updated to use raycasts to check for collisions with obstacles, so fish can avoid rocks, etc. too
	
	var current_dir: Vector2 = velocity.normalized()
	
	if dir_inside_bounds(current_dir):
		pass
	else:
		#randomly choose to check to the right or to the left
		var check_rotation: int
		if randi_range(1,10) > 5:
			check_rotation = 1
		else:
			check_rotation = -1
		#check increasing amounts of the chosen left/right rotation
		if dir_inside_bounds(current_dir.rotated((check_rotation * PI / 3))):
			velocity = velocity.normalized() + (current_dir.rotated((check_rotation * PI / 3)) * obstacle_avoidance_weight * delta)
			velocity *= speed
		elif dir_inside_bounds(current_dir.rotated((check_rotation * 2 * PI / 3))):
			velocity = velocity.normalized() + (current_dir.rotated((check_rotation * 2 * PI / 3)) * obstacle_avoidance_weight * delta)
			velocity *= speed
		elif dir_inside_bounds(current_dir.rotated((check_rotation * PI))):
			velocity = velocity.normalized() + (current_dir.rotated((check_rotation * PI)) * obstacle_avoidance_weight * delta)
			velocity *= speed
		elif dir_inside_bounds(current_dir.rotated((check_rotation * 4 * PI / 3))):
			velocity = velocity.normalized() + (current_dir.rotated((check_rotation * 4 * PI / 3)) * obstacle_avoidance_weight * delta)
			velocity *= speed
	
	
	#lock position to within tank
	if global_position.x > max_x:
		parent_object.position.x = max_x
	if global_position.x < min_x:
		parent_object.position.x = min_x
	if global_position.y > max_y:
		parent_object.position.y = max_y
	if global_position.y < min_y:
		parent_object.position.y = min_y

func dir_inside_bounds(dir: Vector2) -> bool:
	if (global_position + (dir * border_check_distance)).x > max_x \
	or (global_position + (dir * border_check_distance)).x < min_x \
	or (global_position + (dir * border_check_distance)).y > max_y \
	or (global_position + (dir * border_check_distance)).y < min_y :
		return false
	else: return true
