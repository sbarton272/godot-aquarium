extends TankEntity

var fish_name: String
var cost: int
var food_upkeep: int
var entertainment: int
var sociability: int

func _ready():
	entertainment = data.entertainment

func calculate_revenue() -> int:
	return entertainment
