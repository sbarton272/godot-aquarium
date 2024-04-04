extends Node2D

var is_held: bool = true

func _ready():
	var slots: Array[Node] = $PlacementSlots.get_children()
	for slot in slots:
		slot.add_to_group("KelpPlacementSlots")
		print(slot," is in kelp placement slots group")

func _process(delta):
	if is_held:
		var placement_markers: Array[Node] = get_tree().get_nodes_in_group("RockPlacementSlots")
		var closest_pos: Vector2 = placement_markers[0].position
		for marker in placement_markers:
			if get_global_mouse_position().distance_to(marker.position) < get_global_mouse_position().distance_to(closest_pos):
				closest_pos = marker.position
		position = closest_pos
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) == false:
			is_held = false
