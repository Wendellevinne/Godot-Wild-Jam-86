extends Area2D



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_global"):
		$"..".restart_level()
		print("im in the player")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player_global"):
		$"..".restart_level()
		print("im in the player")
