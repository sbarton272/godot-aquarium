extends TankEntity

@export var fish_name: String
var cost: int
var food_upkeep: int
var entertainment: int
var sociability: int

func _ready():
	entertainment = data.entertainment
	food_upkeep = data.food_upkeep

func calculate_revenue() -> int:
	return entertainment - food_upkeep
