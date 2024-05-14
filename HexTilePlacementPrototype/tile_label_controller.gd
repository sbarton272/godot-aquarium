extends Label

var initial_position: Vector2

func _ready():
	initial_position = position
	position -= get_minimum_size()/2

func set_new_size(zoom: float):
	var new_font_size: int = roundi(12/zoom)
	set("theme_override_font_sizes/font_size",new_font_size)
	position = initial_position - get_minimum_size()/2
