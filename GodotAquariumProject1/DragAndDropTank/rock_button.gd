extends Button

signal clicked(scene: PackedScene)

@export var my_scene: PackedScene

func _on_button_down():
	clicked.emit(my_scene)
