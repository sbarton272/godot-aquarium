extends Node2D

@export var selectable_objects: Array[Node2D]

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not event.pressed:
			var mouse_pos = get_global_mouse_position()
			print(mouse_pos)
			for object in selectable_objects:
				var object_selectability: Selectability = object.get_node("Selectability") as Selectability
				var selection_area: Area2D = object_selectability.selection_area
				var selection_shape: CollisionShape2D = selection_area.get_node("CollisionShape2D")
				var selection_polygon: PackedVector2Array = selection_shape.get_polygon()
				if Geometry2D.is_point_in_polygon(mouse_pos,selection_polygon):
					print(str(object)+" selected")
