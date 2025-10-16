class_name MainScene extends Node2D

@onready var hud = get_tree().get_first_node_in_group("HUD")

var main_menu = preload("res://Scenes/UI/main_menu.tscn")
var complete_scene = preload("res://Scenes/UI/complete_level_scene.tscn")
var failed_scene = preload("res://Scenes/UI/failed_level_scene.tscn")

func call_completed_level_scene() -> void:
	hud.get_node("Timer").queue_free()
	hud.add_child(complete_scene.instantiate())
	_destroy_scene()

func _destroy_scene() -> void:
	for child in get_children():
		if not child.is_in_group("HUD"):
			child.queue_free()
