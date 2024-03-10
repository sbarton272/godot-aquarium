extends Label


func _on_tank_result_entered() -> void:
	text = "Review"

func _on_tank_setup_entered() -> void:
	text = "Setup"

func _on_tank_spectate_entered() -> void:
	text = "Visiting Hours"
