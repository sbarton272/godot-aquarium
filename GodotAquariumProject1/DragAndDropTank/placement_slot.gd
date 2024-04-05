extends Node2D

var my_group_name: String

@onready var my_light: PointLight2D = $PointLight2D

func slot_filled():
	my_light.enabled = false
	self.remove_from_group(my_group_name)
