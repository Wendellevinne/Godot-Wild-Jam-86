class_name MaskInteractable extends Area2D


func _on_body_entered(body: Node2D) -> void:
	collision_manager.process_collision(body, self)
	queue_free()
