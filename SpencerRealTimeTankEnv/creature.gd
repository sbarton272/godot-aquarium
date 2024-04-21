extends Area2D

var speed = 30  # pxl / sec
var tank_size
var alive_sec = 0
var FREQUENCY = 1.0 / 60


func _ready():
	tank_size = get_viewport_rect().size
	print('ready')


func _process(delta):
	alive_sec += delta
	var velocity = Vector2.ZERO
	var velocity_delta = sin(alive_sec * FREQUENCY * 2 * PI)
	velocity.x += velocity_delta
	print(velocity_delta)
	velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, tank_size)
