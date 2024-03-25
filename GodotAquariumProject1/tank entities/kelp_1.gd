extends Node2D

class_name Kelp

const OXYGEN_CHANGE = 1

@onready var sprite: Sprite2D = $Sprite2D
@onready var mover: Mover = $Mover

var age: int = 0
var young_color: Color = Color.GREEN_YELLOW
var old_color: Color = Color.OLIVE

func _ready() -> void:
	sprite.modulate = young_color

func _on_tank_setup_entered():
	#grow the sprite and reposition so it's growing upwards,not out of both ends
	sprite.scale.y = 100 * pow(1.05,age)
	sprite.scale.x = 20 * pow(1.02,age)
	position.y -= 50 * (pow(1.05,age) - pow(1.05,age-1))
	
	#darken the sprite
	sprite.modulate = lerp(young_color,old_color,0.1*age)
	
	mover.hoverable = true

func _on_tank_spectate_entered():
	globals.oxygen += OXYGEN_CHANGE
	mover.hoverable = false
	
func _on_tank_result_entered():
	age += 1
