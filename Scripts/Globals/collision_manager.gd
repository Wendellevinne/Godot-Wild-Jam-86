class_name CollisionManager extends Node

func process_collision(body: Player, collided_object: Area2D) -> void:
	print("Colisão detectada na cena:", get_tree().current_scene.name)
	print("Objeto:", collided_object.name)
	print("Player:", body.name)

	if collided_object.is_in_group("SpeedMask"):
		body.change_character_movement(600, -250)
	elif collided_object.is_in_group("JumpMask"):
		body.change_character_movement(300, -800)
