extends Control

var first_level = preload("res://Scenes/main.tscn")

func _on_button_pressed() -> void:
	var root = get_tree().get_current_scene().get_parent()
	root.remove_child(root.get_child(root.get_child_count() - 1))
	root.add_child(first_level.instantiate())
