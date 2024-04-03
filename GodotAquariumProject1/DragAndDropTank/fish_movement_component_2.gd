extends Node2D

@export var parent_object: Node2D

var speed: float = 100
var velocity: Vector2

@onready var neighbor_detector: Area2D = $NeighborDetector

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
			if not body == $FishBody:
				var separation_direction: Vector2 = global_position - body.global_position
				velocity += separation_direction * delta
				neighbor_vel_total_x += body.get_parent().velocity.x
				neighbor_vel_total_y += body.get_parent().velocity.y
		
		var neighbor_vel_avg_x: float = neighbor_vel_total_x/(neighbor_bodies.size()-1)
		var neighbor_vel_avg_y: float = neighbor_vel_total_y/(neighbor_bodies.size()-1)
		var neighbor_vel_avg: Vector2 = Vector2(neighbor_vel_avg_x,neighbor_vel_avg_y)
		
		velocity = (velocity+(neighbor_vel_avg*delta)).normalized() * speed
		
		#next step: move towards avg position of neighbors, either in current detection area or a wider area
		#after that: raycast to avoid obstacles (different collision layer)
