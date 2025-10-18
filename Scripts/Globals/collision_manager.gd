class_name CollisionManager extends Node

@onready var main_scene: MainScene = get_tree().get_first_node_in_group("Main")

# Handles the collisions of the player with the enviroment. It uses a mask object to determine
# which function of player will be called
func process_collision(body: Player, collided_object: Area2D) -> void:

	if collided_object.is_in_group("SpeedMask"):
		body.change_move_speed(1500)
		
	elif collided_object.is_in_group("JumpMask"):
		body.change_jump_velocity(-1000)
		
	elif collided_object.is_in_group("AirDashMask"):
		body.enable_air_dash()
		
	elif collided_object.is_in_group("Goal"):
		main_scene.call_completed_level_scene()
