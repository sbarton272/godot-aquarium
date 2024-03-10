extends Control

@onready var daily_label: Label = $DailyVisitorsLabel
@onready var total_label: Label = $TotalVisitorsLabel

func _on_tank_result_entered() -> void:
	daily_label.text = "Daily Visitors: " + str(globals.daily_spectator_count)
	total_label.text = "Total Visitors: " + str(globals.total_spectator_count)
	visible = true

func _on_tank_setup_entered() -> void:
	visible = false
