extends Button

enum Supplies {SUBSTRATE,FOOD}

signal supplies_shop_button_pressed(supplies: Supplies, quantity: int, cost: int)

@export var supplies: Supplies
@export var quantity: int
@export var cost: int

func _on_pressed():
	emit_signal("supplies_shop_button_pressed",supplies,quantity,cost)
