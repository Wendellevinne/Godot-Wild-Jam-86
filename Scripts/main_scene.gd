class_name MainScene extends Node2D

@onready var hud = get_tree().get_first_node_in_group("HUD")

var main_menu = preload("res://Scenes/UI/main_menu.tscn")
var player = preload("res://Scenes/Player/player_controller.tscn")
var complete_scene = preload("res://Scenes/UI/complete_level_scene.tscn")
var failed_scene = preload("res://Scenes/UI/failed_level_scene.tscn")

func call_completed_level_scene() -> void:
	hud.get_node("Timer").queue_free()
	
	var complete_scene_instance = complete_scene.instantiate()
	hud.add_child(complete_scene_instance)
	
	_add_exit_button_signal(complete_scene_instance)
	_add_replay_button_signal(complete_scene_instance)
	_add_next_level_button_signal(complete_scene_instance)
		
	_destroy_level()

func _add_exit_button_signal(scene) -> void:
	if scene.has_signal("exit_button_pressed"):
		scene.exit_button_pressed.connect(close_game)

func _add_replay_button_signal(scene) -> void:
	if scene.has_signal("replay_button_pressed"):
		scene.replay_button_pressed.connect(replay_level)

func _add_next_level_button_signal(scene) -> void:
	if scene.has_signal("next_level_button_pressed"):
		scene.next_level_button_pressed.connect(load_next_level)

func load_next_level() -> void:
	print("Clicked")

func replay_level() -> void:
	print("Clicked")

func close_game() -> void:
	get_tree().quit()

func _destroy_level() -> void:
	for child in get_children():
		if not child.is_in_group("HUD"):
			child.queue_free()
