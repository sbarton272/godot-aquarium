extends TankEntity

@export var food_upkeep: int
@export var entertainment: int
@export var sociability: int

func _ready():
	pass

func calculate_revenue() -> int:
	return entertainment - food_upkeep
