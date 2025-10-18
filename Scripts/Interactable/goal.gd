class_name Goal extends Area2D

# Goal signal. It sends a signal to the collision manager passing itself, so it can call the
# completed level function
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		collision_manager.process_collision(body, self)
		
