extends Node2D

@onready var kelp_sprite: Sprite2D = $KelpSprite

@export var kelp_frame: Array[Texture]

var is_held: bool = true

func _ready():
	var shader_material: ShaderMaterial = kelp_sprite.material as ShaderMaterial
	var rand_distance: float = randf_range(30,150)
	shader_material.set_shader_parameter("sway_distance",rand_distance)
	kelp_sprite.flip_h = randi_range(0,1)
	kelp_sprite.frame = randi_range(0,1)

func _process(delta):
	if is_held:
		var slots: Array[Node] = get_tree().get_nodes_in_group("KelpPlacementSlots")
		var closest_pos: Vector2 = slots[0].global_position
		for slot in slots:
			if get_global_mouse_position().distance_to(slot.global_position) < get_global_mouse_position().distance_to(closest_pos):
				closest_pos = slot.global_position
		position = closest_pos
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) == false:
			is_held = false
