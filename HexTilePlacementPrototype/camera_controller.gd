extends Camera2D

signal zoom_changed(zoom: float)

var is_panning: bool = false

func _ready():
	var viewport_rect_size: Vector2 = get_viewport_rect().size
	position = viewport_rect_size/2

func _input(event: InputEvent):
	if event.is_action_released("mousewheel_up"):
		zoom += Vector2(0.1,0.1)
		emit_signal("zoom_changed",zoom.x)
	if event.is_action_released("mousewheel_down"):
		zoom -= Vector2(0.1,0.1)
		emit_signal("zoom_changed",zoom.x)
	if event.is_action_pressed("space_bar"):
		is_panning = true
	if event.is_action_released("space_bar"):
		is_panning = false
	if is_panning and event is InputEventMouseMotion:
		var mouse_movement: Vector2 = event.get_relative()/(1.6*zoom)
		position -= mouse_movement
