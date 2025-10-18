class_name Map extends TileMapLayer

# The ID of the level, which is used by the level manager in some of its functions
@export var level_id: int

# Value of the amount of time the player has to beat the level
@export var time_limit: float

# Return the value of the amount of time the player has to beat the level before losing
func get_time_limit() -> float:
	return time_limit
