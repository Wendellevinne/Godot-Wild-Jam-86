extends Label

func _process(delta: float) -> void:
	text = str($"../Timer".time_left)
