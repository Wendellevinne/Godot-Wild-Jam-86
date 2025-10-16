class_name Goal extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		collision_manager.process_collision(body, self)
		
