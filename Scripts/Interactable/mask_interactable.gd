class_name MaskInteractable extends Area2D

# Handles a mask entity in the world. It passes their info for the collision manager when a player 
# collides with it, and then it is destroyed
func _on_body_entered(body: Node2D) -> void:
	collision_manager.process_collision(body, self)
	queue_free()
