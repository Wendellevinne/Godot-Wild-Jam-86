class_name CollisionManager extends Node

# Handles the collisions of the player with the enviroment. It uses a mask object to determine
# which function of player will be called
func process_collision(body: Player, collided_object: Area2D) -> void:

	if collided_object.is_in_group("SpeedMask"):
		body.change_character_movement(600, -250)
	elif collided_object.is_in_group("JumpMask"):
		body.change_character_movement(300, -800)
	elif  collided_object.is_in_group("AirDashMask"):
		body.enable_air_dash()
