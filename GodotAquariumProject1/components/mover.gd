extends Node2D

class_name Mover

#this will be a component that allows an item to be moved during the tank setup phase
#requires collisionshape2D to be attached as well
#when the area is entered, tween size and allow click and drag

@export var parent_sprite: Sprite2D
@export var parent_object: Node2D

@onready var parent_sprite_scale: Vector2 = parent_sprite.scale

var hoverable: bool = true
var draggable: bool = false

func _process(_delta: float) -> void:
	if draggable and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		parent_object.position = get_global_mouse_position()

func _on_mouse_entered() -> void:
	if not globals.is_hovering_mover:
		if hoverable:
			globals.is_hovering_mover = true
			resize(1.2)
			draggable = true

func _on_mouse_exited() -> void:
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		resize(1)
		globals.is_hovering_mover = false
		draggable = false

func resize(new_size: float):
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(parent_sprite,"scale",parent_sprite_scale * new_size,0.2)
