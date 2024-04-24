extends Polygon2D

@export var tank_background_sprite: Sprite2D
@export var tank_manager: TankManager

@onready var max_x: float = tank_background_sprite.get_rect().end.x
@onready var min_x: float = -tank_background_sprite.get_rect().end.x
@onready var max_y: float = tank_background_sprite.get_rect().end.y
@onready var water_width: float = max_x - min_x

@export var y_variation: float

var point_count: int = 15

#this could be improved: take the difference between former and new water levels (can be returned in setter function in TankManager)
#add that difference to each point in the array
#re-set the array

#splines to connect the points?

func draw_water_polygon(level: float):
	var polygon_points: PackedVector2Array
	
	var left_corner_point: Vector2 = Vector2(min_x,max_y)
	polygon_points.append(left_corner_point)
	
	for i in point_count+1:
		var x_pos: float = min_x + i*(water_width/point_count)
		var new_point: Vector2 = Vector2(x_pos,max_y - level)
		polygon_points.append(new_point)
	
	var right_corner_point: Vector2 = Vector2(max_x,max_y)
	
	polygon_points.append(right_corner_point)
	
	polygon = polygon_points

func _process(delta):
	var polygon_points: PackedVector2Array = polygon
	if polygon_points.size() > 0:
		#don't include the index of the first and last point - those are the bottom corners
		var rand_point_index: int = randi_range(1,polygon_points.size()-2)
		var rand_point_y: float = polygon_points[rand_point_index].y
		var new_rand_point_y = clamp(rand_point_y + randf_range(-y_variation,y_variation)*delta,max_y - tank_manager.water_level - 30,max_y - tank_manager.water_level + 30)
		polygon_points[rand_point_index].y = new_rand_point_y
	polygon = polygon_points
