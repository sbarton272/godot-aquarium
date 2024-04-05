extends Node2D

var is_held: bool = true
var current_slot: Node2D

func _ready():
	var slots: Array[Node] = $PlacementSlots.get_children()
	for slot in slots:
		slot.add_to_group("KelpPlacementSlots")
		slot.my_group_name = "KelpPlacementSlots"
		print(slot," is in kelp placement slots group")

func _process(delta):
	
	#this needs to be reorganized:
	#right now, if you let go of the mouse, the object will just hover on the mouse
	#then, when you are near a placement slot, it'll lock itself in
	#needs to disappear if you let go of the mouse without being near a slot
	#same issue with kelp
	#kelp and rock should both have a "placement"-type component
	#to fix and improve without duplicating across two very similar scripts
	
	if is_held:
		var slots: Array[Node] = get_tree().get_nodes_in_group("RockPlacementSlots")
		var closest_pos: Vector2 = slots[0].global_position
		current_slot = slots[0]
		for slot in slots:
			if get_global_mouse_position().distance_to(slot.global_position) < get_global_mouse_position().distance_to(closest_pos):
				closest_pos = slot.global_position
				current_slot = slot
		if get_global_mouse_position().distance_to(closest_pos) < 100:
			position = closest_pos
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) == false:
				is_held = false
				current_slot.slot_filled()
		else:
			position = get_global_mouse_position()
