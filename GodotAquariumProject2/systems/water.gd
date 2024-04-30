extends Polygon2D

@export var tank_background_sprite: Sprite2D
@export var tank_manager: TankManager

@onready var max_x: float = tank_background_sprite.get_rect().end.x
@onready var min_x: float = -tank_background_sprite.get_rect().end.x
@onready var max_y: float = tank_background_sprite.get_rect().end.y
@onready var min_y: float = -tank_background_sprite.get_rect().end.y
@onready var water_width: float = max_x - min_x

@export var y_variation: float

var point_count: int = 15

func _ready():
	draw_initial_water_polygon()

#this method sets up the points in the polygon. spawns a polygon that sits at the bottom of the screen
func draw_initial_water_polygon():
	var surface_points: PackedVector2Array = PackedVector2Array()
	
	for i in point_count:
		#we start 1 slot to the right of the top-left corner
		var x_pos: float = min_x + ((i+1)*(water_width/point_count))
		var new_point: Vector2 = Vector2(x_pos,max_y)
		surface_points.append(new_point)
	
	polygon = append_corners(surface_points)


func draw_water_polygon(level_diff: float):
	
	#adding points to a curve does not by default make the path curved
	#need to calculate intermediate points of curvature to add to the polygon
	#this would use a Curve2D with calculated in and out points (bezier curve)
	
	var water_curve: Curve = Curve.new()
	
	#get surface points, ignoring corners
	for point_index in point_count:
		water_curve.add_point(polygon[point_index],3,3,Curve.TANGENT_LINEAR,Curve.TANGENT_LINEAR)
	
	water_curve.bake()
	
	var surface_points: PackedVector2Array = PackedVector2Array()
	
	for i in point_count:
		var x_pos: float = min_x + (i+1)*(water_width/point_count)
		var new_point: Vector2 = Vector2(x_pos,water_curve.sample(x_pos)-level_diff)
		surface_points.append(new_point)
	
	#append to right and left corner or vice versa
	polygon = append_corners(surface_points)

func _process(delta):
	
	#this is what "moves" the water surface - next improvement would be to nudge it with collisions
	#instead of randomly changing y values
	for point_index in point_count:
		var old_y: float = polygon[point_index].y
		var variation: float = randf_range(-y_variation,y_variation) * delta
		var y_upper_limit: float = max_y - tank_manager.water_level + y_variation/2
		var y_lower_limit: float = max_y - tank_manager.water_level - y_variation/2
		var new_y: float = clamp(old_y + variation,y_lower_limit,y_upper_limit)
		polygon[point_index].y = new_y

func append_corners(points: PackedVector2Array) -> PackedVector2Array:
	var right_top_corner: Vector2 = Vector2(max_x,max_y-tank_manager.water_level)
	points.append(right_top_corner)
	var right_bottom_corner: Vector2 = Vector2(max_x,max_y)
	points.append(right_bottom_corner)
	var left_bottom_corner: Vector2 = Vector2(min_x,max_y)
	points.append(left_bottom_corner)
	var left_top_corner: Vector2 = Vector2(min_x,max_y-tank_manager.water_level)
	points.append(left_top_corner)
	
	return points
