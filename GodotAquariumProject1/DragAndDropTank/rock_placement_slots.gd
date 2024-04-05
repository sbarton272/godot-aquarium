extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var slots: Array[Node] = get_children()
	for slot in slots:
		slot.add_to_group("RockPlacementSlots")
		slot.my_group_name = "RockPlacementSlots"
