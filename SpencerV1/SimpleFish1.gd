extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# How to get parent size?
	var rand_x: int = randi() % 700 - 350
	var rand_y: int = randi() % 400 - 200
	$".".position = Vector2(rand_x, rand_y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
